%% RunTruckSim_TractorTrailer_then_Tractor_v1.m
% 5/31/23
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

factor_one_steps = 2;
factor_two_steps = 2;
factor_three_steps = 2;


masspayload_increments = factor_one_steps; %qty. of steps
masspayload_high_kg = 25000; %kg
masspayload_low_kg = 0; %kg
MASSPAYLOAD = linspace(masspayload_low_kg, masspayload_high_kg, masspayload_increments);

zcgpayload_increments = factor_two_steps; %qty. of steps
zcgpayload_high_mm = 2.25; %m %it's parsed as mm in sim, but put m here.
zcgpayload_low_mm = 1.5; %m
ZCGPAYLOAD = linspace(zcgpayload_low_mm, zcgpayload_high_mm, zcgpayload_increments);

vx_increments = factor_three_steps; %qty. of steps
vx_high_kph = 100; %kph
vx_low_kph = 50; %kph
SPEEDTARGETCONSTANT = linspace(vx_low_kph, vx_high_kph, vx_increments);



run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD,SPEEDTARGETCONSTANT);
% run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD);
total_runs = length(run_input_array);


%% Run Sims
% hbar = parfor_progressbar(total_runs,'Computing...');
% parfor (i = 1:total_runs,12)  %20 logical processors, 12 cores on SKRUG machine

% simIn(1:length(run_input_array)) = Simulink.Simulation('batch_iteration_SWD_SL');
% f = waitbar(0,'Progress...');
% open_system('batch_iteration_SWD_SL')
for i = 1:total_runs
% Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl
    
    MASSPAYLOAD = run_input_array(i,1);

    ZCGPAYLOAD = run_input_array(i,2);

    SPEED = run_input_array(i,3);

    
    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL'));
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
    % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
    % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');
    
    
    set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
    set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
    set_param(block1{3,1}, 'Value', 'SPEED');
    % 
    sim('batch_iteration_SWD_SL');
    % close_system('batch_iteration_SWD_SL')
    waitbar(i/total_runs)
    pause(1)
    
end
%% Load Result Data
folder_path = "C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_5419c1b2-f318-458a-8400-6a079b924524";

files = dir(fullfile(folder_path, '*.csv'));
h = waitbar(0,'Loading data...');
for i = 1:length(files)
    filename = fullfile(folder_path, files(i).name);
    data{i} = readtable(filename);
    filenames_all(i) = filename;

    waitbar(i/length(files))

end

% Save data to CSV's
% for j = 1:length(data)
% 
% 
%    dataSet = table2array(data{1,j});
%    writematrix(dataSet, strcat('run', num2str(j), '.csv'))
% 
% end

figure(1)
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

% figure(2)
% title('SWD')
% hold on
% plot(data{1,6}.Time, data{1,6}.Ay,data{1,6}.Time, data{1,6}.Ay_S1);
% xlabel('Time [s]')
% ylabel('Acceleration [g]');
% Plotter(1)
% hold all
% 
% figure(3)
% title('SWD')
% hold on
% plot(data{1,6}.Time, data{1,6}.Az,data{1,6}.Time, data{1,6}.Az_S1);
% xlabel('Time [s]')
% ylabel('Acceleration [g]');
% Plotter(1)
% hold all
% 
% figure(4)
% title('SWD')
% hold on
% plot(data{1,6}.Time, data{1,6}.Ax,data{1,6}.Time, data{1,6}.Ax_S1);
% xlabel('Time [s]')
% ylabel('Acceleration [g]');
% Plotter(1)
% hold all
