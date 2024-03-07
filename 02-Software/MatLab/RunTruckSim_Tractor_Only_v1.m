%% RunTruckSim_Tractor_Only_v1.m
% 9/2/23
% S. Krug
% Notes:
%
%
%

clc
clear
close all

%% Pack Runs

% MASSPAYLOAD = 15000; %kg
% ZCGPAYLOAD = 1500; %mm
% SPEEDTARGETCONSTANT = 45; %kph
%
% factor_one_steps =1;
% factor_two_steps = 1;
% factor_three_steps = 1;
%
%
% masspayload_increments = factor_one_steps; %qty. of steps
% masspayload_high_kg = 20000; %kg
% masspayload_low_kg = 100; %kg
% MASSPAYLOAD = linspace(masspayload_low_kg, masspayload_high_kg, masspayload_increments);
%
% zcgpayload_increments = factor_two_steps; %qty. of steps
% zcgpayload_high_mm = 3.0; %mm
% zcgpayload_low_mm = 1.25; %mm
% ZCGPAYLOAD = linspace(zcgpayload_low_mm, zcgpayload_high_mm, zcgpayload_increments);
%
% vx_increments = factor_three_steps; %qty. of steps
% vx_high_kph = 120; %kph
% vx_low_kph = 50; %kph
% SPEEDTARGETCONSTANT = linspace(vx_low_kph, vx_high_kph, vx_increments);
%
%
%
% % run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD,SPEEDTARGETCONSTANT);
% run_input_array = allcomb(SPEEDTARGETCONSTANT);
% % run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD);
% total_runs = length(run_input_array);

total_runs = 1;

%% Load Data from Tractor and Trailer Rollovers
load('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\rolloverdata_tractortrailer_test_v1.mat')

figure(2)
title('SWD')
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

%% Run Sims
% hbar = parfor_progressbar(total_runs,'Computing...');
% parfor (i = 1:total_runs,12)  %20 logical processors, 12 cores on SKRUG machine

% simIn(1:length(run_input_array)) = Simulink.Simulation('batch_iteration_SWD_SL');
% f = waitbar(0,'Progress...');
% open_system('batch_iteration_SWD_SL')
counter = 1;
for rollThreshold = 20:40
    dataMatrix = table2array(data{1,6});

    rollIndices = find(dataMatrix(:,9) < -rollThreshold); %3693 Find indices at which a rollover condition is true in roll angle time history
    rollIndex = rollIndices(1);

    % Vehicle Target Speed
    SPEED = dataMatrix(rollIndex,2); %kph

    %ODE: Global Z coord. of sprung-mass origin, unit 1 {Zo}

    %Euler pitch Unit 1
    SV_PITCH = abs(dataMatrix(rollIndex,8))/57.3; % deg to rad Pitch angle

    %Euler roll Unit 1
    SV_ROLL = abs(dataMatrix(rollIndex,9))/57.3; % deg to rad Roll angle 

    STEER_SW = abs(dataMatrix(rollIndex,17));  %deg to rad Steer angle constant

    Ay = 1; %g? Does not intialize Lateral acceleration

    SV_BETA = -3/57.3; %deg to rad Chassis slip angle (sideslip angle)

    SV_AVX = abs(dataMatrix(rollIndex,5))/57.3;  %deg/s to rad/s Vehicle roll rate





    for i = 1:total_runs
        % Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl

        % MASSPAYLOAD = run_input_array(i,1);

        % ZCGPAYLOAD = run_input_array(i,2);

        % SPEED = run_input_array(i,1);


        block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL_Tractor_Only_Test1'));
        % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
        % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
        % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');


        % set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
        % set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
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
        pause(2)
    end

    %% Load Result Data
    folder_path = 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_4f673585-764b-467b-a0eb-1562355ad8c5';


    files = dir(fullfile(folder_path, '*.csv'));
    h = waitbar(0,'Loading data...');
    for i = 1:length(files)
        filename = fullfile(folder_path, files(i).name);
        dataTractor{i} = readtable(filename);
        % filenames_all(i) = filename;

        %waitbar(i/length(files))
    end

    tractorRollData(:,counter) = % Store roll data in table because size of stuff will be different.

    figure(3)
    title('SWD')
    hold on
    subplot(3,1,1)
    plot(dataTractor{1,length(dataTractor)}.Time, dataTractor{1,length(dataTractor)}.AVx)
    xlabel('Time [s]')
    ylabel('Roll Rate [deg/s]');
    Plotter(1)
    hold on
    subplot(3,1,2)
    plot(dataTractor{1,length(dataTractor)}.Time, dataTractor{1,length(dataTractor)}.Ay)
    xlabel('Time [s]')
    ylabel('Ay Sensor [G]');
    Plotter(1)
    hold on
    subplot(3,1,3)
    plot(dataTractor{1,length(dataTractor)}.Time, dataTractor{1,length(dataTractor)}.Roll)
    xlabel('Time [s]')
    ylabel('Roll Angle[deg]');
    Plotter(1)
    hold on

counter = counter + 1;
end

%% State Variables to Set

for j = 1:length(dataTractor)
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
end

% SV_ZO
% %Euler pitch Unit 1
% SV_PITCH
% %Euler roll Unit 1
% SV_ROLL
% %Str wheel angle
% SV_SWA
% %Str Rate
% SV_AV_SW
%
% SV_STR_IN_GR_A1
% SV_STR_IN_GR_A2
% SV_STR_IN_GR_A3
%
% SV_STR_IN_DGR_A1
% SV_STR_IN_DGR_A2
% SV_STR_IN_DGR_A3
%
% SV_ROLL_A1
% SV_ROLL_A2
% SV_ROLL_A3
%
% SV_JNC_A1
% SV_JNC_A2
% SV_JNC_A3
%
% SV_ROT_L1
% SV_ROT_R1
% SV_ROT_L2
% SV_ROT_R2
% SV_ROT_L3
% SV_ROT_R3
%
% SV_SLIP_LAT_L1I
% SV_SLIP_LONG_L1I
% SV_SLIP_LAT_L1O
% SV_SLIP_LONG_L1O
%
% SV_SLIP_LAT_R1I
% SV_SLIP_LONG_R1I
% SV_SLIP_LAT_R1O
% SV_SLIP_LONG_R1O
%
% SV_SLIP_LAT_L2I
% SV_SLIP_LONG_L2I
% SV_SLIP_LAT_L2O
% SV_SLIP_LONG_L2O
%
% SV_SLIP_LAT_R2I
% SV_SLIP_LONG_R2I
% SV_SLIP_LAT_R2O
% SV_SLIP_LONG_R2O
%
% SV_SLIP_LAT_L3I
% SV_SLIP_LONG_L3I
% SV_SLIP_LAT_L3O
% SV_SLIP_LONG_L3O
%
% SV_SLIP_LAT_R3I
% SV_SLIP_LONG_R3I
% SV_SLIP_LAT_R3O
% SV_SLIP_LONG_R3O
% %Transmission output shaft rotation
% SV_ROT_TR_OUT
% %1st and 2nd drive axle diff input shaft rotation, inter-axile diff for
% %drive axles 1,2, input shaft rotation
% SV_ROT_SHAFT_1
% SV_ROT_SHAFT_2
% SV_ROT_SHAFT_3
% %Body X,Y,Z speed of laden sprung-mass for Unit 1
% SV_VXS
% SV_VYS
% SV_VZS
% %Body X roll rate, Body Y pitch rate, Body Z yaw rate, of sprung mass for Unit 1
% SV_AVX
% SV_AVY
% SV_AVZ
% %ODE Roll rate of Axle 1, 2, 3
% SV_AVX_A1
% SV_AVX_A2
% SV_AVX_A3
% %ODE Jounce rate of Axle 1, 2, 3
% SV_JNCR_A1
% SV_JNCR_A2
% SV_JNCR_A3
% %ODE Spin of wheel L/R 1/2/3
% SV_AVY_L1
% SV_AVY_R1
% SV_AVY_L2
% SV_AVY_R2
% SV_AVY_L3
% SV_AVY_R3
% %Engine crankshaft spin
% SV_AV_ENG
% %Torque coupling output shaft spin
% SV_AV_TC
% %ODE Transmission output shaft spin
% SV_AV_TR_OUT



