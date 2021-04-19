function [logprobDegivDoHw, logprobDegivDoHn,  logscore_config,  logscore_config_weak,cmbconfigs,  nConfigs, Nexp0, sets] = ...
    scoreExperimentalDataCMBCF(y, x,  mby, Nobs0, domainCounts, expData,  varargin)
% Score P(Y|do(x),CMB_X(Y)), when Dobs and Dexp have teh same variable,
% using closed-form solutions for \int_\theta P(D|\theta)f(\theta)
nVars = size(obsData, 2);
[sets, nSets] = allSubsets(nVars,mby);
sets(:, x) = true;
%keepVars = [x mby];

%[curSet, Nexp0,Nobs0 ,cmbconfigs, nConfigs] = deal(cell(1, nSets));
[curSet, Nexp0,cmbconfigs, nConfigs] = deal(cell(1, nSets));
for iSet=1:nSets
    fprintf('iSet %d-----------\n', iSet)
    curSet{iSet} = find(sets(iSet,:));
    [~, ~, cmbconfigs{iSet}, Nexp0{iSet}] = cond_prob_mult_inst(y, [curSet{iSet}], expData, domainCounts(1:nVars));
    [~, ~, cmbconfigs{iSet}, Nobs0{iSet}] = cond_prob_mult_inst(y, [curSet{iSet}], obsData, domainCounts(1:nVars));

    nConfigs{iSet} = size(cmbconfigs{iSet}, 1);
end
[logscore_config, logscore_config_weak] = deal(nan(nSets,  nConfigs{iSet}));

for iSet=1:nSets       
    for iConfig=1:nConfigs{iSet}
    logscore_config(iSet, iConfig)= dirichlet_bayesian_score(Nexp0{iSet}(:, iConfig), Nobs0{iSet}(:, iConfig));
    logscore_config_weak(iSet, iConfig)= dirichlet_bayesian_score(Nexp0{iSet}(:, iConfig), zeros(2, 1));

    end
end
% 
% 
% for iConfig=1:nConfigs{1}
%     logscore_config(nSets+1, iConfig)= dirichlet_bayesian_score(Nexp0{1}(:, iConfig), zeros(2, 1));
% end
% 
% 
% 
% for iConfig=1:nConfigs{nSets}
%     logscore_config(nSets+1, iConfig)= dirichlet_bayesian_score(Nexp0{nSets}(:, iConfig), zeros(2, 1));
% end
logprobDegivDoHw = nansum(logscore_config,2);
logprobDegivDoHn = nansum(logscore_config_weak,2);
% 
% end
