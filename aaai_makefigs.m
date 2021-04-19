% conflict resolution with BADs
clc;close all
comp ='sot16.PITT'; 

code_path = ['C:\Users\' comp '\Dropbox\MATLAB\causal_graphs'];
addpath(genpath(code_path));
cd([code_path filesep 'causal_effects']);

%
% make dag, BN, data sets
nVarsOr=10; nLatent=4;nVars=nVarsOr-nLatent;
N=10000;doN =100;
nRCTs =1;
nIters =50;

expDists = nan(nIters, nRCTs);
% make savefolder
%expDists = nan(nIters, nRCTs);
%[minDists, maxDists, badsDists, times] = deal(nan(nIters,1));
% make savefolder
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
saveFolder = 'C:\Users\sot16.PITT\Dropbox\Apps\Overleaf\Learning Adjustment Sets with Selection Bias (AAAI)\figures';
foldername= [folderMum filesep 'no_selection'];
[fh, df] = makeFigAAAI(folderMum,foldername, N, doN, nIters, false);
%saveas(fh, [saveFolder  filesep 'nosel_pre'], 'pdf')


foldername= [folderMum filesep 'selection'];
fh = makeFigAAAI(folderMum,foldername, N, doN, nIters, true);
%saveas(fh, [saveFolder  filesep 'sel_pre'], 'pdf')

foldername= [folderMum filesep 'latent_selection'];
fh = makeFigAAAI(folderMum,foldername, N, doN, nIters, true);
%saveas(fh, [saveFolder  filesep 'lsel_pre'], 'pdf')

%%
close all
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'nVars' num2str(nVars)];
foldername= [folderMum filesep 'no_selection'];
[fh, df] = makeFigAAAI(folderMum,foldername, N, doN, nIters, false);
saveas(fh, [saveFolder  filesep 'nosel'], 'pdf')


foldername= [folderMum filesep 'selection'];
fh = makeFigAAAI(folderMum,foldername, N, doN, nIters, true);
saveas(fh, [saveFolder  filesep 'sel'], 'pdf')

foldername= [folderMum filesep 'latent_selection'];
fh = makeFigAAAI(folderMum,foldername, N, doN, nIters, true);
saveas(fh, [saveFolder  filesep 'lsel'], 'pdf')

% set([leg1], ...
% 'FontName'   , 'Helvetica', ...
% 'FontSize'   , 12          );

