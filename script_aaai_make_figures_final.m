% conflict resolution with BADs
clear; clc;close all;
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

code_path = ['C:\Users\' comp '\Dropbox\MATLAB'];
addpath(genpath(code_path));
cd([code_path filesep 'causal_effects']);


% make dag, BN, data sets
nVarsOr=10; nLatent=4;nVars=nVarsOr-nLatent;
N=10000;doN =100;
nRCTs =1;
nIters =50;
pretreat = true;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
saveFolder = 'C:\Users\sot16.PITT\Dropbox\Apps\Overleaf\Learning Adjustment Sets with Selection Bias (AAAI)\figures';
times=[];
if ~isfolder(folderMum);mkdir(folderMum);end

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d*
foldername= [folderMum filesep 'no_selection'];
if ~isfolder(foldername);mkdir(foldername);end
[fh1, df1] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, false);
saveas(fh1, [saveFolder  filesep 'nosel_pre'], 'pdf'), 
[mt, nas] = getMeanRunTime(folderMum, foldername, N, doN, nIters);
times = [times; mt];
%
clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d*
foldername= [folderMum filesep 'selection'];
if ~isfolder(foldername);mkdir(foldername);end
[fh2, df2,  dm2, dM2] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);
saveas(fh2, [saveFolder  filesep 'sel_pre'], 'pdf'), 
mt = getMeanRunTime(folderMum, foldername, N, doN, nIters);
mean(sum(mt,2))

times = [times; mt];

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d*
foldername= [folderMum filesep 'latent_selection'];
if ~isfolder(foldername);mkdir(foldername);end
[fh3, df3,dm3, dM3] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);
saveas(fh3, [saveFolder  filesep 'lsel_pre'], 'pdf'), 
mt = getMeanRunTime(folderMum, foldername, N, doN, nIters);
mean(sum(mt,2))
times = [times; mt];


pretreat = false;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'nVars' num2str(nVars)];
saveFolder = 'C:\Users\sot16.PITT\Dropbox\Apps\Overleaf\Learning Adjustment Sets with Selection Bias (AAAI)\figures';

if ~isfolder(folderMum);mkdir(folderMum);end

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times
foldername= [folderMum filesep 'no_selection'];
if ~isfolder(foldername);mkdir(foldername);end
[fh1, df1p] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, false);
saveas(fh1, [saveFolder  filesep 'nosel'], 'pdf'), 
mt = getMeanRunTime(folderMum, foldername, N, doN, nIters);
mean(sum(mt,2))
times = [times; mt];

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times
foldername= [folderMum filesep 'selection'];
if ~isfolder(foldername);mkdir(foldername);end
[fh2, df2p,  dm2, dM2] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);
saveas(fh2, [saveFolder  filesep 'sel'], 'pdf'), 
mt = getMeanRunTime(folderMum, foldername, N, doN, nIters);
mean(sum(mt,2))
times = [times; mt];


clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times
foldername= [folderMum filesep 'latent_selection'];
if ~isfolder(foldername);mkdir(foldername);end
[fh3, df3p,  dm2, dM2] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);
saveas(fh3, [saveFolder  filesep 'lsel'], 'pdf')
mt = getMeanRunTime(folderMum, foldername, N, doN, nIters);
mean(sum(mt,2))
times = [times; mt];
