workdir = [ 'ASPcode' filesep];
clingopath = [workdir 'util\clingo-5.2.0-win64\clingo.exe'];
programpath = [workdir 'test_ind_adj.lp'];
%options = ' --enum-mode=bt --verbose=0 --quiet=0 --outf=1  -t 4,compete >';
ids = nan(1, 20);   
options = ' --enum-mode=bt --verbose=0 --configuration=many --models=1000 --quiet=0 --outf=1  -t 4,compete >';

%%
for fileno=1:20
    
    allps ={}; nps =0;
    inpath_or = [workdir 'input_or' num2str(fileno) '.asp'];
    outpath = [workdir 'output'];

    system([clingopath ' ' programpath ' ' inpath_or ' ' options ' ' outpath]); %toc
    fout = fopen(outpath, 'r');
    id=true;
    i=0;
    while id==true && i<1000
        i = i+1;
        tline = fgetl(fout); % check if inconsistent
        tline = fgetl(fout);
        edges =strsplit(tline, '. ');
        nEdges = size(edges, 2);

        isBidir =  contains(edges, 'bidirected');
        edginds = nan(nEdges, 2);
        for iEdge =1:nEdges
            tmp = strsplit(edges{iEdge}, {'(',',', ')'});
            edginds(iEdge, 1) =  str2double(tmp{2});
            edginds(iEdge, 2) =  str2double(tmp{3});
        end
        [id, p] = causalEffectsId12Aspout(edginds(~isBidir,:), edginds(isBidir,:));
        if id==false
            ids(fileno)=-1;
        else 
            if ~any(contains(allps,p))  
            nps = nps+1;
            allps{nps} = p;
            end
        end
    end

end