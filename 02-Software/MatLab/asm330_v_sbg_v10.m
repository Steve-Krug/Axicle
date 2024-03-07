% asm330_v_sbg_v10.m
% 1/15/24
% S. Krug
% Notes:
% 1/15/24 - Edited for high Ay runs at Zamperini Field parking lot
% 1/18/24 - Edited for PV 1hr run
% 1/22/24 - v4 Reedited for zamperini
% 1/22/24 - v5 for hindry no lever arm
% 1/22/24 - v6 for for hindry
% 1/22/24 - v7 changed to function
clear all
close all
clc


load('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleExport_554pm_Jan20_Hindry_NoLeverArm_NoGPS_Processed.mat');

sbgData = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\SBGCenterExport_554pm_Jan20_2024_Hindry_NoLeverArm_NoGPS.txt');


time_zeroed_s = time_s - time_s(1);
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(1)) + (-3.330 +  5.8420);

%ASM330 Data
rssf_x = 1.13; %rate_sensitivity_scaling_factor
rssf_y = 1.10;
rssf_z = 1.14;
rso_x = 0.4;  %rate static offset, dps
rso_y = -0.4;
rso_z = 0;
Wx_dps = gyros_dps(:,2)*rssf_x + rso_x;
Wy_dps = gyros_dps(:,1)*rssf_y + rso_y;
Wz_dps = -gyros_dps(:,3)*rssf_z + rso_z;

aso_x = 0.0125; %acceleration static offset, g
aso_y = 0.03;
aso_z = -0.0165;

Ax_g = accels_g(:,2) + aso_x;
Ay_g = -accels_g(:,1) + aso_y;
Az_g = accels_g(:,3) + aso_z;


figure(1)
hold on
title('ASM330 Accel vs. Time')
plot(time_zeroed_s, Ax_g, time_sbg_zeroed_s, sbgData.AccelerometerX/GNCConstants.Gravity_mps2,...
    time_zeroed_s, Ay_g, time_sbg_zeroed_s, -sbgData.AccelerometerY/GNCConstants.Gravity_mps2,...
    time_zeroed_s, Az_g, time_sbg_zeroed_s, -sbgData.AccelerometerZ/GNCConstants.Gravity_mps2)
legend('ASM X', 'SBG X', 'ASM Y', 'SBG Y','ASM Z', 'SBG Z')
xlabel('Time [s]')
ylabel('Accel Y [g]')
Plotter(1)


figure(2)
hold on
title('ASM330 Rate vs. Time')
subplot(3,1,1)
Plotter(1)
plot(time_zeroed_s, Wx_dps, time_sbg_zeroed_s, sbgData.GyroscopeX)
ylim([-40 40])
subplot(3,1,2)
plot(time_zeroed_s, Wy_dps, time_sbg_zeroed_s, sbgData.GyroscopeY)
ylim([-40 40])
Plotter(1)
subplot(3,1,3)
plot(time_zeroed_s, Wz_dps, time_sbg_zeroed_s, sbgData.GyroscopeZ)
ylim([-40 40])
legend('ASM X', 'SBG X', 'ASM Y', 'SBG Y','ASM Z', 'SBG Z')
xlabel('Time [s]')
ylabel('Rates [dps]')
Plotter(1)
hold on






%% Sensor Fusion Comparison Against Roll Angle Truth
%Complementary Alpha
tau_s = 50; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
%High Pass Alpha
freq_hz = 0.1; %hz


tau_s_sweep = linspace(1, 100, 10);
freq_hz_sweep = linspace(0.02, 2, 10);
%Create time series object to make SBG data same rate as ASM330 data, then
%clip between

% %TSSeries AVx
% resample_time_noise_s = linspace(0, time_s_zeroed_end, newFreq*time_s_zeroed_end);
% Wx_dps_noise_tss = TSseries(Wx_dps_HP_Noise_filt, time_s_zeroed); %Create time series object of segmented noise data
% Wx_dps_noise_resampled = Wx_dps_noise_tss.resample(resample_time_noise_s);

sbgRoll_dps_tss = TSseries(sbgData.Roll, time_sbg_zeroed_s);
sbgRoll_dps_resampled = sbgRoll_dps_tss.resample(time_zeroed_s);

lowerClip_s = 200;
upperClip_s = 360;


time_s_clipped = time_zeroed_s(1, find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s));
Wx_dps_clipped = Wx_dps(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
sbgRoll_dps_clipped = sbgRoll_dps_resampled.Data(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);

% figure(4)
% plot(time_s_clipped, Wx_dps_clipped, time_s_clipped, sbgRoll_dps_clipped)
figure(6)
hold on
plot(time_s_clipped, sbgRoll_dps_clipped)

for i = 1:length(tau_s_sweep)
    for j = 1:length(freq_hz_sweep)
        thetaX_deg_complementary_HP = Rate2Angle_Complementary_HP_v1(time_s_clipped, Wx_dps_clipped, Ay_g, Az_g, tau_s_sweep(i), freq_hz_sweep(j));
        
        errorRMSE(i,j) = rmse(thetaX_deg_complementary_HP', sbgRoll_dps_clipped);

        figure(6)
        hold all
        plot(time_s_clipped, thetaX_deg_complementary_HP)
       
    end
    hold on
i/length(tau_s_sweep) * 100
end

figure(5)
[X,Y] = meshgrid(tau_s_sweep, freq_hz_sweep);
Z = errorRMSE;

surf(X,Y,Z)

thetaX_deg_complementary_HP_1 = Rate2Angle_Complementary_HP_v1(time_s_clipped, Wx_dps_clipped, Ay_g, Az_g, tau_s_sweep(10), freq_hz_sweep(1));
thetaX_deg_complementary_HP_2 = Rate2Angle_Complementary_HP_v1(time_s_clipped, Wx_dps_clipped, Ay_g, Az_g, tau_s_sweep(1), freq_hz_sweep(10));
          

figure(4)
plot(time_s_clipped, sbgRoll_dps_clipped, time_s_clipped, thetaX_deg_complementary_HP_1, time_s_clipped, thetaX_deg_complementary_HP_2)





% figure(3)
% subplot(2,1,1)
% hold on
% title('SBG Angle v. ASM Complementary')
% plot(time_zeroed_s, sbgRoll_dps_resampled.Data, time_zeroed_s, thetaX_deg_complementary_HP)
% legend('SBG', 'ASM Complementary, Tau = x with HP')
% % xlim([-215 -175])
% xlabel('Time [s]')
% ylabel('Roll Angle [deg]')
% Plotter(1)
%
% subplot(2,1,2)
% plot(time_sbg_zeroed_s, -sbgData.AccelerometerY/GNCConstants.Gravity_mps2, time_zeroed_s, Ay_g)
% xlabel('Time [s]')
% ylabel('Ay [g]')
% legend('SBG Ay', 'ASM Ay')
% % xlim([-200 0])
% ylim([-1.25 1.25])
% Plotter(1)