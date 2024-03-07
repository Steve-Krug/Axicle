% asm330_v_sbg_v19.m
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


%load('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleExport_341pm_Jan18_2024_PV_processed.mat');
load AxicleExport_341pm_Jan18_2024_PV_processed.mat

%sbgData = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\SBGCenterExport_341pm_Jan18_2024_PV.txt');
sbgData = readtable('SBGCenterExport_341pm_Jan18_2024_PV.txt');

% offset for 554pm Hindry: 2.4570 s
% offset for 341pm PV Jan 18: 7.175 s

time_offset = 7.175;

time_zeroed_s = time_s - time_s(1);
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(1)) + (time_offset);

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

lowerClip_s = 200;
upperClip_s = 3500;

figure(1)
subplot(3,1,1)
hold all
title('Accelerations')
plot(time_zeroed_s, Ax_g, time_sbg_zeroed_s, sbgData.AccelerometerX/GNCConstants.Gravity_mps2)
legend('ASM', 'SBG')
ylabel('Accel X [g]')
xlim([lowerClip_s upperClip_s])
grid on
subplot(3,1,2)
plot(time_zeroed_s, Ay_g, time_sbg_zeroed_s, sbgData.AccelerometerY/GNCConstants.Gravity_mps2)
ylabel('Accel Y [g]')
xlim([lowerClip_s upperClip_s])
legend('ASM', 'SBG')
grid on
subplot(3,1,3)
plot(time_zeroed_s, Az_g, time_sbg_zeroed_s, sbgData.AccelerometerZ/GNCConstants.Gravity_mps2)
ylabel('Accel Z [g]')
xlim([lowerClip_s upperClip_s])
legend('ASM', 'SBG')
grid on
xlabel('Time [s]')




figure(2)
subplot(3,1,1)
hold all
title('Rot. Rates')
plot(time_zeroed_s, Wx_dps, time_sbg_zeroed_s, sbgData.GyroscopeX)
ylabel('Rate X [dps]')
xlim([lowerClip_s upperClip_s])
legend('ASM', 'SBG')
grid on
ylim([-40 40])
subplot(3,1,2)
plot(time_zeroed_s, Wy_dps, time_sbg_zeroed_s, sbgData.GyroscopeY)
ylabel('Rate Y [dps]')
xlim([lowerClip_s upperClip_s])
legend('ASM', 'SBG')
grid on
ylim([-40 40])
subplot(3,1,3)
plot(time_zeroed_s, Wz_dps, time_sbg_zeroed_s, sbgData.GyroscopeZ)
ylabel('Rate Z [dps]')
xlim([lowerClip_s upperClip_s])
legend('ASM', 'SBG')
grid on
ylim([-40 40])
xlabel('Time [s]')
hold on




%% Sensor Fusion Comparison Against Roll Angle Truth

%Create time series object to make SBG data same rate as ASM330 data, then
%clip between

%TSSeries
sbgRoll_deg_tss = TSseries(sbgData.Roll, time_sbg_zeroed_s);
sbgRoll_deg_resampled = sbgRoll_deg_tss.resample(time_zeroed_s);
sbgWx_dps_tss = TSseries(sbgData.GyroscopeX, time_sbg_zeroed_s);
sbgWx_dps_resampled = sbgWx_dps_tss.resample(time_zeroed_s);

time_s_clipped = time_zeroed_s(1, find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s));
Wx_dps_clipped = Wx_dps(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
sbgRoll_deg_clipped = sbgRoll_deg_resampled.Data(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
sbgWx_dps_clipped = sbgWx_dps_resampled.Data(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
Ay_g_clipped = Ay_g(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);
Az_g_clipped = Az_g(find(time_zeroed_s > lowerClip_s & time_zeroed_s < upperClip_s),1);

figure(3)
hold on
title('ASM vs. SBG Clipped Time')
plot(time_s_clipped, Wx_dps_clipped, time_s_clipped, sbgWx_dps_clipped)
xlabel('Time [s]')
ylabel('Rate X (Roll) [dps]')
legend('ASM Raw', 'SBG Raw')
Plotter(1)

%% For sweeping tau's
% tau_s_hp = 12;
% tau_s = linspace(30, 1000, 25);
% for i = 1:length(tau_s)
%     [~, thetaX_comp_deg_opt, ~, ~, ~, ~]...
%         = Axicle_Rate2Angle_Comp_v1(time_s_clipped, Wx_dps_clipped, Ay_g_clipped, Az_g_clipped, tau_s(i), tau_s_hp);
%     errorRMSE(i) = rmse(thetaX_comp_deg_opt, sbgRoll_deg_clipped);
% 
%     i/length(tau_s)
% end
% 
% 
% 
% figure(6)
% hold on
% plot(tau_s, errorRMSE)
% xlabel('Tau HP[s]')
% ylabel('Error [s]')
% grid on



% tau_s_lp_gyro = 2;
% 
% %angleAccel_LP, angleComp, angleAccelRaw, anglePureIntegration, gyro_LP_dps, gyro_HP_dps
% [angleAccel_LP_deg, thetaX_comp_deg, angleAccel_raw_deg, anglePureIntegration_HP_deg, gyroLP, gyroHP]...
%     = Axicle_Rate2Angle_Comp_v1_bandpass(time_s_clipped, Wx_dps_clipped, Ay_g_clipped, Az_g_clipped, tau_s, tau_s_hp, tau_s_lp_gyro);


tau_s_hp = 12;
tau_s = 500;
[angleAccel_LP_deg, thetaX_comp_deg, angleAccel_raw_deg, anglePureIntegration_HP_deg, gyroLP, gyroHP]...
    = Axicle_Rate2Angle_Comp_v1(time_s_clipped, Wx_dps_clipped, Ay_g_clipped, Az_g_clipped, tau_s, tau_s_hp);

figure(4)
plot(time_s_clipped, sbgRoll_deg_clipped, time_s_clipped, anglePureIntegration_HP_deg, time_s_clipped, thetaX_comp_deg)
grid on
ylabel('Angle [deg]')
legend('SBG Angle Est. "Truth"', 'Angle Pure Integration, High Pass', 'Complementary Band Pass')




figure(5)
hold all
title('ASM Complementary vs. SBG Roll Angle Est., optimized')

subplot(3,1,1)
plot(time_s_clipped, sbgRoll_deg_clipped, time_s_clipped, thetaX_comp_deg)
xlim([lowerClip_s upperClip_s])
ylim([-25 25])
Plotter(1)
grid on
ylabel('Angle [deg]')
legend('SBG Angle Est. "Truth"','Comp. w/ HP')

subplot(3,1,2)
plot(time_s_clipped, angleAccel_LP_deg, time_s_clipped, angleAccel_raw_deg, time_s_clipped, thetaX_comp_deg)
xlim([lowerClip_s upperClip_s])
ylim([-25 25])
ylabel('Angle [deg]')
legend('Low Pass Accel Angle', 'Raw Accel Angle Est.', 'Comp. w/ HP')
Plotter(1)
grid on

subplot(3,1,3)
plot(time_s_clipped, (sbgRoll_deg_clipped - thetaX_comp_deg))
xlim([lowerClip_s upperClip_s])
ylim([-10 10])
ylabel('Angle [deg]')
xlabel('Time [s]')
legend('SBG minus ASM Optimized Tau_s HP and Tau_s')
Plotter(1)

