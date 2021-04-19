% if iter>1;filenameOld =[foldername filesep 'iter' sprintf('%d', iter-1) '.mat'];load(filenameOld);end
filename =[foldername filesep 'N' sprintf('%d',floor(N./1000)) 'K_doN' sprintf('%d',doN) '_iter' sprintf('%d', iter) '.mat'];
t=tic;
% generate dag, BN, pick observed, selected, inExperimental.
load([folderMum filesep 'dag_N' sprintf('%d',floor(N./1000)) 'K_iter' num2str(iter)], 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*');

[adag, dsj]= tetradFges12(obsDataset, 'pretreat', pretreat);
[adag, rnodespost, orderpost] = estimatePosteriorNodes(obsDataset, adag);
mnodes = dag2BNData(adag, obsDataset.data, obsDataset.domainCounts);
eIM = tetradEIM(adag, mnodes, domainCounts);

  % dirichlet posterior instantiated model
list= tetradList(nVars, domainCounts);
aGraph=dag2tetrad(adag,list, nVars); % graph
tBM= javaObject('edu.cmu.tetrad.bayes.BayesPm', aGraph);
eIMprior = edu.cmu.tetrad.bayes.DirichletBayesIm.symmetricDirichletIm(tBM, 1);
eIMpost= edu.cmu.tetrad.bayes.DirichletEstimator.estimate(eIMprior, dsj);% 

jtalg  = javaObject('edu.pitt.dbmi.custom.tetrad.lib.bayes.JunctionTree', eIM);

% find all sets, find true AS if it exists.
allpaths = onapathbetweenxandy(dag2mag(adag, false(1, nVars)), 1,2);
keepVars = setdiff(unique(allpaths(:, 2:end)), 0);
[allSets, nAllSets] = allSubsets(nVars, keepVars);
trueAS = false(nAllSets,1);
idPop = nan(domainCounts(2), domainCounts(1), nAllSets);
for iSet =1:nAllSets
    idPop(:, :, iSet) = estimateDoProbJTAdj(2, 1, find(allSets(iSet,:)), jtalg, nVars, domainCounts);
    if isAdjustmentSet(1, 2, find(allSets(iSet,:)), dag)
        trueAS(iSet)=1;
    end
end
logprobDegivDoHw = nan(nAllSets+1, nRCTs);
rcts = cell(1, nRCTs);

for iRCT =1:nRCTs
    % Experimental data, selection
    isSelected = false(1, nVarsOr);%nSelected=nan(nRCTs, 1);%isSelected(3)=1;
    % select selected vars at random;
    nSelected = 3;%randsample(1:3,1);
    selvars = sort(randsample(3:nVars, nSelected));
    isSelected(selvars) =true;
    inExperimental=isSelected;inExperimental(nVars+1:nVarsOr) =false;%inExperimental(1:2)=true;   
    % make selection dag - not adding selvars+1 now
    seldag = addSelectionVars(dag, isSelected, nVarsOr);
    [selnodes,seldomainCounts] = addSelectionNodes(nodesOr, isSelected, domainCountsOr, nVarsOr);
    %inExperimental = isSelected;    

    % randomly change distributions of root nodes and simulate selected RCT data.
    expDsSel = simulateDoDataSelinf(selnodes, seldag, 1,  0:domainCountsOr(1)-1, nVarsOr, isSelected, doN, 'discrete', 'domainCounts', seldomainCounts);
    expData = expDsSel.data(:, [1 2]);
    % estimated effect
    idEst = cond_prob_mult(2, 1, expDsSel.data, domainCountsOr);             
    % from the selected with inference
    idTrue =estimateDoProbJTSel(2, 1, seldag, selnodes, isSelected, seldomainCounts);
    %fprintf('Distance of estimated vs true: %.3f\n', pdist)%, pdist(iRCT,2));
    %fprintf('Distance of estimated vs true in pop: %.3f\n', mean(mean(abs(idTruePop-idEst))))%, pdist(iRCT,2));


    psels = cell(1, nVars);
    for iVar =1:nVars
        %for iRCT=1:nRCTs
        psels{1, iVar} = cond_prob_mult(iVar, [], expDsSel.data, seldomainCounts);    
        % marg_counts_exp{1, iVar} = cond_counts_mult(iVar, [], rcts(iRCT).expDsSel.data, domainCounts);    
        %end
    end

    rcts{iRCT}= struct('isSelected', isSelected, 'inExpermental', inExperimental, 'selvars', selvars, 'seldag', seldag, ...
        'selnodes', selnodes, 'seldomainCounts', seldomainCounts, 'expDsSel', expDsSel, ...
         'idEst', idEst, 'idTrue', idTrue);

    % estimate hat selnodes
    [selnodes_hat, seldag_hat, seldomainCounts_hat] = selectionBNhat(obsDataset, psels, inExperimental(1:nVars), 'dag', adag, 'nodes', mnodes);
    eIMselhat = tetradEIM(seldag_hat, selnodes_hat, seldomainCounts_hat);
    jtalg_sel_hat  = javaObject('edu.pitt.dbmi.custom.tetrad.lib.bayes.JunctionTree', eIMselhat);

    % run BADs
    if sum(inExperimental)==0
        [theta_i, logprobDegivDoHw(:, iRCT), algo, th_i_all] = scoreExperimentalAdjSets(allSets, eIMpost, domainCounts, expData,-1, 'nIters', 100);
    else
        [theta_i, logprobDegivDoHw(:, iRCT), algo, theta_i_all] = scoreExperimentalAdjSetsJTSelInf(allSets, rnodespost, orderpost, ...
        selnodes_hat, seldag_hat, seldomainCounts_hat, expData,-1, 'nIters', 100);
    end
    %pdists = [mean(abs(reshape(idTrue, [], 1) - squeeze(reshape(theta, [], 1, nAllSets)))) nan];


end
[~, bestAS] = max(sum(logprobDegivDoHw, 2));
pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(idPop, [], 1, nAllSets)))) nan];
minDists = min(pdists); maxDists=max(pdists); badsDists = pdists(bestAS);
times(iter) = toc(t);
fprintf('Iter %d, Dists: %.3f --%.3f --%.3f\n',iter,  minDists, badsDists, maxDists);
vars = whos;
varsnojava = vars(arrayfun(@(var) ~isjava(evalin('base', var.name)), vars));
save(filename, varsnojava.name);
