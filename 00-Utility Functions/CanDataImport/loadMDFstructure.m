function [ dataStructure ] = loadMDFstructure ( MDFname, MDFpath, loadIfNotFound)
% IMPORT MDF data or .mat file with stored structure matching MDF filename
% MDFname should NOT have extension on it, '.mat' is added to input string

% loadIfNotFound = 1 to load from MDF if .mat file is not found

% check if .mat files are on disk, if so, load them instead of processing
% MDF again

targetFileName = strcat(MDFname,'.mat');
actFileName = dir(strcat(MDFname,'.mat'));
    if (length(actFileName) > 0) %% FIXME this will only look in parent directory, we shoud also look in sub folder such as "DATA"
        if (actFileName.name >min(actFileName.name == targetFileName) == 1) %% if there is a matching .mat file on disk
           dataStructure = load(strcat(MDFname,'.mat'));
           dataStructure = dataStructure.(cell2mat(fieldnames(dataStructure)));

        end
    else
        if loadIfNotFound == 1
            options.outputType = 'Structure';
            options.importTo = 'workspace';
            dataname=strcat('data',strrep(strrep(MDFname,'_',''),'.MDF',''));
%            options.datanamesave = dataname;
            dataStructure = mdf_read([MDFpath MDFname],options);
             %% Adjust broken signals
            %some signals are being incorrectly read by mdf_get_data. This function
            %corrects this. mdf_get_data should be fixed and this function should be
            %removed ASAP
            brokenNegativeSignals = {'tcp', 'vvp', 'TCp', 'VVp', 'VSPp', 'vspp', 'VSEp','vsep','vdctp','VDCTp','VDCRp','vdcrp','vdcap','VDCAp'};
            dataStructure = findandfixbrokennegativesignals(dataStructure,brokenNegativeSignals);
            constantoffsetsignals = {'MCU_longitude'};
            offsetvals = [2];
            dataStructure = multiplyconstantoffsetsignals(dataStructure,constantoffsetsignals,offsetvals);
        else
            dataStructure = struct;
        end
    end

end