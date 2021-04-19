t =tic;
filename =[foldername filesep 'N' sprintf('%d',floor(N./1000)) 'K_doN' sprintf('%d',doN) '_iter' sprintf('%d', iter) '.mat'];

load([folderMum filesep 'dag_N' sprintf('%d',floor(N./1000)) 'K_iter' num2str(iter)], 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*');

[adag, dsj]= tetradFges12(obsDataset, 'pretreat', pretreat);
%adag = zeros(5); adag(1, 2)=1; adag(3, [1 2])=1; adag(4, 2)=1;adag(5, [1, 2])=1;
[adag, rnodespost, orderpost] = estimatePosteriorNodes(obsDataset, adag);
mnodes = dag2BNData(adag, obsDataset.data, domainCounts);
eIM = tetradEIM(adag, mnodes, domainCounts);
jtalg  = javaObject('edu.pitt.dbmi.custom.tetrad.lib.bayes.JunctionTree', eIM);

% dirichlet posterior instantiated model
list= tetradList(nVars, domainCounts);
aGraph=dag2tetrad(adag,list, nVars); % graph
tBM= javaObject('edu.cmu.tetrad.bayes.BayesPm', aGraph);
eIMprior = edu.cmu.tetrad.bayes.DirichletBayesIm.symmetricDirichletIm(tBM, 1);
eIMpost= edu.cmu.tetrad.bayes.DirichletEstimator.estimate(eIMprior, dsj);% 


%jtalg  = javaObject('edu.pitt.dbmi.custom.tetrad.lib.bayes.JunctionTree', eIM);

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

for iRCT =1:nRCTs %no selection
    % Experimental data, no selection
    % randomly change distributions of root nodes and simulate selected RCT data.
    expDs = simulateDoData(nodesOr, 1,  0:domainCountsOr(1)-1, doN, 'discrete', 'domainCounts', domainCounts);
    expData = expDs.data(:, [1 2]);
    % estimated effect
    idEst = cond_prob_mult(2, 1, expDs.data, domainCountsOr);             
    %fprintf('Distance of estimated vs true in pop: %.3f\n', mean(mean(abs(idTruePop-idEst))))%, pdist(iRCT,2));
    rcts{iRCT}= struct('expDsS', expDs, 'idEst', idEst);

    % run BADs
    [theta_i, logprobDegivDoHw(:, iRCT), ~,theta_i_all] = scoreExperimentalAdjSets(allSets, eIMpost, domainCounts, expData,-1, 'nIters', 100);
    %pdists = [mean(abs(reshape(idTrue, [], 1) - squeeze(reshape(theta, [], 1, nAllSets)))) nan];


end
[~, bestAS] = max(sum(logprobDegivDoHw, 2));
pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(idPop, [], 1, nAllSets)))) nan];
minDists = min(pdists); maxDists=max(pdists); badsDists = pdists(bestAS);
times(iter) = toc(t);
fprintf('Iter %d Dists: %.3f --%.3f --%.3f\n', iter, minDists, badsDists, maxDists);
vars = whos;
varsnojava = vars(arrayfun(@(var) ~isjava(evalin('base', var.name)), vars));
save(filename, varsnojava.name);
