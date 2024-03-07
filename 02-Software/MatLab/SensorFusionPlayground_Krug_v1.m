%% SensorFusionPlayground_Krug_v1.m
% 9/24/23
% Notes:
%
%
%

clc
close all
clear
%% Load Data
%Noise Data
load('C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\Electrical\IMU\all_sensor_noise_time_history.mat');

%Sim Data
dir = 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\';
tData = load(append(dir,'230909_SWD_n1000_50_100_185_225_5k_25k_v1_ResultsTractorRollovers.mat'));

%8th run in these sims was a rollover in SWD
timeSim_s = tData.data{1,8}.Time;
AVxSim_dps = tData.data{1,8}.AVx;
AySim_g = tData.data{1,8}.Ay;
AzSim_g = tData.data{1,8}.Az;
Roll_deg = tData.data{1,8}.Roll(1:end-1);

timeSim_end_s = timeSim_s(end);

%% Filters
newFreq = 1000; %After decimating
% Filters for profile roughness rebuilding, zero mean.
% (cutoff freq/(sample freq/2))
filt_freq = [0.05/(newFreq/2);...   %Accelerations high pass frequency
    0.05/(newFreq/2);...            %Velocity high pass frequency
    0.4/(newFreq/2);...             %Displacement high pass frequency
    100/(newFreq/2);...             %general low pass settings
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


%% Create Time Series Objects to align/reshape noise data to sim data

ts_sim_s = timeSim_s(2) - timeSim_s(1);
f_sim_hz = 1/ts_sim_s;

% Time Clipping used for Rates and Accel Data
lowerClip_s = 100; %s
upperClip_s = lowerClip_s + timeSim_end_s; %s

%Roll Rate
time_omegax_noise_segmented = time_omegax_noise(find(time_omegax_noise > lowerClip_s & time_omegax_noise < upperClip_s));
omegax_noise_segmented = omegax_noise(find(time_omegax_noise > lowerClip_s & time_omegax_noise < upperClip_s));
%Ay
time_Ay_noise_segmented = time_Ay_noise(find(time_Ay_noise > lowerClip_s & time_Ay_noise < upperClip_s));
Ay_noise_segmented = Ay_noise(find(time_Ay_noise > lowerClip_s & time_Ay_noise < upperClip_s));
%Az
time_Az_noise_segmented = time_Az_noise(find(time_Az_noise > lowerClip_s & time_Az_noise < upperClip_s));
Az_noise_segmented = Az_noise(find(time_Az_noise > lowerClip_s & time_Az_noise < upperClip_s));

%TSSeries AVx
resample_time_noise_s = linspace(0, timeSim_end_s, f_sim_hz*timeSim_end_s);
AVx_noise_tss = TSseries(omegax_noise_segmented', time_omegax_noise_segmented'-lowerClip_s); %Create time series object of segmented noise data
AVx_noise_resampled = AVx_noise_tss.resample(resample_time_noise_s);
%TSSeries Ay
Ay_noise_tss = TSseries(Ay_noise_segmented', time_Ay_noise_segmented'-lowerClip_s);
Ay_noise_resampled = Ay_noise_tss.resample(resample_time_noise_s);
%TSSeries Az
Az_noise_tss = TSseries(Az_noise_segmented', time_Az_noise_segmented'-lowerClip_s);
Az_noise_resampled = Az_noise_tss.resample(resample_time_noise_s);



figure(1)
hold on
plot(time_omegax_noise, omegax_noise)
plot(time_omegax_noise_segmented, omegax_noise_segmented)
plot(AVx_noise_resampled.Time, AVx_noise_resampled.Data)
legend('Original OmegaX Noise', 'Clipped OmegaX Noise', 'Resampled OmegaX Noise @ Sim f_hz')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]')
Plotter(1);

%TSSeries Ay, Az
figure(5)
hold on
plot(time_Ay_noise, Ay_noise)
plot(time_Ay_noise_segmented, Ay_noise_segmented)
plot(Ay_noise_resampled.Time, Ay_noise_resampled.Data)
legend('Original Ay Noise', 'Clipped Ay Noise', 'Resampled Ay Noise @ Sim f_hz')
xlabel('Time [s]')
ylabel('Ay [g]')
Plotter(1);

figure(6)
hold on
plot(time_Az_noise, Az_noise)
plot(time_Az_noise_segmented, Az_noise_segmented)
plot(Az_noise_resampled.Time, Az_noise_resampled.Data)
legend('Original Az Noise', 'Clipped Az Noise', 'Resampled Az Noise @ Sim f_hz')
xlabel('Time [s]')
ylabel('Az [g]')
Plotter(1);



% Create new time vector with noise
%Roll Rate
timeSimNoise_s = timeSim_s(1:end-1);
AVxSimNoise_dps = AVx_noise_resampled.Data + AVxSim_dps(1:end-1);
%Ay
AySimNoise_g = Ay_noise_resampled.Data + AySim_g(1:end-1);
%Az
AzSimNoise_g = Az_noise_resampled.Data + AzSim_g(1:end-1) - 1; % minus 1g




% Take out NaN
AVxSimNoise_dps(isnan(AVxSimNoise_dps)) = 0;
AySimNoise_g(isnan(AySimNoise_g)) = 0;
AzSimNoise_g(isnan(AzSimNoise_g)) = 0;


figure(2)
hold on
plot(timeSim_s, AVxSim_dps,'LineWidth', 5)
plot(timeSimNoise_s, AVxSimNoise_dps)
legend('Original Sim Data', 'Sim Data w/ Raw Noise')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]')
Plotter(1);

figure(7)
hold on
plot(timeSim_s, AySim_g,'LineWidth', 5)
plot(timeSimNoise_s, AySimNoise_g)
legend('Original Sim Data', 'Sim Data w/ Raw Noise')
xlabel('Time [s]')
ylabel('Ay [g]')
Plotter(1);

figure(8)
hold on
plot(timeSim_s, AzSim_g,'LineWidth', 5)
plot(timeSimNoise_s, AzSimNoise_g)
legend('Original Sim Data', 'Sim Data w/ Raw Noise')
xlabel('Time [s]')
ylabel('Az [g]')
Plotter(1);



%% Make Plots
AVxSimNoise_filtered_dps = filtfilt(H,G, AVxSimNoise_dps);

figure(3)
hold on
plot(timeSimNoise_s, AVxSimNoise_dps,'LineWidth', 1)
plot(timeSimNoise_s, AVxSimNoise_filtered_dps,'LineWidth', 2)
legend('Sim Data w/ Raw Noise', '100hz Low Pass')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]')
Plotter(1);

figure(4)
hold on
plot(timeSim_s, AVxSim_dps,'LineWidth', 4)
plot(timeSimNoise_s, AVxSimNoise_filtered_dps,'LineWidth', 1)
legend('Sim Data w/ Raw Noise', '100hz Low Pass')
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]')
Plotter(1);


%% Sensor Fusion Comparison Against Roll Angle Truth

% Thetax_deg_accel = atan(data{1,dataSignal}.Ay(k)/Az_offset_g(k))*57.3;


AySimNoiseGrav_g = AySimNoise_g - 1*sind(Roll_deg); %Add gravity effect
AzSimNoiseGrav_g = AzSimNoise_g - 1*cosd(Roll_deg); %Add gravity effect

Accel_Angle_deg = (unwrap(atan2(AySimNoise_g, AzSimNoiseGrav_g) + pi) * 180/pi) - 360;

%Integrate filtered roll rate


%Time constant filter design, exponential decay function
dt = mean(gradient(timeSim_s));
tau_s = 80; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter

roll_angle_filt = zeros(size(Roll_deg));
accel_angle_filt = zeros(size(Accel_Angle_deg));

roll_angle_filt(1) = Roll_deg(1); %Start at same offset
accel_angle_filt(1) = Accel_Angle_deg(1); %Start at same offset



thetaX_deg_loop = 0;
thetaX_deg_loop2 = 0;

for i = 1:length(AVxSimNoise_filtered_dps)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel_test = unwrap(atan2(AySimNoise_g(i), AzSimNoise_g(i) + pi) * 180/pi);

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;

    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_loop = (1-alpha) * (thetaX_deg_loop + AVxSimNoise_filtered_dps(i)*dt) + (alpha) * thetaX_deg_fromAccel(i);
    thetaX_deg_complementary(i) = thetaX_deg_loop;

    thetaX_deg_loop2 = (thetaX_deg_loop2 + AVxSimNoise_filtered_dps(i)*dt);
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

end



figure(9)
plot(timeSim_s(1:end-1), Roll_deg, timeSim_s(1:end-1), thetaX_deg_fromAccel, timeSim_s(1:end-1), thetaX_deg_complementary)
xlabel('Time [s]')
ylabel('Roll [deg]')
% ylim([-20 20])
legend('True Roll from Sim','Inferred Roll from Ay, Az',' Complementary Filtered Roll (100hz Low Pass on Roll Rate')
Plotter(1)
grid on

