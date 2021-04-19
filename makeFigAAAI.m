function [fh, distsFAS] = makeFigAAAI(folderMum, foldername, N, doN, nIters, isSel)

[distsMin, distsMax, distsFAS, rtimes, distVW, distCC, distKL, distsExp] = deal(nan(nIters,1));

for iter=1:nIters
    filename =[foldername filesep 'N' sprintf('%d',floor(N./1000)) 'K_doN' sprintf('%d',doN) '_iter' sprintf('%d', iter) '.mat'];
    %filename =[foldername filesep 'iter' sprintf('%d', iter) '.mat'];
    
    if isSel
    load(filename, 'idTruePop', 'nAllSets', 'bestAS', 'obsDataset', 'dag', 'isLatent', 'allSets', 'idPop', 'expData', 'domainCounts', 'times')    
    pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(idPop, [], 1, nAllSets)))) nan];
    else
    load(filename, 'idTruePop','theta_i', 'nAllSets', 'bestAS', 'obsDataset', 'dag', 'isLatent', 'allSets', 'expData', 'domainCounts', 'times')    
    pdists = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(theta_i, nAllSets, [], 1))')) nan];

    end
    
    %distsMin(iter) = min(pdists); distsMax(iter)=max(pdists); 
   fname =[folderMum filesep '_N' sprintf('%d',floor(N./1000)) 'K_iter_' num2str(iter) 'ispas.mat'];
   [distsMin(iter), distsMax(iter)] = estimateMinMaxPag(fname, obsDataset, domainCounts,idTruePop); 

    distsFAS(iter) = pdists(bestAS);
    rtimes(iter) = times(iter);
    [idVW, idCC] = disjAS(obsDataset, dag, isLatent);
    distVW(iter) = mean(mean(abs(idTruePop-idVW)));
    distCC(iter) = mean(mean(abs(idTruePop-idCC)));
    kldivs = nan(nAllSets,1);
   idEst = cond_prob_mult(2, 1, expData, domainCounts);             

    for iSet=1:nAllSets
        [kldivs(iSet), pests(:, :, iSet)] = estimateKLdiv(1, 2, find(allSets(iSet,:)), idEst, obsDataset, domainCounts);
    end
    [~, bkl] = min(kldivs);
    distKL(iter) = mean(mean(abs(idTruePop-pests(:,:, bkl))));
    distsExp(iter) = mean(mean(abs(idTruePop-idEst)));
end
figure;ah=gca;
boxplot([distVW, distsMin distsMax distsFAS, distKL, distsExp]);
hold all;
plot(ah.XLim, repmat(nanmedian(distsFAS),1, 2) , 'r--')
xticklabels({'VW\&S', 'BDmin', 'BDmax', 'FAS',  'KL', '$D_{exp}$'})
set(gca,'TickLabelInterpreter','latex');


colors = colormap(lines);

h = findobj(ah,'Tag','Box');lh = length(h);
patch(get(h(1),'XData'),get(h(1),'YData'),colors(1,:),'FaceAlpha',.5);
patch(get(h(2),'XData'),get(h(2),'YData'),colors(2,:),'FaceAlpha',.5);
patch(get(h(3),'XData'),get(h(3),'YData'),colors(3,:),'FaceAlpha',.5);
patch(get(h(4),'XData'),get(h(4),'YData'),colors(4,:),'FaceAlpha',.5);
patch(get(h(5),'XData'),get(h(5),'YData'),colors(4,:),'FaceAlpha',.5);
patch(get(h(6),'XData'),get(h(6),'YData'),colors(5,:),'FaceAlpha',.5);

ylabel('$\Delta \theta$', 'Interpreter', 'latex','FontSize', 20)


hAxes = gca;
a = get(hAxes,'XTickLabel');  
set(hAxes,'XTickLabel',a,'fontsize',10,'FontWeight','bold')
set([hAxes.YAxis, hAxes.XAxis], ...
'FontName'   , 'Helvetica', ...
'FontSize'   , 16          );
hAxes.YLim=[-0.001 0.4];

fig = gcf;

fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

saveas(gcf, [foldername filesep 'fig'], 'fig')
fh=gcf;
end