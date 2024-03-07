%% VTTIDataProcessing_v1.m
% 8/20/23
% S. Krug
% Notes:
%
% 8/20/23 - Initial start
% 1/29/24 - Rehash for harddrive data and rest of imported online data.
% Redo integration with filtering

clear all
close all
clc

%% Load Shore Up Data
load('C:\Users\SteveKrug\OneDrive - Axicle\Public\9. Data\VTTI Truck IMU Data\Initial Data\initial_VTTI_data_matlab.mat')
%data{1,29} is rollover data. File_ID: 3,403,354. Conflict start: 1,447,975 -
%1,457,929
fs = 10; %hz
ts = 1/fs; %s
resample_rate = 100; %hz

%Scrape 4 columns of data
%Format of columns is: (file_id, timestamp, variableID, data value)
Data3403354 = find(table2array(data{1,2}(:,1)) == 3403354);
allData_FileID_3403354 = table2array(data{1,2}(Data3403354,:));

% Az_g_indices_all = find(allData3403354(:,3) == -107);
% Az_g_indices_EventID_3190358 = find(Az_g_indices_all())
% Roll_dps =
% Vx_mps =
%% Find Event
EventID_3190358_indices = find( (allData_FileID_3403354(:,2) > 1447975) & (allData_FileID_3403354(:,2) < 1457929) ); %find time stamp range
EventID_3190358_data_all = allData_FileID_3403354(EventID_3190358_indices,:); %Clip all data in event range


%% Find Data Channels
Ax_g_indices_all = find( EventID_3190358_data_all(:,3) == -126); %column 3 is data channel type
Ax_g = EventID_3190358_data_all(Ax_g_indices_all, 4); % column 4 is actual data

Ay_g_indices_all = find( EventID_3190358_data_all(:,3) == -127); %column 3 is data channel type
Ay_g = EventID_3190358_data_all(Ay_g_indices_all, 4); % column 4 is actual data

Az_g_indices_all = find( EventID_3190358_data_all(:,3) == -107); %column 3 is data channel type
Az_g = EventID_3190358_data_all(Az_g_indices_all, 4); % column 4 is actual data

Omegax_dps_indices_all = find( EventID_3190358_data_all(:,3) == -105); %column 3 is data channel type
Omegax_dps = EventID_3190358_data_all(Omegax_dps_indices_all, 4); % column 4 is actual data

Omegay_dps_indices_all = find( EventID_3190358_data_all(:,3) == -106); %column 3 is data channel type
Omegay_dps = EventID_3190358_data_all(Omegay_dps_indices_all, 4); % column 4 is actual data

Omegaz_dps_indices_all = find( EventID_3190358_data_all(:,3) == -104); %column 3 is data channel type
Omegaz_dps = EventID_3190358_data_all(Omegaz_dps_indices_all, 4); % column 4 is actual data

time_s = linspace(0,ts*length(Az_g),length(Az_g))';

% figure(1)
% plot(time_s,Az_g);
% xlabel('Time [s]')
% ylabel('Az [g]')
% Plotter(1)

%% Time Series Modification
resample_time_vector_s = linspace(0, ts*length(Az_g), resample_rate*ts*length(Az_g));


Ax_tss_g = TSseries(Ax_g, time_s); %takes in orginal data (data, time vector) %10hz
Ax_tss_resample_g = Ax_tss_g.resample(resample_time_vector_s); %resample at 100hz
Ay_tss_g = TSseries(Ay_g, time_s); %takes in orginal data (data, time vector) %10hz
Ay_tss_resample_g = Ay_tss_g.resample(resample_time_vector_s); %resample at 100hz
Az_tss_g = TSseries(Az_g, time_s); %takes in orginal data (data, time vector) %10hz
Az_tss_resample_g = Az_tss_g.resample(resample_time_vector_s); %resample at 100hz
Omegax_tss_dps = TSseries(Omegax_dps, time_s); %takes in orginal data (data, time vector) %10hz
Omegax_tss_resample_dps = Omegax_tss_dps.resample(resample_time_vector_s); %resample at 100hz
Omegay_tss_dps = TSseries(Omegay_dps, time_s); %takes in orginal data (data, time vector) %10hz
Omegay_tss_resample_dps = Omegay_tss_dps.resample(resample_time_vector_s); %resample at 100hz
Omegaz_tss_dps = TSseries(Omegaz_dps, time_s); %takes in orginal data (data, time vector) %10hz
Omegaz_tss_resample_dps = Omegaz_tss_dps.resample(resample_time_vector_s); %resample at 100hz



plot(time_s,Az_g, Az_tss_resample_g.Time, Az_tss_resample_g.Data);
xlabel('Time [s]')
ylabel('Az [g]')
Plotter(1)

%% Filters
newFreq = 100; %After decimating
% Filters for profile roughness rebuilding, zero mean.
% (cutoff freq/(sample freq/2))
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


Ax_filtered_g = filtfilt(H,G,Ax_tss_resample_g.Data);
Ay_filtered_g = filtfilt(H,G,Ay_tss_resample_g.Data);
Az_filtered_g = filtfilt(H,G,Az_tss_resample_g.Data);
Omegax_filtered_dps = filtfilt(H,G,Omegax_tss_resample_dps.Data);
Omegay_filtered_dps = filtfilt(H,G,Omegay_tss_resample_dps.Data);
Omegaz_filtered_dps = filtfilt(H,G,Omegaz_tss_resample_dps.Data);


figure(1)
title('Accelerations')
subplot(3,1,1)
plot(time_s,Ax_g, Ax_tss_resample_g.Time, Ax_tss_resample_g.Data, Ax_tss_resample_g.Time, Ax_filtered_g);
xlabel('Time [s]')
ylabel('Ax [g]')
ylim([-2 2])
legend('10Hz Raw', '100Hz Resampled', 'Low Pass 7Hz Butter 1st Order')
Plotter(1)

subplot(3,1,2)
plot(time_s,Ay_g, Ay_tss_resample_g.Time, Ay_tss_resample_g.Data, Ay_tss_resample_g.Time, Ay_filtered_g);
xlabel('Time [s]')
ylabel('Ay [g]')
ylim([-2 2])
legend('10Hz Raw', '100Hz Resampled', 'Low Pass 7Hz Butter 1st Order')
Plotter(1)

subplot(3,1,3)
plot(time_s,Az_g, Az_tss_resample_g.Time, Az_tss_resample_g.Data, Az_tss_resample_g.Time, Az_filtered_g);
xlabel('Time [s]')
ylabel('Az [g]')
ylim([-2 2])
legend('10Hz Raw', '100Hz Resampled', 'Low Pass Butter 7Hz 1st Order')
Plotter(1)

figure(2)
title('Rotational Rates')
subplot(3,1,1)
plot(time_s,Omegax_dps, Omegax_tss_resample_dps.Time, Omegax_tss_resample_dps.Data, Omegax_tss_resample_dps.Time, Omegax_filtered_dps);
xlabel('Time [s]')
ylabel('Omegax [deg/s]')
ylim([-100 100])
legend('10Hz Raw', '100Hz Resampled', 'Low Pass 7Hz Butter 7Hz 1st Order')
Plotter(1)

subplot(3,1,2)
plot(time_s,Omegay_dps, Omegay_tss_resample_dps.Time, Omegay_tss_resample_dps.Data, Omegay_tss_resample_dps.Time, Omegay_filtered_dps);
xlabel('Time [s]')
ylabel('Omegay [deg/s]')
ylim([-100 100])
legend('10Hz Raw', '100Hz Resampled', 'Low Pass 7Hz Butter 1st Order')
Plotter(1)

subplot(3,1,3)
plot(time_s,Omegaz_dps, Omegaz_tss_resample_dps.Time, Omegaz_tss_resample_dps.Data, Omegaz_tss_resample_dps.Time, Omegaz_filtered_dps);
xlabel('Time [s]')
ylabel('Omegaz [deg/s]')
ylim([-100 100])
legend('10Hz Raw', '100Hz Resampled', 'Low Pass 7Hz Butter 1st Order')
Plotter(1)

%% Theta Integration, Complementary Filter

Thetax_dps = zeros(length(Omegax_filtered_dps),1);
Thetay_dps = zeros(length(Omegax_filtered_dps),1);
Thetaz_dps = zeros(length(Omegax_filtered_dps),1);
Thetax_dps_loop =0;
Thetay_dps_loop =0;
Thetaz_dps_loop =0;

dt = 1/newFreq;
tau = 0.98; %complementary filter constant 1

for k = 1:length(Omegax_filtered_dps)

    Thetax_dps_loop = tau * (Thetax_dps_loop + Omegax_filtered_dps(k) * dt) + (1-tau) * (Az_filtered_g(k));
    Thetay_dps_loop = tau * (Thetay_dps_loop + Omegay_filtered_dps(k) * dt) + (1-tau) * (Az_filtered_g(k));
    Thetaz_dps_loop = tau * (Thetaz_dps_loop + Omegaz_filtered_dps(k) * dt) + (1-tau) * (Ay_filtered_g(k));

    Thetax_dps(k) = Thetax_dps_loop;
    Thetay_dps(k) = Thetay_dps_loop;
    Thetaz_dps(k) = Thetay_dps_loop;

end
%% Tau Sweeps
tau_sweeps = linspace(0,1.0,100);
Thetax_dps_loop_tau_sweep = 0;
hold on
for j = 1:length(tau_sweeps)
    for m = 1:length(Omegax_filtered_dps)

        Thetax_dps_loop_tau_sweep = tau_sweeps(j) * (Thetax_dps_loop_tau_sweep + Omegax_filtered_dps(m) * dt) + (1-tau_sweeps(j)) * (Az_filtered_g(m));

        Thetax_dps_tau_sweep(m,j) = Thetax_dps_loop_tau_sweep;

    end
    figure(4)
    hold on
    plot(Omegaz_tss_resample_dps.Time, Thetax_dps_tau_sweep(:,j))
    xlabel('Time [s]')
    ylabel('Roll Angle [deg]')
    ylim([-25 25])
    legend('Az Complemented, 0 < Tau < 1.0')
    Plotter(1)

end

figure(3)
title('Rotational Angles, Tau = 0.98')

subplot(3,1,1)
plot(Omegaz_tss_resample_dps.Time,Thetax_dps)
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
ylim([-25 25])
legend('Az Complemented')
Plotter(1)

subplot(3,1,2)
plot(Omegaz_tss_resample_dps.Time,Thetay_dps)
xlabel('Time [s]')
ylabel('Pitch Angle [deg]')
ylim([-25 25])
legend('Az Complemented')
Plotter(1)


subplot(3,1,3)
plot(Omegaz_tss_resample_dps.Time,Thetaz_dps)
xlabel('Time [s]')
ylabel('Yaw Angle [deg]')
ylim([-25 25])
legend('Ay Complemented')
Plotter(1)
