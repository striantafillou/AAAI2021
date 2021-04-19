code_path = 'C:\Users\sot16.PITT\Dropbox\MATLAB\causal_graphs';
addpath(genpath(code_path));
cd([code_path filesep 'causal_effects']);
%%
% nVars=10; nLatent= 5;
% % generate_dag
% dag = randomdagWith12(nVars,3);
% printedgesdag(dag)
% isLatent= false(1, nVars);
% %whichLatent = randsample(nVars-nLatent, nLatent)+nLatent;
% isLatent(nVars-nLatent+1:nVars) = true;
% smm = dag2smm(dag, isLatent);
% printedgesmcg(smm)
% mag =smm2mag(smm);
% printedgesmcg(mag);
% [pag, dnc, col] = mag2pag(mag);
% 
%%
clc;
nVars=6; nLatent=2; nObs= nVars-nLatent;
dag= zeros(6);
dag(1, 2)=1;
dag(3, [1, 2])=1;
dag(5, [4, 1])=1;
dag(6, [4,2])=1;
mag = dag2mag(dag, [false false false false true true]);

[pag, dnc, col] = mag2pag(mag);
nSets =2^(nObs-2);
setmembers = false(2^(nObs-2), nObs-2);
for iSet=0:2^(nObs-2)-1
    setmembers(iSet+1, :)= bitand(iSet,2.^(0:nObs-2-1));
end
% control panel for asp solver
workdir = [code_path filesep 'causal_effects' filesep 'ASPcode' filesep];
clingopath = [workdir 'util\clingo-5.2.0-win64\clingo.exe'];
programpath = [workdir 'test_ind_adj.lp'];
options = '--enum-mode=bt  --configuration=many --models=0 --verbose=0 --quiet=0 --outf=1 -t 4,compete >';
inpath_or = [workdir 'input_or.asp'];
inpath = [workdir 'input.asp'];
outpath = [workdir 'output'];

% write asp input file
fid = fopen('ASPcode\input_or.asp', 'wt');
nObs = nVars-nLatent;
fprintf(fid, sprintf('nodes(%d).\n', nObs));
fprintf(fid, sprintf('sets(%d).\n', nObs));

for iVar=1:nObs-1
    for jVar=iVar+1: nObs
        if pag(iVar, jVar)~=0
            fprintf(fid, 'inducing(%d, %d).\n', iVar, jVar);
        else
            fprintf(fid, 'ninducing(%d, %d).\n', iVar, jVar);
        end
    end
end

for iVar=1:nVars
    if ~isempty(dnc{iVar})
        nDnc = size(dnc{iVar}, 1);
        curDnc = dnc{iVar};
        for iDnc=1:nDnc
            fprintf(fid, 'dnc(%d, %d, %d).\n', curDnc(iDnc, 1), iVar,  curDnc(iDnc, 2));
        end
    end
    
    if ~isempty(col{iVar})
        nCol = size(col{iVar}, 1);
        curCol = col{iVar};
        for iCol=1:nCol
            fprintf(fid, 'col(%d, %d, %d).\n', curCol(iCol, 1), iVar,  curCol(iCol, 2));
        end
    end
            
end
fprintf(fid, 'anc(1, 2).\n');
fprintf(fid, '#show directed/2.\n');fprintf(fid, '#show bidirected/2.\n');
fclose(fid);
% find all models
tic, system([clingopath ' ' programpath ' ' inpath_or ' ' options ' ' outpath]); %toc
[status, cmdout] = system(['find /c /v "" ', outpath]);
if(status~=1)
    scanCell = textscan(cmdout,'%s %s %u');
    allModels = double(scanCell{3});
    if allModels==1; allModels=0;end % if inconsistent, 0.
else
    disp('Unable to determine number of lines in the file');
end


nModels = zeros(nSets+1,1);
for iSet=1:nSets
    copyfile('ASPcode\input_or.asp', 'ASPcode\input.asp');
    fid = fopen('ASPcode\input.asp', 'a+');
    fprintf(fid, 'isadjset(%d).\n', iSet-1);
    tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); %toc
    % count the number of models.
    [status, cmdout] = system(['find /c /v "" ', outpath]);
    if(status~=1)
        scanCell = textscan(cmdout,'%s %s %u');
        nModels(iSet) = scanCell{3};
        if nModels(iSet)==1; nModels(iSet)=0;end % if inconsistent, 0.
    else
        disp('Unable to determine number of lines in the file');
    end
end

% there is no adjustment set.
iSet=iSet+1;
copyfile('ASPcode\input_or.asp', 'ASPcode\input.asp');
fid = fopen('ASPcode\input.asp', 'a+');
fprintf(fid, '%s',sprintf('nisadjset(%d)\n.',  0:nSets));

tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); toc
% count the number of models.
[status, cmdout] = system(['find /c /v "" ', outpath]);
if(status~=1)
    scanCell = textscan(cmdout,'%s %s %u');
    nModels(iSet) = scanCell{3};
    if nModels(iSet)==1; nModels(iSet)=0;end % if inconsistent, 0.
else
    disp('Unable to determine number of lines in the file');
end



