%% VTTIDataProcessing_v2.m
% 8/20/23
% S. Krug
% Notes:
%
% 8/20/23 - Initial start
% 1/29/24 - Rehash for harddrive data and rest of imported online data.
% Redo integration with new comp. functions
% 1/30/24 - The passcode for the AEGIS Padlock HD is 4078192350762598

clear
close all
clc

%% Load Data
load('initial_VTTI_data_matlab.mat')
%data{1,29} is rollover data. File_ID: 3,403,354. Conflict range: 1,447,975 -1,457,928
fs = 10; %hz
dt = 1/fs; %s
resample_rate = 100; %hz
%Scrape 4 columns of data
%Format of columns is: (file_id, timestamp, variableID, data value)
Data3403354 = find(table2array(data{1,2}(:,1)) == 3403354);
allData_FileID_3403354 = table2array(data{1,2}(Data3403354,:));
%% Find Event
CONFLICT_BEGIN = 1447975;
CONFLICT_END = 1457928;
% EVENT ID: 3,190,358;
% SUBJECT REACTION: 1,448,610;
% IMPACT PROXIMITY: 1,453,400;
% Notes from OBMS Spreadsheet:
% "Subject Vehicle evasive maneuver - Other Actions - driver steered right and then left and braked
% Post-Maneuver control - Combination of Previous - vehicle rotated counterclockwise and slid laterally.
% Secondary Task 1 - Object in Vehicle, Other - The driver is holding a
% bottle in his right hand, although he doesn't drink out of it during the event."
% EventID_3190358_indices = find( (allData_FileID_3403354(:,2) > CONFLICT_BEGIN) & (allData_FileID_3403354(:,2) < CONFLICT_END) ); %find time stamp range
% EventID_3190358_data_all = allData_FileID_3403354(EventID_3190358_indices,:); %Clip all data in event range
%% Align time stamps
% The variable list:
%The Accel data is in g.
%The Gyro data is in degrees/second.
% Accel_x = -126
% Accel_y = -127
% Accel_z = -107
% Gyro_x (roll) = -105
% Gyro_y (pitch) = -106
% Gyro_z (yaw) = -104
% Speed = -626
% The data are asynchronous as we had discussed, but if you’d like it squared we can do that.
% All data should be at 10Hz, including speed. Variance should be pretty low, but some files may have certain elements missing.

%Sort rows of entire matrix "data" based on values in 2nd column. 2nd
%column should be time in milliseconds
data_sorted_3403354 = sortrows(allData_FileID_3403354, 2);

%% Find Data Channels
Vx_mps_indices_all = find( data_sorted_3403354(:,3) == -626); %column 3 is data channel type
Vx_mps = data_sorted_3403354(Vx_mps_indices_all, 4); % column 4 is actual data
time_ms_Vx = data_sorted_3403354(Vx_mps_indices_all, 2); % column 2 is time in milliseconds
time_s_Vx = (time_ms_Vx - time_ms_Vx(1))*GNCConstants.SecToMillisecond;

Ax_g_indices_all = find( data_sorted_3403354(:,3) == -126); %column 3 is data channel type
Ax_g = data_sorted_3403354(Ax_g_indices_all, 4); % column 4 is actual data
time_ms_Ax = data_sorted_3403354(Ax_g_indices_all, 2); % column 2 is time in milliseconds
time_s_Ax = (time_ms_Ax - time_ms_Ax(1))*GNCConstants.SecToMillisecond;

Ay_g_indices_all = find( data_sorted_3403354(:,3) == -127); %column 3 is data channel type
Ay_g = data_sorted_3403354(Ay_g_indices_all, 4); % column 4 is actual data
time_ms_Ay = data_sorted_3403354(Ay_g_indices_all, 2); % column 2 is time in milliseconds
time_s_Ay = (time_ms_Ay - time_ms_Ax(1))*GNCConstants.SecToMillisecond;

Az_g_indices_all = find( data_sorted_3403354(:,3) == -107); %column 3 is data channel type
Az_g = data_sorted_3403354(Az_g_indices_all, 4); % column 4 is actual data
time_ms_Az = data_sorted_3403354(Az_g_indices_all, 2); % column 2 is time in milliseconds
time_s_Az = (time_ms_Az - time_ms_Az(1))*GNCConstants.SecToMillisecond;

Wx_dps_indices_all = find( data_sorted_3403354(:,3) == -105); %column 3 is data channel type
Wx_dps = data_sorted_3403354(Wx_dps_indices_all, 4); % column 4 is actual data
time_ms_Wx = data_sorted_3403354(Wx_dps_indices_all, 2); % column 2 is time in milliseconds
time_s_Wx = (time_ms_Wx - time_ms_Wx(1))*GNCConstants.SecToMillisecond;

Wy_dps_indices_all = find( data_sorted_3403354(:,3) == -106); %column 3 is data channel type
Wy_dps = data_sorted_3403354(Wy_dps_indices_all, 4); % column 4 is actual data
time_ms_Wy = data_sorted_3403354(Wy_dps_indices_all, 2); % column 2 is time in milliseconds
time_s_Wy = (time_ms_Wy - time_ms_Wy(1))*GNCConstants.SecToMillisecond;

Wz_dps_indices_all = find( data_sorted_3403354(:,3) == -104); %column 3 is data channel type
Wz_dps = data_sorted_3403354(Wz_dps_indices_all, 4); % column 4 is actual data
time_ms_Wz = data_sorted_3403354(Wz_dps_indices_all, 2); % column 2 is time in milliseconds
time_s_Wz = (time_ms_Wz - time_ms_Wz(1))*GNCConstants.SecToMillisecond;

allTime_s = [time_s_Ax time_s_Ay time_s_Az time_s_Wx time_s_Wy time_s_Wz]; % checker to make sure all time signals lineup

%time_s_Vx is 38 indexes shorter than the others

%% Time Series Modification
totalTime = allTime_s(end,1) - allTime_s(1,1);
time_100_s = linspace(0, totalTime, resample_rate*totalTime); %`00hz time vector

Vx_tss_mps = TSseries(Vx_mps, time_s_Vx); %takes in orginal data (data, time vector) %10hz
Vx_100_mps = Vx_tss_mps.resample(time_100_s); %resample at 100hz

Ax_tss_g = TSseries(Ax_g, time_s_Ax); %takes in orginal data (data, time vector) %10hz
Ax_100_g = Ax_tss_g.resample(time_100_s); %resample at 100hz
Ay_tss_g = TSseries(Ay_g, time_s_Ay); %takes in orginal data (data, time vector) %10hz
Ay_100_g = Ay_tss_g.resample(time_100_s); %resample at 100hz
Az_tss_g = TSseries(Az_g, time_s_Az); %takes in orginal data (data, time vector) %10hz
Az_100_g = Az_tss_g.resample(time_100_s); %resample at 100hz
Wx_tss_dps = TSseries(Wx_dps, time_s_Wx); %takes in orginal data (data, time vector) %10hz
Wx_100_dps = Wx_tss_dps.resample(time_100_s); %resample at 100hz
Wx_100_dps.Data(isnan(Wx_100_dps.Data)) = 0;
Wy_tss_dps = TSseries(Wy_dps, time_s_Wy); %takes in orginal data (data, time vector) %10hz
Wy_100_dps = Wy_tss_dps.resample(time_100_s); %resample at 100hz
Wy_100_dps.Data(isnan(Wy_100_dps.Data)) = 0;
Wz_tss_dps = TSseries(Wz_dps, time_s_Wz); %takes in orginal data (data, time vector) %10hz
Wz_100_dps = Wz_tss_dps.resample(time_100_s); %resample at 100hz
Wz_100_dps.Data(isnan(Wz_100_dps.Data)) = 0;

figure(1)
hold on
subplot(3,1,1)
plot(time_s_Ax, Ax_g, time_100_s, Ax_100_g.Data, time_s_Ay, Ay_g, time_100_s, Ay_100_g.Data, time_s_Az, Az_g, time_100_s, Az_100_g.Data)
title('Event ID: 3,190,358 Rollover')
legend('Ax raw', 'Ay raw', 'Az raw',...
    'Ax resampled', 'Ay resampled', 'Az resampled')
ylabel('Accels [g]')
Plotter(1)
hold on
subplot(3,1,2)
plot(time_s_Wx, Wx_dps, time_100_s, Wx_100_dps.Data, time_s_Wy, Wy_dps, time_100_s, Wy_100_dps.Data, time_s_Wz, Wz_dps, time_100_s, Wz_100_dps.Data)
legend('Wx raw', 'Wy raw', 'Wz raw',...
    'Wx resampled', 'Wy resampled', 'Wz resampled')

ylabel('Rate [dps]')
Plotter(1)
hold on
subplot(3,1,3)
plot(time_s_Vx, Vx_mps)
legend('Vx raw')
ylabel('Speed [m/s]')
xlabel('Time [s]')
Plotter(1)

%% Filters
newFreq = resample_rate; %After decimating
% Filters for profile roughness rebuilding, zero mean.
filt_freq = [0.05/(newFreq/2);...   %Accelerations high pass frequency
    0.05/(newFreq/2);...            %Velocity high pass frequency
    0.4/(newFreq/2);...             %Displacement high pass frequency
    7/(newFreq/2);...             %general low pass settings
    0.1/(newFreq/2);...             %Isolate MT filter, Acc
    0.175/(newFreq/2);...             %Isolate MT filter, Vel
    0.01/(newFreq/2)];                 %string pot low pass
[B,A]=butter(1,filt_freq(1),'High'); %Accelerations high pass frequency
[D,C]=butter(1,filt_freq(2),'High'); %Velocity high pass frequency
% [F,E]=butter(3,filt_freq(3),'High'); %Displacements high pass frequency
[H,G]=butter(1,filt_freq(4),'Low'); %general low pass settings
% [J,I]=butter(1,filt_freq(5),'Low'); %Isolate MT filter, Acc
% [L,K]=butter(1,filt_freq(6),'Low'); %Isolate MT filter, Vel
% [N,M]=butter(1,filt_freq(7),'Low'); %Isolate MT filter, Displ
% [P,O]=butter(1,filt_freq(8),'Low'); %General Low Pass, camera data
% [R,Q]=butter(1,filt_freq(9),'Low'); %flight accel low pass
% [T,S]=butter(1,filt_freq(10),'Low');%flight rates low pass
% [V,U]=butter(1,filt_freq(11),'Low');%test accel low pass
% [X,W]=butter(1,filt_freq(12),'Low');%test rates low pass
% [Z,Y]=butter(1,filt_freq(13),'Low'); %general low pass string pot
Ax_filt_g = filtfilt(H,G,Ax_100_g.Data);
Ay_filt_g = filtfilt(H,G,Ay_100_g.Data);
Az_filt_g = filtfilt(H,G,Az_100_g.Data);
Wx_filt_dps = filtfilt(H,G,Wx_100_dps.Data);
Wy_filt_dps = filtfilt(H,G,Wy_100_dps.Data);
Wz_filt_dps = filtfilt(H,G,Wz_100_dps.Data);

figure(2)
hold on
subplot(2,1,1)
plot(time_s_Ax, Ax_g, time_100_s, Ax_filt_g, time_s_Ay, Ay_g, time_100_s, Ay_filt_g, time_s_Az, Az_g, time_100_s, Az_filt_g)
title('Event ID: 3,190,358 Rollover')
legend('Ax raw','Ax filtered', 'Ay raw', 'Ay filtered','Az raw', 'Az filtered')
ylabel('Accels [g]')
xlim([1444 1464])
Plotter(1)
hold on
subplot(2,1,2)
plot(time_s_Wx, Wx_dps, time_100_s, Wx_filt_dps, time_s_Wy, Wy_dps, time_100_s, Wy_filt_dps, time_s_Wz, Wz_dps, time_100_s, Wz_filt_dps)
legend('Wx raw', 'Wx filtered', 'Wy raw','Wy filtered', 'Wz raw','Wz filtered')
xlabel('Time [s]')
ylabel('Rate [dps]')
xlim([1444 1464])
Plotter(1)


%% Complementary Filter


tau_s_hp = 12;
tau_s = 500;
[angleAccel_LP_deg, thetaX_comp_deg, angleAccel_raw_deg, anglePureIntegration_HP_deg, gyroLP, gyroHP]...
    = Axicle_Rate2Angle_Comp_v1(time_100_s, Wx_filt_dps, Ay_filt_g, -Az_filt_g, tau_s, tau_s_hp);

figure(4)
subplot(3,1,1)
plot(time_100_s, thetaX_comp_deg, time_100_s, angleAccel_raw_deg, time_100_s, angleAccel_LP_deg)
grid on
ylabel('Angle [deg]')
title('VTTI Real Rollover Run')
legend('Axicle Complementary, Roll Angle', 'angle accel raw', 'angle accel lp')
% xlim([1444 1464])
%% 
Plotter(1)

subplot(3,1,2)
plot(time_100_s, Wx_filt_dps, time_100_s, Wy_filt_dps, time_100_s, Wz_filt_dps)
ylabel('rate [deg/s]')
legend('RollR', 'PitchR', 'YawR')
% xlim([1444 1464])
subplot(3,1,3)
Plotter(1)

subplot(3,1,3)
plot(time_100_s, Ax_filt_g, time_100_s, Ay_filt_g, time_100_s, Az_filt_g)
legend('Ax', 'Ay', 'Az')
% xlim([1444 1464])
Plotter(1)
ylabel('Accel [g]')
xlabel('Time [s]')


