function [idVWS, idOpt, idCC,z, zOpt] = disjAS(obsDataset, trueDag, isLatent)
% vW and Shpitser, disjunctive, idCommon cause
dag = trueDag;
isAnc = transitiveClosureSparse_mex(sparse(dag));
ancY = isAnc(:, 2);ancY(1)=false;
ancX = isAnc(:, 1);

z = find(ancY|ancX);
z = reshape(z(~isLatent(z)), 1, []);
idVWS = backdoor_adjustment(2, 1, z, [], obsDataset, obsDataset.domainCounts) 

ds.data = dag2mag(dag, isLatent);
ds.isAncestor = isAnc;%transitiveClosureSparse_mex(sparse(trueDag));
ds.isLatent = isLatent;
zOpt = pruneAdjSet(z, ds);
%z = find(ancY&ancX);
%z = reshape(z(~isLatent(z)), 1, []);
idOpt = do_prob_adj(2, 1, zOpt, obsDataset, obsDataset.domainCounts); 

zc = find(ancY&ancX);
zc = reshape(zc(~isLatent(zc)), 1, []);
idCC = do_prob_adj(2, 1, z, obsDataset, obsDataset.domainCounts)
end

% dag = trueDag;
% dag(1, :)=0;
% isAnc = transitiveClosureSparse_mex(sparse(dag));
% ancY = isAnc(:, 2);ancY(1)=false;
% ancX = isAnc(:, 1);
% 
% z = find(ancY|ancX);
% z = reshape(z(~isLatent(z)), 1, []);
% idVWS = do_prob_adj(2, 1, z, obsDataset, obsDataset.domainCounts); 
% 
% ds.data = dag2mag(dag, isLatent);
% ds.isAncestor = transitiveClosureSparse_mex(sparse(trueDag));
% ds.isLatent = isLatent;
% zOpt = pruneAdjSet(z, ds);
% %z = find(ancY&ancX);
% %z = reshape(z(~isLatent(z)), 1, []);
% idOpt = do_prob_adj(2, 1, zOpt, obsDataset, obsDataset.domainCounts); 
% 
% zc = find(ancY&ancX);
% zc = reshape(zc(~isLatent(zc)), 1, []);
% idCC = do_prob_adj(2, 1, zc, obsDataset, obsDataset.domainCounts); 
