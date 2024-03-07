%% TruckSimResultsProcessing_ComplementaryComparison_v1.m
% 3/21/23
% S. Krug
% Notes:
%
%  - Initial start
%

clear all
close all
clc

rolloverThreshold = 60; %deg
dataSignal = 115;
%% Sine Steer Results
%folder_path = uigetdir(); %C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Steer_sine
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_Results\Test Plan\All\";

% folder_path = "C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\";
load('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Test 7 Data Struct Only.mat');

for j = 1:length(data)
dataSet = table2array(data{1,j});
writematrix(dataSet,[num2str(j) '.csv'] )


end
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
%% Complementary Filter Channel
tau = [0.95, 0.99, 0.9999]'; %complementary filter constant 1

Thetax_CF_deg = zeros(length(data{1,dataSignal}.Time),3);
Thetax_deg_loop = 0;
Thetax_deg_loop2 = 0;
dt = data{1,dataSignal}.Time(2) - data{1,dataSignal}.Time(1);

%Take Derivative of Roll_R3

Roll_Rate_A3_dps = diff(data{1,dataSignal}.Roll_A3)/dt;
% Roll_Rate_Roll_dps = diff(data{1,dataSignal}.Roll)/dt;
Roll_Rate_Roll_dps = diff(data{1,dataSignal}.Roll_A3)/dt;

%Offset gravity
Az_offset_g = data{1,dataSignal}.Az - 1;




for m = 1:length(tau)

    for k = 1:length(Roll_Rate_Roll_dps)
        Thetax_deg_accel = atan(data{1,dataSignal}.Ay(k)/Az_offset_g(k))*57.3;
        Thetax_deg_loop = (tau(m) * (Thetax_deg_loop + Roll_Rate_Roll_dps(k) * dt)) + ((1-tau(m)) * Thetax_deg_accel) ;

        Thetax_CF_deg(k,m) = Thetax_deg_loop;
        if m == 1
         Thetax_deg_fromAccel(k) = atan(data{1,dataSignal}.Ay(k)/Az_offset_g(k))*57.3;
        Thetax_deg_loop2 = (Thetax_deg_loop2 + Roll_Rate_Roll_dps(k) * dt);
         Thetax_pureIntegration(k) = Thetax_deg_loop2;
        end
    end

end
hold on
figure(1)
plot(data{1,dataSignal}.Time, data{1,dataSignal}.Roll_A3, 'k', LineWidth=1)
hold on
plot(data{1,dataSignal}.Time(2:end), Thetax_pureIntegration', 'b')
figure(1)
hold on
plot(data{1,dataSignal}.Time, Thetax_CF_deg(:,1), data{1,dataSignal}.Time, Thetax_CF_deg(:,2),data{1,dataSignal}.Time, Thetax_CF_deg(:,3),data{1,dataSignal}.Time(2:end), Thetax_deg_fromAccel)
title('SWD')
% xlim([0 3.6])
xlabel('Time [s]')
ylabel('Roll Angle [deg]');
legend('Roll Angle, Truth','Roll Angle Integrated Truth', '0.99','0.999', '0.9995', 'angle from accel')
Plotter(1)
hold on


figure(2)
subplot(2,1,1)
plot(data{1,dataSignal}.Time, -data{1,dataSignal}.RolR_A3r, data{1,dataSignal}.Time(2:end), Roll_Rate_A3_dps, data{1,dataSignal}.Time(2:end), Roll_Rate_Roll_dps)
title('SWD')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]');
legend('Roll Rate Axle 3, Truth', 'Roll Rate Diff (derivative from Roll Angle Axle 3', 'Roll Rate Diff (derivative from Roll Angle, cg)');
Plotter(1)
subplot(2,1,2)
plot(data{1,dataSignal}.Time, data{1,dataSignal}.Az, data{1,dataSignal}.Time, Az_offset_g, data{1,dataSignal}.Time, data{1,dataSignal}.Ay)
xlabel('Time [s]')
ylabel('Az [g]');
legend('Az Raw', 'Az Gravity Offset', 'Ay')
Plotter(1)


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

