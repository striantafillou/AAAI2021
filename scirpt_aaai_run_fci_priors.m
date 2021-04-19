
clear; clc;
comp = 'sot16.PITT';
code_path = ['C:\Users\' comp '\Dropbox\MATLAB\causal_graphs'];
addpath(genpath(code_path));
cd([code_path filesep 'causal_effects']);

%
% make dag, BN, data sets
nVarsOr=10; nLatent=4;nVars=nVarsOr-nLatent;
nIters=50;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
%%
for iter=1:nIters
    load([folderMum filesep 'dag_' num2str(iter)]);
    pag = FCI12(obsDataset, 'verbose', 0, 'maxK',5, 'alpha', 0.01, 'cons', true);
    % estimate P(Hz|Do)
    [possets, isPosAS, keepVars] = isPossibleAdjustmentSet12(pag, iter);
    
    nSets = size(possets, 1);
    noBidir= false;
    if isPosAS(nSets+1)==false
        noBidir=true;
    end
    trueAsP = false(1, nSets);
    for iSet =1:nSets
        curSet = find(possets(iSet, :));
        trueAsP(iSet) = isAdjustmentSet(1, 2, curSet, dag);
    end
    trueAsP(nSets+1) = ~any(trueAsP(1:nSets));
    nisAdjSet = false;
    if trueAsP(nSets+1)
        nisAdjSet=true;
    end
    
    save([folderMum filesep 'iter_' num2str(iter) '.mat'], 'pag','trueAsP', 'possets', 'isPosAS', 'noBidir', 'nisAdjSet');
    % run 
end
