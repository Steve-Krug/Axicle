%Steve Krug
%9/3/23
%This function runs a tractor only rollover simulation at increasing
%roll angles until the tractor rolls over by itself, to find the last/highest
%angle that's recoverable

%dataMatrix must be matrix/array of a single tractor + trailer
%sim in the following column format:

% Columns - Variable Name
% 1 - Time
% 2 - Vx
% 3 - Vy
% 4 - Vz
% 5 - AVx
% 6 - AVy
% 7 - AVz
% 8 - Pitch
% 9 - Roll
% 10 - Yaw
% 11 - Ax
% 12 - Ay
% 13 - Az
% 14 - Ax_S1
% 15 - Ay_S1
% 16 - Az_S1
clc
clear
close all


%% Load Data from Tractor and Trailer Rollovers
load('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\rolloverdata_tractortrailer_test_v1.mat')

dataMatrix = table2array(data{1,6}); %Convert from table to array of one set of sim results
lowerRollAngleThreshold_deg = 19;
upperRollAngleThreshold_deg = 40;


%% Find max roll angle between thresholds
fileCounter = 1;
tractorRollThreshold_deg = 50; %deg
for rollThreshold = lowerRollAngleThreshold_deg:upperRollAngleThreshold_deg %iterate at increasing roll angles in increments of 1 deg
    % dataMatrix = table2array(data{1,6}); %Convert from table to array

    %FIX THIS
    rollIndices = find(dataMatrix(:,9) < -rollThreshold); %Indices at which a roll angle above "rollThreshold" is achieved.
    %Roll angle is read as negative in this tractor/trailer simulation...
    %FIX THIS

    rollIndex = rollIndices(1); %Pick the first index at which the rollThreshold is achieved test if it's unrecoverable

    % Log the state of the tractor/trailer during the rollover, such that
    % it can be imposed into tractor only to see if it will recover

    % Vehicle Target Speed
    SPEED = dataMatrix(rollIndex,2); %kph
    %ODE: Global Z coord. of sprung-mass origin, unit 1 {Zo}. Set in
    %TruckSim
    %Euler pitch Unit 1
    SV_PITCH = abs(dataMatrix(rollIndex,8))/57.3; % deg to rad Pitch angle
    %Euler roll Unit 1
    SV_ROLL = abs(dataMatrix(rollIndex,9))/57.3; % deg to rad Roll angle
    %Steer Angle
    STEER_SW = abs(dataMatrix(rollIndex,17));  %deg to rad Steer angle constant
    %Lateral Acceleration
    Ay = 1; %g? Does not intialize Lateral acceleration
    %Chassis slip angle
    SV_BETA = -3/57.3; %deg to rad Chassis slip angle (sideslip angle)
    %Roll rate of unit 1
    SV_AVX = abs(dataMatrix(rollIndex,5))/57.3;  %deg/s to rad/s Vehicle roll rate

    %Set simulink model
    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL_Tractor_Only_Test1'));


    %Set parameters for simulation
    set_param(block1{1,1}, 'Value', 'SPEED');
    set_param(block1{2,1}, 'Value', 'SV_PITCH');
    set_param(block1{3,1}, 'Value', 'SV_ROLL');
    set_param(block1{4,1}, 'Value', 'STEER_SW');
    set_param(block1{5,1}, 'Value', 'Ay');
    set_param(block1{6,1}, 'Value', 'SV_BETA');
    set_param(block1{7,1}, 'Value', 'SV_AVX');

    sim('batch_iteration_SWD_SL_Tractor_Only_Test1');
    % close_system('batch_iteration_SWD_SL')
    % waitbar(i/total_runs)
    % pause(1)
    pause(1)

    % Load Result Data
    folder_path = 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_4f673585-764b-467b-a0eb-1562355ad8c5';


    %Get list of .csv files in result folder
    files = dir(fullfile(folder_path, '*.csv'));
    % h = waitbar(0,'Loading data...');
    % for i = 1:length(files)
    filename = fullfile(folder_path, files(end).name);
    % end

    % dataTractor{i} = readtable(filename);
    %store all tractor rollover data
    allTractorData{fileCounter} = readtable(filename);


    % Does tractor rollover?
    tractorDataMatrix = table2array(allTractorData{1, fileCounter});
    fileCounter = fileCounter + 1;

    if max(tractorDataMatrix(:,9)) > tractorRollThreshold_deg
        maxRollAngle_deg = rollThreshold;

        break %exit loop and return max roll angle tolerable
    end
end


