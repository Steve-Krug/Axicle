%% TruckSimResultsProcessing_v4_simple.m
% 8/21/23
% S. Krug
% Notes:
%
% 3/21/23 - Initial start
%

clear all
close all
clc

rolloverThreshold = 60; %deg
k = 1;
%% Sine Steer Results
%folder_path = uigetdir(); %C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Steer_sine
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_Results\Test Plan\All\";

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



figure(2)
title('SWD')
hold on
plot(data{1,6}.Time, data{1,6}.Ay,data{1,6}.Time, data{1,6}.Ay_S1);
xlabel('Time [s]')
ylabel('Acceleration [g]');
Plotter(1)
hold all

figure(3)
title('SWD')
hold on
plot(data{1,6}.Time, data{1,6}.Az,data{1,6}.Time, data{1,6}.Az_S1);
xlabel('Time [s]')
ylabel('Acceleration [g]');
Plotter(1)
hold all

figure(4)
title('SWD')
hold on
plot(data{1,6}.Time, data{1,6}.Ax,data{1,6}.Time, data{1,6}.Ax_S1);
xlabel('Time [s]')
ylabel('Acceleration [g]');
Plotter(1)
hold all

% for i = 1:length(files)
%     % hold all
%     % figure(1)
%     % plot(data{1,i}.Time, data{1,i}.Roll_2);
%     % title('SWD')
%     % xlabel('Time [s]')
%     % ylabel('Roll Angle [deg]');
%     % hold all
%     figure(2)
%     title('SWD')
%     plot(data{1,i}.Time, data{1,i}.RolR_A3r);
%     xlabel('Time [s]')
%     ylabel('Roll Rate [deg/s]');
%     hold all
%
%     % hold all
%     figure(5)
%     subplot(2,1,1)
%     title('SWD')
%     plot(data{1,i}.Time, data{1,i}.Roll_A3);
%     xlabel('Time [s]')
%     ylabel('Roll Angle[deg]');
%     % xlim([0 2])
%     hold all
%     subplot(2,1,2)
%     plot(data{1,i}.Time, data{1,i}.Ay);
%     xlabel('Time [s]')
%     ylabel('Ay [dg]');
%     % xlim([0 2])
%     hold all
%
%     figure(4)
%     title('SWD')
%     plot(data{1,i}.Roll_A3, data{1,i}.Ay);
%     title('SWD')
%     xlabel('Roll Angle [deg]')
%     ylabel('Lateral Acceleration, Unit 1 (cab) [g]');
%
%     hold all
%     figure(3)
%     if abs(data{1,i}.Roll_A3(end)) > rolloverThreshold
%         hold on
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'r');
%     rollovernumber(k) = i;
%     k = k+1;
%     else
%         hold on
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'k');
%
%     end
%             xlabel('Roll Angle [deg]')
%     ylabel('Roll Rate, Unit 1 (cab) [deg/s]');
%
%
% end

% %% CRC Results
%
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Constant_Radius\";
% files = dir(fullfile(folder_path, '*.csv'));
% h = waitbar(0,'Loading data...');
% for i = 1:length(files)
%     filename = fullfile(folder_path, files(i).name);
%     data{i} = readtable(filename);
%     filenames_all(i) = filename;
%
%     waitbar(i/length(files))
%
% end
%
%
% for i = 1:length(files)
%     hold all
%     figure(4)
%     plot(data{1,i}.Time, data{1,i}.Roll_A3);
%     title('CRC')
%     xlabel('Time [s]')
%     ylabel('Roll Angle [deg]');
%     Plotter(1)
%     hold all
%     figure(5)
%     plot(data{1,i}.Time, data{1,i}.RolR_A3r);
%     title('CRC')
%     xlabel('Time [s]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
%     hold all
%     figure(3)
%     if abs(data{1,i}.Roll_A3(end)) > rolloverThreshold
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'r');
%     else
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'k');
%     end
%
%     title('Roll Angle vs. Roll Rate, All Sims')
%     xlabel('Roll Angle [deg]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
% end
% Plotter(1)
%
% %%
%
% %% Crosswind Results
%
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Crosswind_Test\";
% files = dir(fullfile(folder_path, '*.csv'));
% h = waitbar(0,'Loading data...');
% for i = 1:length(files)
%     filename = fullfile(folder_path, files(i).name);
%     data{i} = readtable(filename);
%     filenames_all(i) = filename;
%
%     waitbar(i/length(files))
%
% end
%
%
% for i = 1:length(files)
%     hold all
%     figure(6)
%     plot(data{1,i}.Time, data{1,i}.Roll_A3);
%     title('Crosswind')
%     xlabel('Time [s]')
%     ylabel('Roll Angle [deg]');
%     Plotter(1)
%     hold all
%     figure(7)
%     plot(data{1,i}.Time, data{1,i}.RolR_A3r);
%     title('Crosswind')
%     xlabel('Time [s]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
%     hold all
%     figure(3)
%     if abs(data{1,i}.Roll_A3(end)) > rolloverThreshold
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'r');
%     else
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'k');
%     end
%
%     title('Roll Angle vs. Roll Rate, All Sims')
%     xlabel('Roll Angle [deg]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
% end
% Plotter(1)
% %% DLC Results
%
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\DLC\";
% files = dir(fullfile(folder_path, '*.csv'));
% h = waitbar(0,'Loading data...');
% for i = 1:length(files)
%     filename = fullfile(folder_path, files(i).name);
%     data{i} = readtable(filename);
%     filenames_all(i) = filename;
%
%     waitbar(i/length(files))
%
% end
%
%
% for i = 1:length(files)
%     hold all
%     figure(8)
%     plot(data{1,i}.Time, data{1,i}.Roll_A3);
%     title('DLC')
%     xlabel('Time [s]')
%     ylabel('Roll Angle [deg]');
%     Plotter(1)
%     hold all
%     figure(9)
%     plot(data{1,i}.Time, data{1,i}.RolR_A3r);
%     title('Roll Rate Time History')
%     xlabel('Time [s]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
%     hold all
%     figure(3)
%     if abs(data{1,i}.Roll_A3(end)) > rolloverThreshold
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'r');
%     else
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'k');
%     end
%
%     title('Roll Angle vs. Roll Rate, All Sims')
%     xlabel('Roll Angle [deg]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
% end
% Plotter(1)
% %% Step Steer
%
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Steer_step\";
% files = dir(fullfile(folder_path, '*.csv'));
% h = waitbar(0,'Loading data...');
% for i = 1:length(files)
%     filename = fullfile(folder_path, files(i).name);
%     data{i} = readtable(filename);
%     filenames_all(i) = filename;
%
%     waitbar(i/length(files))
%
% end
%
%
% for i = 1:length(files)
%     hold all
%     figure(10)
%     plot(data{1,i}.Time, data{1,i}.Roll_A3);
%     title('DLC')
%     xlabel('Time [s]')
%     ylabel('Roll Angle [deg]');
%     Plotter(1)
%     hold all
%     figure(11)
%     plot(data{1,i}.Time, data{1,i}.RolR_A3r);
%     title('DLC')
%     xlabel('Time [s]')
%     ylabel('Roll Rate [deg/s]');
%     Plotter(1)
%     hold all
%     figure(3)
%     if abs(data{1,i}.Roll_A3(end)) > rolloverThreshold
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'r');
%
%     else
%         plot(abs(data{1,i}.Roll_A3), abs(data{1,i}.RolR_A3r), 'k');
%     end
%
%     title('Roll Angle vs. Roll Rate, All Sims')
%     xlabel('Roll Angle [deg]')
%     ylabel('Roll Rate [deg/s]');
%     legend('No Rollover','Rollover')
%     Plotter(1)
% end

