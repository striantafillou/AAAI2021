function [possets, isProbAdjSet, keepSet] = isPossibleAdjustmentSet12(pag, fileno)
% function [possets, keepVars, isProbAdjSet] = isPossibleAdjustmentSet12(pag)
% possets: nSets x nVars boolean matrix, true denotes set membership
% isProbAdjSet: nSets+1 x 1 boolean vector, nSets+1 denotes H\nexists
% all latents must be in the end!!
    % control panel for asp solver
    if nargin==1
        fileno=1;
    end
    workdir = [ 'ASPcode' filesep];
    clingopath = [workdir 'util\clingo-5.2.0-win64\clingo.exe'];
    programpath = [workdir 'test_ind_adj.lp'];
    options = ' --enum-mode=bt --verbose=0 --quiet=0 --outf=1  -t 4,compete >';
    inpath_or = [workdir 'input_or' num2str(fileno) '.asp'];
    inpath = [workdir 'input' num2str(fileno) '.asp'];
    outpath = [workdir 'output'];
    % find possible paths
    nObs = size(pag.graph,1);
    allpaths = onapathbetweenxandy(pag.graph, 1,2);
    nodesBetween12 = setdiff(unique(allpaths(:, 2:end)), 0);
    %keepVars =[1 2 reshape(nodesBetween12,1, [])];
    loseVars = true(1, nObs-2);loseVars(nodesBetween12-2)=false;
 %   nKeep = size(keepVars,2);
% 
    nAllSets =2^(nObs-2);    
    keepSet = true(nAllSets, 1); % keep only sets with measured variables
%   
    setmembers = false(2^(nObs-2), nObs-2);
    for iSet=0:2^(nObs-2)-1
        setmembers(iSet+1, :)= bitand(iSet,2.^(0:nObs-2-1));
        if any(setmembers(iSet+1, loseVars))
            keepSet(iSet+1)=false;
        end
    end
    nSets= sum(keepSet);setinds = 1:nAllSets;setinds = setinds(keepSet);
    nModels=nan(nSets+1,1);
    writeAdjSetASPinput(pag,inpath_or);
    % write asp input file // all latent variable must be in the end!
    fprintf('%d sets\n', nSets)
    for iSet=1:nSets
        tic;
        copyfile(inpath_or, inpath);
        fid = fopen(inpath, 'a+');
        fprintf(fid, 'isadjset(%d).\n', setinds(iSet)-1);
        fclose(fid);
        system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); %toc
%     count the number of models.
        [status, cmdout] = system(['find /c /v "" ', outpath]);
        if(status~=1)
            scanCell = textscan(cmdout,'%s %s %u');
            nModels(iSet) = scanCell{3}(1);
            if nModels(iSet)==1; nModels(iSet)=0;end % if inconsistent, 0.
        else
            disp('Unable to determine number of lines in the file');
        end
        toc
    end

     % there is no adjustment set
    iSet=iSet+1;
    copyfile(inpath_or, inpath);
    fid = fopen(inpath, 'a+');
    fprintf(fid, '%s',sprintf('nisadjset(%d).\n',  0:nSets));
    fclose(fid);
    system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]);
    % count the number of models.
    [status, cmdout] = system(['find /c /v "" ', outpath]);
    if(status~=1)
        scanCell = textscan(cmdout,'%s %s %u');
        nModels(iSet) = scanCell{3};
        if nModels(iSet)==1; nModels(iSet)=0;end % if inconsistent, 0.
    else
        disp('Unable to determine number of lines in the file');
    end
    isProbAdjSet = nModels~=0;
    possets =  setmembers(keepSet, :);
    
   % possets = possets(isProbAdjSet(1:end-1), :);
    possets = [zeros(size(possets, 1), 2) possets];
end

