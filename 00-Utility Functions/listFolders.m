% From http://stackoverflow.com/questions/8748976/list-the-subfolders-in-a-folder-matlab-only-subfolders-not-files
function [nameFolds] = listFolders(parentFolder,sortCol)
d = dir(parentFolder);
isub = [d(:).isdir]; %# returns logical vector
% nameFolds = {d(isub).name}';
% nameFolds(ismember(nameFolds,{'.','..'})) = []; % remove '.' and '..' pseudo-folders
nameFolds = (d(isub));
nameFolds = nameFolds(3:end); % Remove first two entries which are '.' and '..'
for i = 1:length(nameFolds)
    nameFolds(i).date = datenum(nameFolds(i).date);
end
nameFolds = struct2cell(nameFolds);
nameFolds = nameFolds';
nameFolds = sortrows(nameFolds,sortCol);
nameFolds = nameFolds(:,1);