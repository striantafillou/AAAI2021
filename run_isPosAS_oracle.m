

    load([folderMum filesep 'dag_N' sprintf('%d',floor(N./1000)) 'K_iter' num2str(iter)], 'dag', 'nodes*', 'isLatent', 'obsDataset*', 'domainCounts*', 'order*', 'idTruePop*');
    t=tic;
    mag = dag2mag(dag, isLatent);
    mag = mag(1:nVars, 1:nVars);
    oracleds.data = mag;
    oracleds.isAncestor = findancestors(mag);
    oracleds.type = 'oracle';
    oracleds.isLatent= isLatent(1:nVars);
    pag = FCI(oracleds, 'verbose', 0, 'maxK',5, 'alpha', 0.01, 'cons', true);


    % estimate P(Hz|Do)
    [possets, isPosAS, keepVars] = isPossibleAdjustmentSet12(pag, iter);
    
    nSets = size(possets, 1);
    noBidir= false;
    if isPosAS(nSets+1)==false
        noBidir=true;
    end
    trueAsP = false(1, nSets);
    for iSet =1:nSets
        curSet = find(possets(iSet, :));
        trueAsP(iSet) = isAdjustmentSet(1, 2, curSet, dag);
    end
    trueAsP(nSets+1) = ~any(trueAsP(1:nSets));
    nisAdjSet = false;
    if trueAsP(nSets+1)
        nisAdjSet=true;
    end
    times(iter, 2) = toc(t);
    save([folderMum filesep 'NoracleK_iter_' num2str(iter) 'ispas.mat'], 'pag','trueAsP', 'possets', 'isPosAS', 'noBidir', 'nisAdjSet', 'times');
    % run 

