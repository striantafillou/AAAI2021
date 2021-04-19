function [meanTimes, nas] = getMeanRunTime(folderMum,foldername, N, doN, nIters)

[meanTimes] = deal(nan(nIters,2));
for iter=1:nIters
    
    load([folderMum filesep 'dag_N' sprintf('%d',floor(N./1000)) 'K_iter' num2str(iter)], 'times');
    meanTimes(iter, 1) = times(iter);
    filename1 =[foldername filesep 'N' sprintf('%d',floor(N./1000)) 'K_doN' sprintf('%d',doN) '_iter' sprintf('%d', iter) '.mat'];
    %    
    load(filename1, 'times', 'nAllSets');
    meanTimes(iter, 2) = times(iter);
    nas(iter)= nAllSets;
    
end