

file = "C:\Users\kyleh\Desktop\Axicle\Steve Krug - Public\15. GitHub Repo\Axicle\07-Harmony\test_data\240409_data_i40_v1.hdf5";
delete(file);


for i = 1:500
    
    idex = int2str(1000+i);
    %run = cell2mat(data(i));
    %names = run{1}.Properties.VariableNames;
    %n1 = ["ax_s1", "ay_s1", "az_s1", "wx_s1", "wy_s1", "wz_s1"];
    %n2 = ["ax_s2", "ay_s2", "az_s2", "wx_s2", "wy_s1", "wz_s2"];
    %n3 = ["ax_s3", "ay_s3", "az_s3", "wx_s3", "wy_s3", "wz_s3"];
    %names = ["t", n1, n2, n3];
    %run = table2array(run{1});

    run = struct2table(data{i});

    ds = "/runs/" + idex;
    h5create(file, ds, size(run));
    h5write(file, ds, table2array(run));

    h5writeatt(file,ds,"col",run.Properties.VariableNames)

    inames = ["mass", "cgz", "cgx"];
    for j = 1:length(inames)
        h5writeatt(file,ds,inames(j),run_input_table(i,j).Variables);
    end

end

%size(run_input_array)
%h5create(file, '/inputs', size(run_input_array));
%h5write(file, '/inputs', run_input_array);
%h5writeatt(file,'/inputs',"col", wtf)


%csvwrite(path + "input.csv", run_input_array)

%x = data(1){1}.Time
%asdf = x{1}.Time
