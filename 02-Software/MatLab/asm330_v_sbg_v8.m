% asm330_v_sbg_v8.m
% 1/15/24
% S. Krug
% Notes:
% 1/15/24 - Edited for high Ay runs at Zamperini Field parking lot
% 1/18/24 - Edited for PV 1hr run
% 1/22/24 - v4 Reedited for zamperini
% 1/22/24 - v5 for hindry no lever arm
% 1/22/24 - v6 for for hindry  no lever arm, no gps
clear all
close all
clc


load('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleExport_554pm_Jan20_Hindry_NoLeverArm_NoGPS_Processed.mat');

sbgData = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\SBGCenterExport_554pm_Jan20_2024_Hindry_NoLeverArm_NoGPS.txt');


time_zeroed_s = time_s - time_s(end);
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(end)) + ( 1.4320 - 4.7920); 

%ASM330 Data
rssf_x = 1.0; %rate_sensitivity_scaling_factor
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
subplot(3,1,1)
plot(time_zeroed_s, Ax_g, time_sbg_zeroed_s, sbgData.AccelerometerX/GNCConstants.Gravity_mps2)
subplot(3,1,2)
plot(time_zeroed_s, Ay_g, time_sbg_zeroed_s, -sbgData.AccelerometerY/GNCConstants.Gravity_mps2)
subplot(3,1,3)
plot(time_zeroed_s, Az_g, time_sbg_zeroed_s, -sbgData.AccelerometerZ/GNCConstants.Gravity_mps2)
legend('ASM X', 'SBG X', 'ASM Y', 'SBG Y','ASM Z', 'SBG Z')
xlabel('Time [s]')
ylabel('Accel Y [g]')
Plotter(1)


figure(2)
hold on
title('ASM330 Rate vs. Time')
subplot(3,1,1)
plot(time_zeroed_s, Wx_dps, time_sbg_zeroed_s, sbgData.GyroscopeX)
subplot(3,1,2)
plot(time_zeroed_s, Wy_dps, time_sbg_zeroed_s, sbgData.GyroscopeY)
subplot(3,1,3)
plot(time_zeroed_s, Wz_dps, time_sbg_zeroed_s, sbgData.GyroscopeZ)
legend('ASM X', 'SBG X', 'ASM Y', 'SBG Y','ASM Z', 'SBG Z')
xlabel('Time [s]')
ylabel('Rates [dps]')
Plotter(1)






%% Sensor Fusion Comparison Against Roll Angle Truth

% Time constant filter design, exponential decay function
dt = mean(gradient(time_zeroed_s));

%Complementary Alpha
tau_s = 5; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter

%High Pass Alpha
freq_hz = .2; %hz
tau_s_hp = 1/freq_hz; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha_hp = 1 - exp(-dt/tau_s_hp); % Alpha for 1st order filter

% roll_angle_filt = zeros(size(Roll_deg));
% accel_angle_filt = zeros(size(Accel_Angle_deg));
%
% roll_angle_filt(1) = Roll_deg(1); %Start at same offset
% accel_angle_filt(1) = Accel_Angle_deg(1); %Start at same offset


% rate_offset_dps = ((-66.808 +82.0875)/(7158.75-7103.92));
rate_offset_dps = 0;
thetaX_deg_loop = 0; %1.5095
% static_offset_deg = 3.25;
static_offset_deg = 0;
thetaX_deg_loop2 = 0; %static angle offset at t= 0? only if zero wasn't calibrated in the SBG software 1.5095
thetaX_deg_LP(1) = 0;
thetaX_deg_comp(1) = 0;

for i = 2:length(Wx_dps)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel_test = (unwrap(atan2(Ay_g(i), sqrt(Ax_g(i)^2 + Az_g(i)^2) ) ) * 180/pi) - static_offset_deg;

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;
    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_loop2 = (thetaX_deg_loop2 + Wx_dps(i)*dt); %Pure integration
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

    thetaX_deg_comp(i) = ((1-alpha) * thetaX_deg_fromIntegration(i)) + (alpha * thetaX_deg_fromAccel(i)); %Apply acceleration complementary filter

    thetaX_deg_LP(i) = (thetaX_deg_comp(i) * alpha_hp) + (1-alpha_hp) * thetaX_deg_LP(i-1); %Low pass the gyro data

    
    thetaX_deg_complementary_HP(i) = (thetaX_deg_comp(i) - (thetaX_deg_LP(i))); %High pass the gyro data from the low pass


    % thetaX_deg_C_HP(i) = thetaX_deg_complementary(i) - (thetaX_deg_complementary(i) * (1-alpha_hp));




end



figure(3)
subplot(2,1,1)
hold on
title('SBG Angle v. ASM Complementary')
plot(time_sbg_zeroed_s, sbgData.Roll, time_zeroed_s, thetaX_deg_complementary_HP, time_zeroed_s, thetaX_deg_fromAccel, time_zeroed_s, thetaX_deg_LP, time_zeroed_s, thetaX_deg_fromIntegration, time_zeroed_s, thetaX_deg_comp)
legend('SBG', 'ASM Complementary, Tau = x with HP', 'ASM Estimate from Accel', 'Low Pass', 'pure integration', 'complementary only')
xlim([-860 -720])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
Plotter(1)


subplot(2,1,2)
plot(time_sbg_zeroed_s, -sbgData.AccelerometerY/GNCConstants.Gravity_mps2, time_zeroed_s, Ay_g)
xlabel('Time [s]')
ylabel('Ay [g]')
legend('SBG Ay', 'ASM Ay')
xlim([-860 -720])
ylim([-1.25 1.25])
Plotter(1)