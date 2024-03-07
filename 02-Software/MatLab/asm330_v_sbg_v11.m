% asm330_v_sbg_v11.m
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
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(1)) + (2.4830);

%ASM330 Data
rssf_x = 1.10; %rate_sensitivity_scaling_factor
rssf_y = 1.10;
rssf_z = 1.14;
rso_x = 0.4;  %rate static offset, dps
rso_y = -0.4;
rso_z = 0;
Wx_dps = gyros_dps(:,2)*rssf_x + rso_x;
Wy_dps = gyros_dps(:,1)*rssf_y + rso_y;
Wz_dps = -gyros_dps(:,3)*rssf_z + rso_z;

aso_x = 0.0125; %acceleration static offset, g
aso_y = -0.032;
aso_z = 0.016;

Ax_g = accels_g(:,2) + aso_x;
Ay_g = accels_g(:,1) + aso_y;
Az_g = accels_g(:,3) + aso_z;


figure(1)
subplot(3,1,1)
hold all
title('Accelerations')
plot(time_zeroed_s, Ax_g, time_sbg_zeroed_s, sbgData.AccelerometerX/GNCConstants.Gravity_mps2)
legend('ASM', 'SBG')
ylabel('Accel X [g]')
xlim([200 360])
grid on
subplot(3,1,2)
plot(time_zeroed_s, Ay_g, time_sbg_zeroed_s, sbgData.AccelerometerY/GNCConstants.Gravity_mps2)
ylabel('Accel Y [g]')
xlim([200 360])
legend('ASM', 'SBG')
grid on
subplot(3,1,3)
plot(time_zeroed_s, Az_g, time_sbg_zeroed_s, sbgData.AccelerometerZ/GNCConstants.Gravity_mps2)
ylabel('Accel Z [g]')
xlim([200 360])
legend('ASM', 'SBG')
grid on
xlabel('Time [s]')




figure(2)
subplot(3,1,1)
hold all
title('Rot. Rates')
plot(time_zeroed_s, Wx_dps, time_sbg_zeroed_s, sbgData.GyroscopeX)
ylabel('Rate X [dps]')
xlim([200 360])
legend('ASM', 'SBG')
grid on
ylim([-40 40])
subplot(3,1,2)
plot(time_zeroed_s, Wy_dps, time_sbg_zeroed_s, sbgData.GyroscopeY)
ylabel('Rate Y [dps]')
xlim([200 360])
legend('ASM', 'SBG')
grid on
ylim([-40 40])
subplot(3,1,3)
plot(time_zeroed_s, Wz_dps, time_sbg_zeroed_s, sbgData.GyroscopeZ)
ylabel('Rate Z [dps]')
xlim([200 360])
legend('ASM', 'SBG')
grid on
ylim([-40 40])
xlabel('Time [s]')
hold on






%% Sensor Fusion Comparison Against Roll Angle Truth
%Complementary Alpha
% tau_s = 5; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
%High Pass Alpha
% freq_hz = 0.1; %hz


% tau_s_sweep = linspace(1, 100, 10);
% freq_hz_sweep = linspace(0.02, 2, 10);
%Create time series object to make SBG data same rate as ASM330 data, then
%clip between

%TSSeries
sbgRoll_deg_tss = TSseries(sbgData.Roll, time_sbg_zeroed_s);
sbgRoll_deg_resampled = sbgRoll_deg_tss.resample(time_zeroed_s);
sbgWx_dps_tss = TSseries(sbgData.GyroscopeX, time_sbg_zeroed_s);
sbgWx_dps_resampled = sbgWx_dps_tss.resample(time_zeroed_s);

lowerClip_s = 200; %section with 2deg static dwell
upperClip_s = 360;

% lowerClip_s = 500;
% upperClip_s = 700;


time_s_clipped = time_zeroed_s(1, find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s));
Wx_dps_clipped = Wx_dps(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
sbgRoll_deg_clipped = sbgRoll_deg_resampled.Data(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
sbgWx_dps_clipped = sbgWx_dps_resampled.Data(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
Ay_g_clipped = Ay_g(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
Az_g_clipped = Az_g(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);



figure(6)
hold on
title('ASM vs. SBG Clipped Time')
plot(time_s_clipped, Wx_dps_clipped, time_s_clipped, sbgWx_dps_clipped)
xlabel('Time [s]')
ylabel('Rate X (Roll) [dps]')
legend('ASM Raw', 'SBG Raw')
Plotter(1)


tau_s = .05; %sec

[thetaX_accel, thetaX_comp_deg, thetaX_LP_deg, thetaX_HP_deg] = Rate2Angle_Complementary_HP_v3(time_s_clipped, Wx_dps_clipped, Ay_g_clipped, Az_g_clipped, tau_s);

% figure(7)
% hold all
% title('ASM Complementary vs. SBG Roll Angle Est.')
% plot(time_s_clipped, sbgRoll_deg_clipped, time_s_clipped, thetaX_accel, time_s_clipped, thetaX_comp_deg, time_s_clipped, thetaX_LP_deg, time_s_clipped, thetaX_HP_deg)
% grid on
% xlabel('Time [s]')
% ylabel('Angle [deg]')
% legend('SBG Angle Est. "Truth"','thetaX Accel', 'ASM Complementary', 'Low Pass', 'High Pass w/ Comp.')
% Plotter(1)

figure(7)
hold all
title('ASM Complementary vs. SBG Roll Angle Est.')
plot(time_s_clipped, sbgRoll_deg_clipped,  time_s_clipped, thetaX_comp_deg, time_s_clipped, thetaX_LP_deg, time_s_clipped, thetaX_HP_deg)
grid on
xlabel('Time [s]')
ylabel('Angle [deg]')
legend('SBG Angle Est. "Truth"', 'ASM Complementary', 'Low Pass', 'High Pass w/ Comp.')
Plotter(1)