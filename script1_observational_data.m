
filename =[folderMum filesep 'N' sprintf('%d',floor(N./1000)) 'K_iter' sprintf('%d', iter) '.mat'];
if isfile(filename)
    load(filename, 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*')
else
    t=tic;
    if pretreat
        dag = randomDagWith12PreTreatment(nVarsOr, maxParents);
    else
        dag = randomdagWith12(nVarsOr, maxParents);
    end
end

%printedgesdag(dag);
isLatent= false(1, nVars);
isLatent(nVars+1:nVarsOr) = true;
domainCountsOr =randi([2 2], 1, nVarsOr);

% nodesOr: with confounders.
[nodesOr, domainCountsOr, orderOr, rnodes] = dag2randBN2(dag, 'discrete', 'maxNumStates', domainCountsOr, 'minNumStates', domainCountsOr);
idTruePop = estimateDoProbJT(2,1, dag, nodesOr, domainCountsOr);

% simulate data with dummy nodes.
obsDatasetOr = simulatedata(nodesOr, N, 'discrete', 'domainCounts', domainCountsOr, 'isLatent', isLatent); % simulate data from original distribution
% observational data, learn dag, and BN
obsDataset = subdataset(obsDatasetOr);domainCounts=obsDataset.domainCounts;
times(iter,1) = toc(t);

save([folderMum filesep 'dag_N' sprintf('%d',floor(N./1000)) 'K_iter' num2str(iter)], 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*', 'times');
