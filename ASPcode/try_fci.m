addpath(genpath('C:\Users\sot16.PITT\Documents\MATLAB\causal_graphs\causal_effects\ASPcode'))

workdir = 'C:\Users\sot16.PITT\Documents\MATLAB\causal_graphs\causal_effects\ASPcode\';
clingopath = [workdir 'util\clingo-5.2.0-win64\clingo.exe'];
programpath = [workdir 'test_ind_cr.lp'];
options = '--enum-mode=bt --opt-mode=opt --configuration=many --models=0 --verbose=0 --quiet=1 --outf=1 -t 4,compete >';
options_opt = '--enum-mode=bt --opt-mode=opt --configuration=many --models=0 --verbose=0 --project=1 --quiet=0 --outf=1 -t 4,compete >';
inpath = [workdir 'input_test.asp'];
outpath = [workdir 'output'];
tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); toc

% --opt-mode=optN ed
%%
rng();
%dag = generateDag(120,0.1,0);
dag = zeros(5); dag([1, 2], 3)=1; dag(5, [3 4])=1;
%L = randperm(size(dag,1), 20);
L =5;
mag = convertDagToMag(dag,L,[]);
pag = mag2pag(mag);
sepSets = findTrivialSepSets_Mag(mag);

fid = fopen(inpath, 'w+');
fprintf(fid, 'node(1..%d).\n',length(mag));ee
[i,j] = find(triu(mag));
for k = 1:length(i)
    fprintf(fid, 'edge(%d,%d).\n',i(k), j(k));
end

[i,j] = find(triu(~mag));
setid = 1;
for k = 1:length(i)
    if(i(k) ~= j(k))
        sep = find(sepSets(i(k),j(k),:));
        if(isempty(sep))
            continue;
        end
        
        sep = sprintf('%d;',sep);
        sep = ['(' sep(1:end-1) ')'];
        fprintf(fid, 'sepset(%d,%s,%d).\n',i(k),sep,j(k));
%         fprintf(fid, 'sepset(%d,%d,%d).\n',i(k),setid,j(k));
%         fprintf(fid, 'inside_set(%s,%d).\n',sep,setid);
%         fprintf(fid, ':- dconn(%d,%d,%d).\n',i(k),setid,j(k));
        setid = setid+1;
    end
end
% fprintf(fid, ':- not ancestor(1,2).\n');
% fprintf(fid, ':- not ancestor(3,2).\n');
% ancestorconstraints = [];
% fprintf(fid, ':~ not ancestor(%d,%d). [-1@%d,%d]\n',1,2,1,1);
% fprintf(fid, ':~ not ancestor(%d,%d). [-1@%d,%d]\n',1,3,1,2);
% fprintf(fid, ':~ not ancestor(%d,%d). [-1@%d,%d]\n',1,4,1,3);
% fprintf(fid, ':~ ancestor(%d,%d). [-1@%d,%d]\n',1,2,2,1);
% fprintf(fid, ':~ ancestor(%d,%d). [-1@%d,%d]\n',1,3,2,2);
% fprintf(fid, ':~ ancestor(%d,%d). [-1@%d,%d]\n',1,4,2,3);
% fprintf(fid, ':~ not leafnode(%d). [-1@%d,%d]\n',1,3,1);
% fprintf(fid, ':~ not rootnode(%d). [-1@%d,%d]\n',1,3,2);
% fprintf(fid, '#show rootnode/1.\n');
% fprintf(fid, '#show leafnode/1.\n');
% fprintf(fid, '#show ancestor/2.\n');
fprintf(fid, '#show directedendpoint/2.\n');
fprintf(fid, '#show undirectedendpoint/2.\n');
fclose(fid);
%% Call ASP
tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); toc
% tic, system([clingopath ' ' programpath ' ' inpath ' ' options_opt ' ' outpath]); toc

%% Parse output file

fid = fopen(outpath);
fgetl(fid); % ANSWER
result = strsplit(fgetl(fid),' '); % result
fclose(fid);

% ancestor = cell2mat(cellfun(@(x) sscanf(x, 'ancestor(%d,%d).'), result(cellfun(@(x) startsWith(x, 'ancestor'), result)), 'UniformOutput', false))';
%sepset = cell2mat(cellfun(@(x) sscanf(x, 'sepset(%d,%d,%d).'), result(cellfun(@(x) startsWith(x, 'sepset'), result)), 'UniformOutput', false))';
directedendpoint = cell2mat(cellfun(@(x) sscanf(x, 'directedendpoint(%d,%d).'), result(cellfun(@(x) startsWith(x, 'directedendpoint'), result)), 'UniformOutput', false))';
undirectedendpoint = cell2mat(cellfun(@(x) sscanf(x, 'undirectedendpoint(%d,%d).'), result(cellfun(@(x) startsWith(x, 'undirectedendpoint'), result)), 'UniformOutput', false))';

%% Compare with pag
pag2 = double(pag > 0);

for i = 1:size(directedendpoint,1)
   pag2(directedendpoint(i,1), directedendpoint(i,2)) = 2; 
end

for i = 1:size(undirectedendpoint,1)
   pag2(undirectedendpoint(i,1), undirectedendpoint(i,2)) = 3; 
end

assert(all(pag(:) == pag2(:)))