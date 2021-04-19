function [theta_i, logprobDegivDoHw, logeq3, theta_i_all,algo] = scoreExperimentalAdjSets(adjSets,eIMpost, domainCounts, expData, probHzDo, varargin)

nSampleIters = process_options(varargin, 'nIters', 100);
%marg_obs,marg_counts_exp, inExperimental,probHzDo,adag, rnodespost, orderpost, domainCounts,nSampleIters)

[nSets, nVars] = size(adjSets);

logeq3 = nan(nSets, domainCounts(1), nSampleIters);
logprobDegivDoHw = nan(nSets, domainCounts(1));
Nexp0 =cond_counts_mult(2, 1, expData, domainCounts(1:nVars))-1;

theta_i = nan(nSets, domainCounts(2), domainCounts(1),nSampleIters);

for iter=1:nSampleIters
    %if mod(iter, 10)==1
        %t=toc;
        %fprintf('Done with %d iterations, %d sets. %.3f sec\n', iter, nSets, t)
    %end
    dirSampler =  edu.pitt.dbmi.custom.tetrad.lib.bayes.DirichletSampler.sampleFromPosterior(eIMpost); 
    sjtalg=javaObject('edu.cmu.tetrad.bayes.JunctionTreeAlgorithm', dirSampler); % selection posterior


    for iSet=1:nSets
        curSet = find(adjSets(iSet,:));
        theta_i(iSet, :,:,  iter) =  estimateDoProbJTAdj(2, 1, curSet, sjtalg, nVars, domainCounts);
        logeq3(iSet, :, iter)= sum(Nexp0.*log(squeeze(theta_i(iSet, :,:,  iter))));
    end
end

for iSet=1:nSets
    for iVal=1:domainCounts(1)        
        logprobDegivDoHw(iSet, iVal) = sumOfLogsV(squeeze(logeq3(iSet, iVal,:)))-log(nSampleIters);
    end
end
%         
for iSet=1:nSets
    for iter=1:nSampleIters
        logeq3(iSet, :, iter)= sum(Nexp0.*log(squeeze(theta_i(iSet, :,:,  iter))));
    end
    for iVal=1:domainCounts(1)        
        logprobDegivDoHw(iSet, iVal) = sumOfLogsV(squeeze(logeq3(iSet, iVal,:)))-log(nSampleIters);
    end
end
logprobDegivDoHw = [sum(logprobDegivDoHw, 2);sum(sum(gammaln(Nexp0+1))- gammaln(sum(Nexp0+1)),2)];
theta_i_all = theta_i;
theta_i = mean(theta_i, 4);

if probHzDo==-1
    probHzDo = zeros(nSets+1,1);
    probHzDo(:)= 1; %/(length(uniqueSets)+1);
end
algo.probHzDo = probHzDo;
end
