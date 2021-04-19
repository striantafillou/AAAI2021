times = nan(1, nIters);
N=1000;
for iter=1:nIters 
    filename =[folderMum filesep 'N' sprintf('%d',floor(N./1000)) 'K_iter' sprintf('%d', iter) '.mat'];
    load([folderMum filesep 'dag_N10K_iter' num2str(iter)], 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*', 'times');
    obsDataset.data = obsDataset.data(1001:N+1000, :);
    obsDatasetOr.data = obsDatasetOr.data(1001:N+1000, :);
    save([folderMum filesep 'dag_N' sprintf('%d',floor(N./1000)) 'K_iter' num2str(iter)], 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*', 'times');
end