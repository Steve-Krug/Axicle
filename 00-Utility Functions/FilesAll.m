function iniPaths=FilesAll(iniPath)
%iniPath='D:\My Documents\MATLAB';%
if (iniPath(end)~='\')
	iniPath=[iniPath,'\'];
end
files=dir(fullfile(iniPath,'*.mat'));%
n=size(files,1);%
j=0;
for i=1:n
    tName=files(i,1).name;
    if (length(tName)>2) %
        if (~files(i,1).isdir) %
            filename=fullfile(iniPath,tName);%
            disp(filename);
            j=j+1;
            iniPaths{j}=[iniPath,tName];
        end
    end
end
end
