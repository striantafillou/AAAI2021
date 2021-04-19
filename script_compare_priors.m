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
nVarsOr=10; nLatent=5;nVars=nVarsOr-nLatent;
N=10000;doN =100;
nRCTs =1;
nIters =50;
[distsProb, distsIsAj, distsFAS, distsExp] = deal(nan(nIters,1));
pretreat=true;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];

if ~isfolder(folderMum);mkdir(folderMum);end

foldername= [folderMum filesep 'no_selection'];
for iter=1:nIters
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
load([folderMum filesep '_N' sprintf('%d',floor(N./1000)) 'K_iter_' num2str(iter) 'ispas.mat'], 'probHzDo', 'pag', 'possets');
allSets = possets;
nAllSets = size(possets, 1);
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
    [theta_i, logprobDegivDoHw(:, iRCT), algo] = scoreExperimentalAdjSets(allSets, eIMpost, domainCounts, expData,-1, 'nIters', 100);
    %pdists = [mean(abs(reshape(idTrue, [], 1) - squeeze(reshape(theta, [], 1, nAllSets)))) nan];


end
[~, bestAS] = max(sum(logprobDegivDoHw, 2));
pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(idPop, [], 1, nAllSets)))) nan];
if any(isnan(probHzDo));continue;end
[~, bestASProb] = max(sum(logprobDegivDoHw+probHzDo, 2));
[~, bestASIsAj] = max(sum(logprobDegivDoHw+~~probHzDo, 2));
distsFAS(iter) = pdists(bestAS);
distsProb(iter) = pdists(bestASProb);
distsIsAj(iter) = pdists(bestASIsAj);
idEst = cond_prob_mult(2, 1, expData, domainCounts);       
distsExp(iter) = mean(mean(abs(idTruePop-idEst)));

fprintf('Iter %d Dists: %.3f --%.3f --%.3f\n', iter, distsProb(iter), distsFAS(iter), distsIsAj(iter));

   %
end

%%
figure;ah=gca;
boxplot([distsProb, distsIsAj, distsFAS, distsExp]);
hold all;
plot(ah.XLim, repmat(nanmedian(distsFAS),1, 2) , 'r--')
xticklabels({'GR-GUP', 'GR-CUP',  'NGR',  '$D_{exp}$'})
set(gca,'TickLabelInterpreter','latex');


colors = colormap(lines);

h = findobj(ah,'Tag','Box');lh = length(h);
patch(get(h(1),'XData'),get(h(1),'YData'),colors(2,:),'FaceAlpha',.5);
patch(get(h(2),'XData'),get(h(2),'YData'),colors(1,:),'FaceAlpha',.5);
patch(get(h(3),'XData'),get(h(3),'YData'),colors(4,:),'FaceAlpha',.5);
patch(get(h(4),'XData'),get(h(4),'YData'),colors(7,:),'FaceAlpha',.5);

% patch(get(h(8),'XData'),get(h(8),'YData'),colors(7,:),'FaceAlpha',.5);
ylabel('$|\Delta \theta|$', 'Interpreter', 'latex','FontSize', 20)


hAxes = gca;
a = get(hAxes,'XTickLabel');  
set(hAxes,'XTickLabel',a,'fontsize',10,'FontWeight','bold')
set([hAxes.YAxis, hAxes.XAxis], ...
'FontName'   , 'Helvetica', ...
'FontSize'   , 14          );
hAxes.YLim=[-0.01 0.15];

fig = gcf;
%pbaspect([2 1 1])
% 
% set(gcf, 'PaperUnits', 'normalized')
% set(gcf, 'PaperPosition', [0 0 1 1])
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
saveas(fig, 'compare_priors', 'pdf')
%%

