function [files] = recursdir(folders,searchExpression,subdir)

subdir = logical(subdir);

files.filename = [];
files.trunc_filename = [];
files.ffilename = [];
% files.veh = [];

for i = 1:length(folders)
    pdir = pwd;

    cd(folders{i});
    if folders{i}(end)=='\'
        foldernametmp = folders{i};
    else
        foldernametmp = [folders{i} '\'];
    end

    [~,list] = system(['dir /S/B *' searchExpression]);
    outfiles = textscan(list, '%s', 'Delimiter', '\n');
    subdir_ref = length(find(foldernametmp=='\'));
    for j = 1:length(outfiles{1})
        subdir_num(j,1) = length(find(outfiles{1}{j,1}=='\'));
    end
    if subdir == true
        dir_ind = 1:length(outfiles{1});
    else
        dir_ind = find(subdir_num==min(subdir_num));
    end
    outfiles{1} = outfiles{1}(dir_ind,1);
    fname = strrep(outfiles{1},'Z:\','');
    
    for j = 1:size(fname,1)
        tmp = textscan(fname{j}, '%s', 'Delimiter', '\\');
        fname_tmp{j,1} = tmp{1,1}{size(tmp{1,1},1),1};
        trunc_fname_tmp{j,1} = fname_tmp{j,1}(1:end-length(searchExpression));
        clear tmp
    end
    
    outfiles{1} = strrep(outfiles{1},'Z:',folders{i});

    cd(pdir);
    
%     for j = 1:size(outfiles{1},1)
%         car_tmp{j,1} = car{i};
%     end
    if i<2
        files.filename = fname_tmp;
        files.trunc_filename = trunc_fname_tmp;
        files.ffilename = outfiles{1};        
%         files.cat = car_tmp;
    else
        files.filename = [files.filename;fname_tmp];
        files.trunc_filename = [files.trunc_filename;trunc_fname_tmp];
        files.ffilename = [files.ffilename;outfiles{1}];
%         files.car = [files.veh;car_tmp];
    end
    clear fname fname_tmp%car_tmp
end