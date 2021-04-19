function [theta_i, logprobDegivDoHw, logeq3, algo] = scoreExperimentalAdjSetsJTSelInf(adjSets, rnodespost, orderpost, ...
    selnodes_hat, seldag_hat, seldomainCounts_hat, expData, probHzDo, varargin)

nSampleIters = process_options(varargin, 'nIters', 100);
%marg_obs,marg_counts_exp, inExperimental,probHzDo,adag, rnodespost, orderpost, domainCounts,nSampleIters)

[nSets, nVars] = size(adjSets);
% estimate P(Z|selection)
nSelVars = size(seldomainCounts_hat, 2)-nVars;
selVars =nVars+1:nVars+nSelVars;
% we have already estimated [selnodes_hat2, seldag_hat, seldomainCounts_hat] = selectionBNhat(obsDataset, psels, inExperimental(1:nVars), 'dag', adag, 'nodes', mnodes);

logeq3 = nan(nSets, seldomainCounts_hat(1), nSampleIters);
logprobDegivDoHw = nan(nSets, seldomainCounts_hat(1));
Nexp0 =cond_counts_mult(2, 1, expData, seldomainCounts_hat(1:nVars))-1;

theta_i = nan(nSets, seldomainCounts_hat(2), seldomainCounts_hat(1),nSampleIters);
selnodes=selnodes_hat;
for iter=1:nSampleIters
    %sample from the posterior
    nodes_sample = sampleBNpost(rnodespost, orderpost, seldomainCounts_hat(1:nVars));
    selnodes(1:nVars) = nodes_sample;
    % make junction tree
    eIMselhat = tetradEIM(seldag_hat, selnodes, seldomainCounts_hat);
    jtalg_sel  = javaObject('edu.pitt.dbmi.custom.tetrad.lib.bayes.JunctionTree', eIMselhat);

    if iter==1
        for iSet=1:nSets
            curSet = find(adjSets(iSet,:));
            if isempty(curSet)
                % P(Y|do(X),S=1)= P(Y|X, S=1);
                for iX=1:seldomainCounts_hat(1)
                    theta_i(iSet, :,iX,  iter) = estimateCondProbJTvals(2, [1 selVars],[iX-1 ones(1, nSelVars)], jtalg_sel, 'analytic', true, 'domainCounts', seldomainCounts_hat);
                end
            else
                [pz, ~,configs]=  estimateCondProbJTvals(curSet, selVars, ones(1, nSelVars), jtalg_sel, 'analytic', true, 'domainCounts', seldomainCounts_hat);
                [theta_i(iSet, :,:,  iter)] =  estimateDoProbJTalgSel(2, 1, [curSet, selVars], jtalg_sel, pz', configs, seldomainCounts_hat);
            end
        end
            thetas = reshape(theta_i(:, :,:,  1), nSets, []);
            [~, uniqueSets, setInds]  = uniquetol(thetas, 'ByRows', true); % find unique sets
            setPos = uniqueSets(setInds);
    else
        for iSet=uniqueSets'
             curSet = find(adjSets(iSet,:));
            if isempty(curSet)
                 % P(Y|do(X),S=1)= P(Y|X, S=1);
                for iX=1:seldomainCounts_hat(1)
                    theta_i(iSet, :,iX,  iter) = estimateCondProbJTvals(2, [1 selVars],[iX-1 ones(1, nSelVars)], jtalg_sel, 'analytic', true, 'domainCounts', seldomainCounts_hat);
                end
                %theta_i(iSet, :,:,  iter) = estimateCondProbJT(2, 1, jtalg_sel,nVars, domainCounts);
            else
                [pz, ~,configs]=  estimateCondProbJTvals(curSet, selVars, ones(1, nSelVars), jtalg_sel, 'analytic', true, 'domainCounts', seldomainCounts_hat);
                [theta_i(iSet, :,:,  iter)] =  estimateDoProbJTalgSel(2, 1, [curSet, selVars], jtalg_sel, pz', configs, seldomainCounts_hat);
            end
        end
        for iSet =1:nSets
            if ~ismember(iSet, uniqueSets)
                theta_i(iSet, :,:,  iter) =theta_i(setPos(iSet), :,:,  iter);
             %   logeq3(iSet, :, iter) = logeq3(setPos(iSet), :, iter);
            end
        end
    end
end % for iter
%         
for iSet=1:nSets
    for iter=1:nSampleIters
        logeq3(iSet, :, iter)= sum(Nexp0.*log(squeeze(theta_i(iSet, :,:,  iter))));
    end
    for iVal=1:seldomainCounts_hat(1)        
        logprobDegivDoHw(iSet, iVal) = sumOfLogsV(squeeze(logeq3(iSet, iVal,:)))-log(nSampleIters);
    end
end
logprobDegivDoHw = [sum(logprobDegivDoHw, 2);sum(sum(gammaln(Nexp0+1))- gammaln(sum(Nexp0+1)),2)];

theta_i = mean(theta_i, 4);

if probHzDo==-1
    probHzDo = zeros(nSets+1,1);
    probHzDo(:)= 1; %/(length(uniqueSets)+1);
end
algo.probHzDo = probHzDo;
end
