function [fh, distsFAS, distsFASold,  distsMin, distsMax, distVW, distCC, distsKL, distsExp] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, isSel)

[distsMin, distsMax, distsFAS, rtimes, distVW, distCC, distsKL, distsExp, distOpt, distsFASold] = deal(nan(nIters,1));

for iter=1:nIters
    filename =[foldername filesep 'N' sprintf('%d',floor(N./1000)) 'K_doN' sprintf('%d',doN) '_iter' sprintf('%d', iter) '.mat'];
    %filename =[foldername filesep 'iter' sprintf('%d', iter) '.mat'];
    
    if isSel
    load(filename, 'idTruePop', 'nAllSets', 'bestAS', 'obsDataset', 'dag', 'isLatent', 'allSets', 'idPop', 'expData', 'domainCounts', 'times', 'theta_i_all')  
    pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(idPop, [], 1, nAllSets)))) nan];
    distsFAS(iter) = pdists(bestAS);
    else
    load(filename, 'idTruePop','theta_i', 'nAllSets', 'bestAS', 'obsDataset', 'dag', 'isLatent', 'allSets', 'expData', 'domainCounts', 'times', 'theta_i_all')    
    pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(theta_i, nAllSets, [], 1))')) nan];
    distsFAS(iter) = pdists(bestAS);
%     if isnan(pdists(bestAS)); distsFAS(iter) = distsFASold(iter);
%     else
%     exp_counts =cond_counts_mult(2, 1, expData, domainCounts)-1;
% %    [pydoxmm] = momentMatchingBeta(squeeze(theta_i_all(bestAS, :, :, :)), exp_counts);
%     distsFAS(iter) = [mean(abs(reshape(idTruePop, [], 1)-reshape(pydoxmm, [], 1)))];
%     end
    end
    
    %distsMin(iter) = min(pdists); distsMax(iter)=max(pdists); 
   fname =[folderMum filesep 'NoracleK_iter_' num2str(iter) 'ispas.mat'];
   [distsMin(iter), distsMax(iter), posNA(iter)] = estimateMinMaxPag(fname, obsDataset, domainCounts, idTruePop); 

    rtimes(iter) = times(iter);
    [idVW, idOpt,  idCC] = disjAS(obsDataset, dag, isLatent);
    distVW(iter) = mean(mean(abs(idTruePop-idVW)));
    distCC(iter) = mean(mean(abs(idTruePop-idCC)));
    distOpt(iter) = mean(mean(abs(idTruePop-idOpt)));

    kldivs = nan(nAllSets,1);
    idEst = cond_prob_mult(2, 1, expData, domainCounts);       

    for iSet=1:nAllSets
        [kldivs(iSet), pests(:, :, iSet)] = estimateKLdiv(1, 2, find(allSets(iSet,:)), idEst, obsDataset, domainCounts);
    end
    [~, bkl] = min(kldivs);
    distsKL(iter) = mean(mean(abs(idTruePop-pests(:,:, bkl))));
    distsExp(iter) = mean(mean(abs(idTruePop-idEst)));
end
if ~isSel
   distsFAS(isnan(distsFAS))= distsExp(isnan(distsFAS));
end
figure;ah=gca;
boxplot([distVW, distCC, distsMin distsMax, distsKL, distsExp distsFAS]);
hold all;
plot(ah.XLim, repmat(nanmedian(distsFAS),1, 2) , 'r--')
xticklabels({'VWS', 'HPM',  'BD$_{min}$', 'BD$_{max}$', 'KL'  '$D_{exp}$', 'FAS'})
set(gca,'TickLabelInterpreter','latex');


colors = colormap(lines);

h = findobj(ah,'Tag','Box');lh = length(h);
patch(get(h(1),'XData'),get(h(1),'YData'),colors(1,:),'FaceAlpha',.5);
patch(get(h(2),'XData'),get(h(2),'YData'),colors(2,:),'FaceAlpha',.5);
patch(get(h(3),'XData'),get(h(3),'YData'),colors(3,:),'FaceAlpha',.5);
patch(get(h(4),'XData'),get(h(4),'YData'),colors(4,:),'FaceAlpha',.5);
patch(get(h(5),'XData'),get(h(5),'YData'),colors(4,:),'FaceAlpha',.5);
patch(get(h(6),'XData'),get(h(6),'YData'),colors(5,:),'FaceAlpha',.5);
patch(get(h(7),'XData'),get(h(7),'YData'),colors(6,:),'FaceAlpha',.5);
% patch(get(h(8),'XData'),get(h(8),'YData'),colors(7,:),'FaceAlpha',.5);
ylabel('$|\Delta \theta|$', 'Interpreter', 'latex')


hAxes = gca;
a = get(hAxes,'XTickLabel');  
set(hAxes,'XTickLabel',a,'fontsize',10,'FontWeight','bold')
set([hAxes.YAxis, hAxes.XAxis], ...
'FontName'   , 'Helvetica', 'FontSize', 17)
hAxes.YLim=[-0.01 0.4];

fig = gcf;
%pbaspect([2 1 1])
% 
% set(gcf, 'PaperUnits', 'normalized')
% set(gcf, 'PaperPosition', [0 0 1 1])
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

saveas(gcf, [foldername filesep 'fig'], 'pdf')
fh=gcf;
sum(isnan(distsFAS))
end