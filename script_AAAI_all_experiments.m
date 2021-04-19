% conflict resolution with BADs
clear; clc;
comp ='sot16.PITT'; 
%comp ='sofia'
javaaddpath(['C:\Users\' comp '\Dropbox\MATLAB\causal_graphs\tetrad\custom-tetrad-lib-0.2.0.jar'])
import edu.cmu.tetrad.*
import java.util.*
import java.lang.*
import edu.cmu.tetrad.data.*
import edu.cmu.tetrad.search.*
import edu.cmu.tetrad.graph.*
import edu.cmu.tetrad.bayes.*

code_path = ['C:\Users\' comp '\Dropbox\MATLAB\causal_graphs'];
addpath(genpath(code_path));
cd([code_path filesep 'causal_effects']);


% make dag, BN, data sets
nVarsOr=10; nLatent=4;nVars=nVarsOr-nLatent;
N=10000;
nRCTs =1;
nIters =50;
new_obs = true; %no stored observational
maxParents=5;
pretreat=true;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
if ~isfolder(folderMum);mkdir(folderMum);end
fold_sel ={'no_selection', 'selection', 'latent_selection'};
script_sel = {'random_dag_no_selection', 'random_dag_sel', 'random_dag_latent_selection'};
times = nan(nIters, 2);
if new_obs
    for iter=1:nIters 
        script1_observational_data;
    end
    for iter=1:nIters
        run_isPosAS_oracle; % runs ASP to determine possible adjustmetn sets.
    end
end
%%
doN =100;
for iSelCond =1:3
    clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat fold_sel script_sel iSelCond
    % no selection;
    foldername= [folderMum filesep fold_sel{iSelCond}];
    if ~isfolder(foldername);mkdir(foldername);end
    cur_script = script_sel{iSelCond};
    for iter=1:nIters
        run(cur_script);
    end
    [fh] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, false);
end
