function [logprobDegivDoHw, logscore_i, theta_is, cmbconfigs, nConfigs, Nexp0, sets] = scoreExperimentalData(y, x,  mby,eIMpost, domainCounts, expData,  varargin)
% Score P(Y|do(x),CMB_X(Y)), when Dobs and Dexp have teh same variables.
nSampleIters = process_options(varargin, 'nIters', 100);
%marg_obs,marg_counts_exp, inExperimental,probHzDo,adag, rnodespost, orderpost, domainCounts,nSampleIters)
%let's say we have, cmbe, cmbo, ncmbe
nVars = size(domainCounts, 2);
[sets, nSets] = allSubsets(nVars, mby);
sets(:, x) = true;
keepVars = [x mby];
[curSet, Nexp0, cmbconfigs, nConfigs] = deal(cell(1, nSets));
theta_is = nan(nSets, domainCounts(y), prod(domainCounts([2 keepVars])), nSampleIters);
logscore_i = nan(nSets, prod(domainCounts([2 keepVars])), nSampleIters);
logscore_config= nan(nSets, prod(domainCounts([2 keepVars])));
for iSet=1:nSets
    curSet{iSet} = find(sets(iSet,:));
    [~, ~, cmbconfigs{iSet}, Nexp0{iSet}] = cond_prob_mult_inst(2, [curSet{iSet}], expData, domainCounts(1:nVars));
    nConfigs{iSet} = size(cmbconfigs{iSet}, 1);
end
for iter=1:nSampleIters 
    dirSampler =  edu.pitt.dbmi.custom.tetrad.lib.bayes.DirichletSampler.sampleFromPosterior(eIMpost); 
    sjtalg=javaObject('edu.cmu.tetrad.bayes.JunctionTreeAlgorithm', dirSampler); % selection posterior
    for iSet=1:nSets 
        [theta_is(iSet, :, 1:nConfigs{iSet}, iter)]=  estimateCondProbJT(2, [curSet{iSet}], sjtalg, nVars, domainCounts);
        % logscore_i = \sum_y log(\theta_y^Ny) = \sum_y (Ny*log \theta_y)
        logscore_i(iSet, 1:nConfigs{iSet}, iter)= sum(Nexp0{iSet}.*log(squeeze(theta_is(iSet, :, 1:nConfigs{iSet}, iter))));
    end
end




for iSet=1:nSets
    for iConfig =1:nConfigs{iSet}
        logscore_config(iSet, iConfig) = sumOfLogsV(squeeze(logscore_i(iSet, iConfig, :))) -log(nSampleIters);
    end
end

ne = Nexp0{1};
logprobDegivDoHw = [nansum(logscore_config, 2);sum(gammaln(domainCounts(y))+sum(gammaln(ne+1))- gammaln(sum(ne+1)), 2)];
end
