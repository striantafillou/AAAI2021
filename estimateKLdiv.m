function [kld, pest] = estimateKLdiv(x, y, z, idEst, obsDataset, domainCounts)
% [kld, pest] = estimateKLdiv(x, y, z, idEst, obsDataset, domainCounts)
% estimates KL divergence of estimate idEst and teh estimate for P(Y|do(X)) 
% using observational data and adjusting for z.

dcx = domainCounts(x); dcy = domainCounts(y);
kld = nan(1, dcx);
pest = nan(dcy,dcx);
for iX=1:dcx
    pest(:, iX)= backdoor_adjustment(y, x, z, iX-1, obsDataset);
    kld(iX) = kldiv([1:dcy]', pest(:, iX), idEst(:, iX));
end
kld =mean(kld);
end