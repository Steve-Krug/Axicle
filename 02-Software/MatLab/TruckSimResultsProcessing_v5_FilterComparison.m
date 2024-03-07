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

%% Sine Steer Results
%folder_path = uigetdir(); %C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_results\Steer_sine
% folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\TruckSim\Saved_Results\Test Plan\All\";

folder_path = "C:\Users\SteveKrug\OneDrive - Axicle\Public\9. Data\231217_Data Sets\Figure 8 with Banks";

files = dir(fullfile(folder_path, '*.csv'));
h = waitbar(0,'Loading data...');
for i = 1:length(files)
    filename = fullfile(folder_path, files(i).name);
    data{i} = readtable(filename);
    filenames_all(i) = filename;
    waitbar(i/length(files))
end

runIndex = 1;

figure(2)
title('Figure 8')
hold on
plot(data{1,runIndex}.Time, data{1,runIndex}.Ay_S1);
xlabel('Time [s]')
ylabel('Acceleration Y at Sensor [g]');
Plotter(1)
hold all

figure(3)
title('Figure 8')
hold on
plot(data{1,runIndex}.Time, data{1,runIndex}.Az_S1);
xlabel('Time [s]')
ylabel('Acceleration Z at Sensor [g]');
Plotter(1)
hold all

figure(4)
title('Figure 8')
hold on
plot(data{1,runIndex}.Time, data{1,runIndex}.Ax_S1);
xlabel('Time [s]')
ylabel('Acceleration X at Sensor [g]');
Plotter(1)
hold all

figure(5)
title('Figure 8')
hold on
plot(data{1,runIndex}.Time, data{1,runIndex}.AV_R);
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]');
Plotter(1)
hold all

figure(6)
title('Figure 8')
hold on
plot(data{1,runIndex}.Time, data{1,runIndex}.Roll);
xlabel('Time [s]')
ylabel('Roll Angle [deg]');
Plotter(1)
hold all

Time_s = data{1,runIndex}.Time;
Vx_kph = data{1,runIndex}.Vx;
Vy_kph = data{1,runIndex}.Vy;
Vz_kph = data{1,runIndex}.Vz;
AVx_dps = data{1,runIndex}.AV_R;
AVy_dps = data{1,runIndex}.AV_P;
AVz_dps = data{1,runIndex}.AV_Y;

Pitch_deg = data{1,runIndex}.Pitch;
Roll_deg = data{1,runIndex}.Roll;
Yaw_deg = data{1,runIndex}.Yaw;

% 11 - Ax
% 12 - Ay
% 13 - Az

Ax_S_g = data{1,runIndex}.Ax_S1;
Ay_S_g = -data{1,runIndex}.Ay_S1;
Az_S_g = data{1,runIndex}.Az_S1;

% 17 - Steer_SW

%% Filter Settings

dt = mean(gradient(data{1,runIndex}.Time));

newFreq = 1/dt; %After decimating
% Filters for profile roughness rebuilding, zero mean.
% (cutoff freq/(sample freq/2))
filt_freq = [0.05/(newFreq/2);...   %Accelerations high pass frequency
    1/(newFreq/2);...            %Velocity high pass frequency
    0.4/(newFreq/2);...             %Displacement high pass frequency
    4/(newFreq/2);...             %general low pass settings
    0.1/(newFreq/2);...             %Isolate MT filter, Acc
    0.175/(newFreq/2);...             %Isolate MT filter, Vel
    0.01/(newFreq/2)];                 %string pot low pass


[B,A]=butter(1,filt_freq(1),'High'); %Accelerations high pass frequency
% [D,C]=butter(1,filt_freq(2),'High'); %Velocity high pass frequency
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


%% Take high pass filter of real ASM330LHHx Data to add to trucksim signal

load('C:\Users\SteveKrug\OneDrive - Axicle\Public\9. Data\231217_Data Sets\axicleData1043_ASM330LHHx_Oct23.mat');



% Time Clipping used for Rates and Accel Data
lowerClip_s = 62620 + 28.61; %s
upperClip_s = 62620 + 28.61 + 70; %s


time_s = axicleData1( find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),2);
time_s_zeroed = time_s -time_s(1);
Ax_g = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),8));
Ay_g = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),7));
Az_g = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),9));
Wx_dps = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),5));
Wy_dps =  -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),4));
Wz_dps =  -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),6));

asm330_dt = mean(gradient(time_s_zeroed));

asm330_fs = round(1/asm330_dt);

[D,C]=butter(1,4/(asm330_fs/2),'High'); %Velocity high pass frequency

% High pass filtered noise signal from real ASM330 Data
Wx_dps_HP_Noise_filt = filtfilt(D, C, Wx_dps);

% figure(1)
% hold on
% plot(time_s_zeroed, Wx_dps, time_s_zeroed, Wx_dps_HP_Noise_filt)
% legend('Raw Data', '35hz High Pass')
% title('Rollover Test Data, ASM330LHHx')
% xlabel('Time [s]')
% ylabel('Roll Angle [deg]');
% Plotter(1);
% hold all
%

% Time Series to resample at the same frequency
time_s_zeroed_end = time_s_zeroed(length(time_s_zeroed));

%TSSeries AVx
resample_time_noise_s = linspace(0, time_s_zeroed_end, newFreq*time_s_zeroed_end);
Wx_dps_noise_tss = TSseries(Wx_dps_HP_Noise_filt, time_s_zeroed); %Create time series object of segmented noise data
Wx_dps_noise_resampled = Wx_dps_noise_tss.resample(resample_time_noise_s);



figure(1)
hold on
plot(time_s_zeroed, Wx_dps, time_s_zeroed, Wx_dps_HP_Noise_filt, resample_time_noise_s, Wx_dps_noise_resampled.Data)
legend('Raw Data', '35hz High Pass', '35Hz high pass time series object resampled 1kHz')
title('Rollover Test Data, ASM330LHHx')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]')
Plotter(1);
hold all
%% Integrate without filtering, adding random vibration noise from real test

%Create noise array same length as sim signal

% Wx_noise = [Wx_dps_noise_resampled.Data(100:60100); Wx_dps_noise_resampled.Data(100:60099)];
Wx_noise = Wx_dps_noise_resampled.Data(100:58128);
%add noise to sim data

AVx_dps_ASM330Noise = AVx_dps + Wx_noise;


figure(8)
title('Figure 8')
hold on
plot(Time_s, AVx_dps, Time_s, AVx_dps_ASM330Noise);
legend('AVx from Sim','AVx from Sim with ASM330 Noise')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]');
Plotter(1)
hold all



Roll_int_deg_loop1 = 0;
Roll_int_deg_loop2 = 0;
for i = 1:length(AVx_dps)

    Roll_int_deg_loop1 = (Roll_int_deg_loop1 + AVx_dps(i)*dt);
    Roll_deg_pureIntegration(i) = Roll_int_deg_loop1;

    Roll_int_deg_loop2 = (Roll_int_deg_loop2 + AVx_dps_ASM330Noise(i)*dt);
    Roll_deg_pureIntegration_Noise(i) = Roll_int_deg_loop2;

end

cumtrapzInt_deg = cumtrapz(Time_s, AVx_dps);


% 
% figure(7)
% title('Figure 8 10% negative grade: Pure Integration vs. Truth vs. pure integration with noise')
% hold on
% plot(Time_s, Roll_deg, Time_s, Roll_deg_pureIntegration, Time_s, Roll_deg_pureIntegration_Noise)
% legend('Truth Roll','Pure Integrated', 'Pure Integrated with ASM330 Vibration Noise Added, No Low Pass')
% xlabel('Time [s]')
% ylabel('Roll Angle [deg]')
% Plotter(1)
% hold all



%% Integrate with low pass filter

%Doesn't even seem to make a difference


%% Complementary Filter Roll Angle Comparison without filtering

tau_s = 1000; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter


thetaX_deg_loop = 0;
thetaX_deg_loop2 = 0;

for i = 1:length(AVx_dps_ASM330Noise)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel = unwrap(atan2(Ay_S_g(i), Az_S_g(i) + pi) * 180/pi);

    if isnan( thetaX_deg_fromAccel)
        thetaX_deg_fromAccel(i) = 0;

    else
        thetaX_deg_fromAccel(i) =  thetaX_deg_fromAccel;
    end

    thetaX_deg_loop = (1-alpha) * (thetaX_deg_loop + AVx_dps_ASM330Noise(i)*dt) + (alpha) * thetaX_deg_fromAccel(i);
    thetaX_deg_complementary(i) = thetaX_deg_loop;

    % thetaX_deg_loop2 = (thetaX_deg_loop2 + AVxSimNoise_filtered_dps(i)*dt);
    % thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

end


figure(7)
title('Figure 8 10% negative grade: Pure Integration vs. Truth vs. pure integration with noise')
hold on
plot(Time_s, Roll_deg, Time_s, Roll_deg_pureIntegration, Time_s, Roll_deg_pureIntegration_Noise, Time_s, thetaX_deg_complementary, Time_s, cumtrapzInt_deg)
legend('Truth Roll','Pure Integrated', 'Pure Integrated with ASM330 Vibration Noise Added, No Low Pass','Complementary Integrated ASM330 Noise Roll Rate & Accels, no Low Pass Filter', 'CumTrapz ML')
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
Plotter(1)
hold all



%% Complementary Filter Roll Angle Comparisoin with filtering


