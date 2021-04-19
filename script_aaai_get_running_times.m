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

code_path = ['C:\Users\' comp '\Dropbox\MATLAB\causal_graphs'];
addpath(genpath(code_path));
cd([code_path filesep 'causal_effects']);

N=10000;doN =100;
nRCTs =1;
nIters =30;
pretreat = true;
saveFolder = 'C:\Users\sot16.PITT\Dropbox\Apps\Overleaf\Learning Adjustment Sets with Selection Bias (AAAI)\figures\supplementary';

% make dag, BN, data sets
nVarsOr=10; nLatent=5;nVars=nVarsOr-nLatent;

folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
times=[];
clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d* prefix
foldername= [folderMum filesep 'no_selection'];
[mt, nas] = getMeanRunTime(folderMum, foldername, N, doN, nIters);
times = [times; mt];

allTimes(:, 1)= mean(times, 2);

nVarsOr=10; nLatent=4;nVars=nVarsOr-nLatent;

folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
times=[];
clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d* prefix allTimes
foldername= [folderMum filesep 'no_selection'];
[mt, nas] = getMeanRunTime(folderMum, foldername, N, doN, nIters);
times = [times; mt];

allTimes(:, 2) = mean(times, 2)


nVarsOr=12; nLatent=4;nVars=nVarsOr-nLatent;

folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
times=[];
clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d* prefix allTimes
foldername= [folderMum filesep 'no_selection'];
[mt, nas] = getMeanRunTime(folderMum, foldername, N, doN, nIters);
times = [times; mt];

allTimes(:, 3) = mean(times, 2)

nVarsOr=15; nLatent=5;nVars=nVarsOr-nLatent;

folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];
times=[];
clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat saveFolder df* times d* prefix allTimes
foldername= [folderMum filesep 'no_selection'];
[mt, nas] = getMeanRunTime(folderMum, foldername, N, doN, nIters);
times = [times; mt];

allTimes(:, 4) = mean(times, 2)

figure;ah=gca;
boxplot(log(allTimes));
hold all;
xticklabels({'5', '6',  '8', '10'});
set(gca,'TickLabelInterpreter','latex');

colors = colormap(lines);

h = findobj(ah,'Tag','Box');lh = length(h);
patch(get(h(1),'XData'),get(h(1),'YData'),colors(1,:),'FaceAlpha',.5);
patch(get(h(2),'XData'),get(h(2),'YData'),colors(2,:),'FaceAlpha',.5);
patch(get(h(3),'XData'),get(h(3),'YData'),colors(3,:),'FaceAlpha',.5);
patch(get(h(4),'XData'),get(h(4),'YData'),colors(4,:),'FaceAlpha',.5);
% patch(get(h(8),'XData'),get(h(8),'YData'),colors(7,:),'FaceAlpha',.5);
ylabel('Log Time(sec)', 'FontSize', 20)
xlabel('Number of Observed Variables', 'FontSize', 20)


hAxes = gca;
a = get(hAxes,'XTickLabel');  
set(hAxes,'XTickLabel',a,'fontsize',10,'FontWeight','bold')
set([hAxes.YAxis, hAxes.XAxis], ...
'FontName'   , 'Helvetica', ...
'FontSize'   , 14          );
%hAxes.YLim=[0 200];

fig = gcf;
%pbaspect([2 1 1])
% 
% set(gcf, 'PaperUnits', 'normalized')
% set(gcf, 'PaperPosition', [0 0 1 1])
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

saveas(gcf, [saveFolder filesep 'times'], 'pdf')
%fh=gcf;
