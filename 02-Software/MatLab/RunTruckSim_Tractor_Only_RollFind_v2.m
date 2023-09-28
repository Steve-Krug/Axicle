%% RunTruckSim_Tractor_Only_RollFind_v2.m
% 9/3/23
% S. Krug
% Notes:
%
%
%

clc
clear
close all


%% Load Data from Tractor and Trailer Rollovers
load('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\rolloverdata_tractortrailer_test_v1.mat')

figure(2)
title('SWD Tractor and Trailer Rollover')
hold on
subplot(3,1,1)
plot(data{1,6}.Time, data{1,6}.AVx)
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]');
Plotter(1)
hold on
subplot(3,1,2)
plot(data{1,6}.Time, data{1,6}.Ay_S1)
xlabel('Time [s]')
ylabel('Ay Sensor [G]');
Plotter(1)
hold on
subplot(3,1,3)
plot(data{1,6}.Time, data{1,6}.Roll)
xlabel('Time [s]')
ylabel('Roll Angle[deg]');
Plotter(1)
hold on

%% Run Tractor Sims

dataMatrix = table2array(data{1,6}); %Convert from table to array of one set of sim results

% %Loop for iterating at increasing roll angles
% for rollThreshold = 10:40 %iterate at increasing roll angles in increments of 1 deg
%
%
%     rollIndices = find(dataMatrix(:,9) < -rollThreshold); %Indices at which a roll angle above "rollThreshold" is achieved
%     rollIndex = rollIndices(1); %Pick the first index at which the rollThreshold is achieved test if it's unrecoverable
%
%     % Log the state of the tractor/trailer during the rollover, such that
%     % it can be imposed into tractor only to see if it will recover
%
%     % Vehicle Target Speed
%     SPEED = dataMatrix(rollIndex,2); %kph
%     %ODE: Global Z coord. of sprung-mass origin, unit 1 {Zo}. Set in
%     %TruckSim
%     %Euler pitch Unit 1
%     SV_PITCH = abs(dataMatrix(rollIndex,8))/57.3; % deg to rad Pitch angle
%     %Euler roll Unit 1
%     SV_ROLL = abs(dataMatrix(rollIndex,9))/57.3; % deg to rad Roll angle
%     %Steer Angle
%     STEER_SW = abs(dataMatrix(rollIndex,17));  %deg to rad Steer angle constant
%     %Lateral Acceleration
%     Ay = 1; %g? Does not intialize Lateral acceleration
%     %Chassis slip angle
%     SV_BETA = -3/57.3; %deg to rad Chassis slip angle (sideslip angle)
%     %Roll rate of unit 1
%     SV_AVX = abs(dataMatrix(rollIndex,5))/57.3;  %deg/s to rad/s Vehicle roll rate
%
%
%
%     for i = 1:total_runs
%         % Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl
%
%         % MASSPAYLOAD = run_input_array(i,1);
%
%         % ZCGPAYLOAD = run_input_array(i,2);
%
%         % SPEED = run_input_array(i,1);
%
%
%         block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL_Tractor_Only_Test1'));
%         % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
%         % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
%         % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');
%
%
%         % set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
%         % set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
%         set_param(block1{1,1}, 'Value', 'SPEED');
%         set_param(block1{2,1}, 'Value', 'SV_PITCH');
%         set_param(block1{3,1}, 'Value', 'SV_ROLL');
%         set_param(block1{4,1}, 'Value', 'STEER_SW');
%         set_param(block1{5,1}, 'Value', 'Ay');
%         set_param(block1{6,1}, 'Value', 'SV_BETA');
%         set_param(block1{7,1}, 'Value', 'SV_AVX');
%
%         sim('batch_iteration_SWD_SL_Tractor_Only_Test1');
%         % close_system('batch_iteration_SWD_SL')
%         % waitbar(i/total_runs)
%         % pause(1)
%         pause(2)
%
%         %Data of all runs is saved in trucksim run folder. 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_4f673585-764b-467b-a0eb-1562355ad8c5';
%
%     end
%
%     %% Load Result Data
%     folder_path = 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_4f673585-764b-467b-a0eb-1562355ad8c5';
%
%
%     files = dir(fullfile(folder_path, '*.csv'));
%     h = waitbar(0,'Loading data...');
%     for i = 1:length(files)
%         filename = fullfile(folder_path, files(i).name);
%         dataTractor{i} = readtable(filename);
%         % filenames_all(i) = filename;
%
%         %waitbar(i/length(files))
%     end
%
%     % tractorRollData(:,counter) = % Store roll data in table because size of stuff will be different.
%
%     figure(3)
%     title('SWD')
%     hold on
%     subplot(3,1,1)
%     plot(dataTractor{1,length(dataTractor)}.Time, dataTractor{1,length(dataTractor)}.AVx)
%     xlabel('Time [s]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
%     hold on
%     subplot(3,1,2)
%     plot(dataTractor{1,length(dataTractor)}.Time, dataTractor{1,length(dataTractor)}.Ay)
%     xlabel('Time [s]')
%     ylabel('Ay Sensor [G]');
%     Plotter(1)
%     hold on
%     subplot(3,1,3)
%     plot(dataTractor{1,length(dataTractor)}.Time, dataTractor{1,length(dataTractor)}.Roll)
%     xlabel('Time [s]')
%     ylabel('Roll Angle[deg]');
%     Plotter(1)
%     hold on
%
% counter = counter + 1;
% end
lowerRollAngleThreshold_deg = 19;
upperRollAngleThreshold_deg = 40;

[maxRollAngle_deg, allTractorData] = FindLimitRollAngle_v1(dataMatrix, lowerRollAngleThreshold_deg, upperRollAngleThreshold_deg);
% Plot results
%
% for j = 1:length(dataTractor)
figure(3)
title('SWD')
% hold on
% subplot(3,1,1)
% plot(dataTractor{1,j}.Time, dataTractor{1,j}.AVx)
% xlabel('Time [s]')
% ylabel('Roll Rate [deg/s]');
% Plotter(1)
% hold on
% subplot(3,1,2)
% plot(dataTractor{1,j}.Time, dataTractor{1,j}.Ay)
% xlabel('Time [s]')
% ylabel('Ay Sensor [G]');
% Plotter(1)
% hold on
% subplot(3,1,3)
plot(dataTractor{1,j}.Time, dataTractor{1,j}.Roll)
xlabel('Time [s]')
ylabel('Roll Angle[deg]');
Plotter(1)
hold on

