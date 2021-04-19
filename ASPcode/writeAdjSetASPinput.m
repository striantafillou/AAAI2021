function fid = writeAdjSetASPinput(pagstruct,filename)
% write asp input file // all latent variable must be in the end!
%fid = fopen('ASPcode\input_or.asp', 'wt');
fid = fopen(filename,'wt');
pag = pagstruct.graph;
nObs= size(pag, 1);
fprintf(fid,'nodes(%d).\n', nObs);
fprintf(fid,'sets(%d).\n', nObs);

for iVar=1:nObs-1
    for jVar=iVar+1: nObs
        if pag(iVar, jVar)~=0
            fprintf(fid, 'inducing(%d, %d).\n', iVar, jVar);
        else
            fprintf(fid, 'ninducing(%d, %d).\n', iVar, jVar);
        end
    end
end
dnc = [pagstruct.dnc;pagstruct.ddnc];
nDnc = size(dnc, 1);
for iDnc = 1:nDnc
    fprintf(fid, 'dnc(%d, %d, %d).\n', dnc(iDnc, 1), dnc(iDnc, 2),  dnc(iDnc, 3));
end
col =  [pagstruct.colliders;pagstruct.dcolliders];  
nCol = size(col,1);
for iCol=1:nCol
    fprintf(fid, 'col(%d, %d, %d).\n', col(iCol, 1), col(iCol, 2),  col(iCol, 3));
end
fprintf(fid, 'anc(1, 2).\n');
fprintf(fid, '#show directed/2.\n');fprintf(fid, '#show bidirected/2.\n');
fclose(fid);
end
% fclose(fid);
% % find all models
% tic, system([clingopath ' ' programpath ' ' inpath_or ' ' options ' ' outpath]); %toc
% [status, cmdout] = system(['find /c /v "" ', outpath]);
% if(status~=1)
%     scanCell = textscan(cmdout,'%s %s %u');
%     allModels = double(scanCell{3});
%     if allModels==1; allModels=0;elseif allModels==2*maxModels; flag =true;
%     end % if inconsistent, 0.
% else
%     disp('Unable to determine number of lines in the file');
% end
% 
% if flag==true
%     notCompute(iter)=true;
%     continue;
% end
% 
% nModels = zeros(nSets+1,1);
% for iSet=1:nSets
%     copyfile('ASPcode\input_or.asp', 'ASPcode\input.asp');
%     fid = fopen('ASPcode\input.asp', 'a+');
%     fprintf(fid, 'isadjset(%d).\n', iSet-1);
%     tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); %toc
%     % count the number of models.
%     [status, cmdout] = system(['find /c /v "" ', outpath  '& echo $']);
%     if(status~=1)
%         scanCell = textscan(cmdout,'%s %s %u');
%         nModels(iSet) = scanCell{3}(1);
%         if nModels(iSet)==1; nModels(iSet)=0;end % if inconsistent, 0.
%     else
%         disp('Unable to determine number of lines in the file');
%     end
% end
% fclose(fid);
% 
% % there is no adjustment set.
% iSet=iSet+1;
% copyfile('ASPcode\input_or.asp', 'ASPcode\input.asp');
% fid = fopen('ASPcode\input.asp', 'a+');
% fprintf(fid, '%s',sprintf('nisadjset(%d)\n.',  0:nSets));
% fclose(fid);
% tic, system([clingopath ' ' programpath ' ' inpath ' ' options ' ' outpath]); toc
% % count the number of models.
% [status, cmdout] = system(['find /c /v "" ', outpath]);
% if(status~=1)
%     scanCell = textscan(cmdout,'%s %s %u');
%     nModels(iSet) = scanCell{3};
%     if nModels(iSet)==1; nModels(iSet)=0;end % if inconsistent, 0.
% else
%     disp('Unable to determine number of lines in the file');
% end
% probHwDo = nModels./allModels;
% times(iter, 1)= toc;