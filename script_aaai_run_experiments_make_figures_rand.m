pretreat = false;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'nVars' num2str(nVars)];
if ~isfolder(folderMum);mkdir(folderMum);end

for iter=1:nIters
    script1_observational_data;
    run_isPosAS_oracle;
end


clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat
% no selection;
foldername= [folderMum filesep 'no_selection'];
if ~isfolder(foldername);mkdir(foldername);end
for iter=1:nIters
    random_dag_no_selection;
end
[fh1, distsMin, distsMax, distsFAS, distVW, distCC, distKL, distsExp] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat
times = nan(nIters, 1);
foldername= [folderMum filesep 'selection'];
if ~isfolder(foldername);mkdir(foldername);end
for iter=1:nIters
    random_dag_sel
end
[fh2,distsMin, distsMax, distsFAS, distVW, distCC, distKL, distsExp] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);
%
clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat
times = nan(nIters, 1);
foldername= [folderMum filesep 'latent_selection'];
if ~isfolder(foldername);mkdir(foldername);end
for iter=1:nIters
    random_dag_latent_selection
end
[fh3, distsMin, distsMax, distsFAS, distVW, distCC, distKL, distsExp] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);



%%
