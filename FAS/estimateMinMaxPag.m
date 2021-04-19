function [minDist, maxDist, posNA] = estimateMinMaxPag(filename, obsDataset, domainCounts, idTruePop)

   load(filename,  'possets', 'isPosAS');
   %fprintf('Iter %d, nsetsd: %d, nsetspag:%d\n',iter, nAllSets, sum(isPosAS));
   nSets= size(possets, 1);
   psets = possets(isPosAS(1:nSets), :); nPsets = size(psets,1);
   if nPsets==0
       minDist=nan;
       maxDist=nan;
   else
   pestpag = nan(nPsets-1, domainCounts(2), domainCounts(1));
   for iSet=1:nPsets
       for iX =1:domainCounts(1)
            pestpag(iSet, :, iX)= backdoor_adjustment(2, 1, find(psets(iSet,:)), iX-1, obsDataset);
       end
   end
  
   pdistspag = [mean(abs(reshape(idTruePop, [], 1) - squeeze(reshape(pestpag, nPsets, [], 1))')) nan];
   minDist = min(pdistspag);
   maxDist= max(pdistspag);
   end
   posNA = isPosAS(end);
end
   