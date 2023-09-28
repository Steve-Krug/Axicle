function [] = checkExistenceAndSaveFile( fileName, fileExt, savePath, outputData, desiredVarName, overwrite)
%SAVEMATFILEDONOTOVERWRITE Summary of this function goes here
%   Detailed explanation goes here

fileNameFull = strcat(fileName,'.',fileExt);
fileExists = exist(fileNameFull,'file');
S.(desiredVarName) = outputData;
if (fileExists ~= 2) || (overwrite == 1)
    save(strcat(savePath,fileNameFull), '-struct', 'S', '-v7.3');
end


end