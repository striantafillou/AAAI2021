nVars=7; nLatent=2;
dag= zeros(nVars);
dag(1, 2)=1;
dag(3, [1, 2])=1;
dag(6, [4, 1])=1;
dag(7, [4,2])=1;
dag(1, 5)=1; dag(5, 2)=1;
isLatent =  [false false false false false true true];
smm = dag2smm(dag, isLatent);
mag = dag2mag(dag,isLatent);

[pag, dnc, col] = mag2pag(mag);
% get sets
setmembers = false(2^(nObs-2), nObs-2);
for iSet=0:2^(nObs-2)-1
    setmembers(iSet+1, :)= bitand(iSet,2.^(0:nObs-2-1));
end
adjSet= setmembers(1,:);
%%
% write asp input file
fid = fopen('ASPcode\input.asp', 'wt');
nObs = nVars-nLatent;
fprintf(fid, sprintf('nodes(%d).\n', nObs));
fprintf(fid, sprintf('sets(%d).\n', nObs));
for iVar=1:nObs-1
    for jVar=iVar+1: nObs
        if smm(iVar, jVar)==0
             fprintf(fid, 'not bidirected(%d, %d).\n', iVar, jVar);
             fprintf(fid, 'not directed(%d, %d).\n', iVar, jVar);
             fprintf(fid, 'not directed(%d, %d).\n', jVar, iVar);
        elseif smm(iVar, jVar)==2 
            if smm(jVar, iVar) ==3
                fprintf(fid, 'directed(%d, %d).\n', iVar, jVar);
                fprintf(fid, 'not directed(%d, %d).\n', jVar, iVar);
                fprintf(fid, 'not bidirected(%d, %d).\n', iVar, jVar);
            elseif smm(jVar,iVar) ==2
                fprintf(fid, 'bidirected(%d, %d).\n', iVar, jVar);
                fprintf(fid, 'not directed(%d, %d).\n', iVar, jVar);
                fprintf(fid, 'not directed(%d, %d).\n', jVar, iVar);
            elseif smm(jVar,iVar) ==4
                fprintf(fid, 'bidirected(%d, %d).\n', iVar, jVar);
                fprintf(fid, 'directed(%d, %d).\n', iVar, jVar);
                fprintf(fid, 'directed(%d, %d).\n', jVar, iVar);
            end
        elseif smm(iVar, jVar)==4 && smm(jVar, iVar)==2
             fprintf(fid, 'bidirected(%d, %d).\n', iVar, jVar);
             fprintf(fid, 'directed(%d, %d).\n', jVar, iVar);             
             fprintf(fid, 'not directed(%d, %d).\n', jVar, iVar);
         elseif smm(iVar, jVar)==3 && smm(jVar, iVar)==2
             fprintf(fid, 'directed(%d, %d).\n', jVar, iVar);
             fprintf(fid, 'not bidirected(%d, %d).\n', iVar, jVar);
             fprintf(fid, 'not directed(%d, %d).\n', iVar, jVar);             
        end
    end
end
fprintf(fid, 'isadjset(2).\n');

fprintf(fid, '#show adjSet12/1.\n');
%fprintf(fid, '#show dsepPG12/1.\n');
%fprintf(fid, '#show inCP/1.\n');fprintf(fid, '#show notconda/1.\n');
%[~, asInd] = find(setmembers, adjSet);


% get all 
fclose(fid);

workdir = [code_path filesep 'causal_effects' filesep 'ASPcode' filesep];
clingopath = [workdir 'util\clingo-5.2.0-win64\clingo.exe'];
programpath = [workdir 'test_ind_adj.lp'];
options = '--enum-mode=bt  --configuration=many --models=0 --verbose=0 --quiet=0 --outf=1 -t 4,compete >';
inpath = [workdir 'input.asp'];
outpath = [workdir 'output'];
tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); toc
