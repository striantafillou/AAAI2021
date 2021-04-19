
pretreat=true;
folderMum= [code_path filesep 'causal_effects' filesep 'experiments' filesep 'sim' filesep 'pretreat' filesep 'nVars' num2str(nVars)];

if ~isfolder(folderMum);mkdir(folderMum);end
for iter=1:nIters 
    script1_observational_data;
end
for iter=1:nIters
    run_isPosAS_oracle
end


clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat 
% no selection;
foldername= [folderMum filesep 'no_selection'];
if ~isfolder(foldername);mkdir(foldername);end
for iter=1:nIters
    random_dag_no_selection;
end
[fh1] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, false);

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat
foldername= [folderMum filesep 'selection'];
if ~isfolder(foldername);mkdir(foldername);end
for iter=1:nIters
    random_dag_sel
end
[fh2] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);

clearvars -except nIters nLatent nRCTs nVars nVarsOr comp code_path folder* N doN pretreat
times = nan(nIters, 1);
foldername= [folderMum filesep 'latent_selection'];
if ~isfolder(foldername);mkdir(foldername);end
for iter=1:nIters
    random_dag_latent_selection
end
[fh3] = makeFigAAAIoracle(folderMum, foldername, N, doN, nIters, true);



