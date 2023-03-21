%% TruckSimResultsProcessing_v1.m
% 3/21/23
% S. Krug
% Notes:
%
% 3/21/23 - Initial start
%

clear all
close all
clc
%%
%folder_path = uigetdir(); %C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Constant_Radius
folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Constant_Radius\";
files = dir(fullfile(folder_path, '*.csv'));
h = waitbar(0,'Loading data...');
for i = 1:length(files)
    filename = fullfile(folder_path, files(i).name);
    data{i} = xlsread(filename);

    waitbar(i/length(files))

end

