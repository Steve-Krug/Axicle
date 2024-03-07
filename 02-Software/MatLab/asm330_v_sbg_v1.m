% asm330_v_sbg_v1.m
% 1/11/24
% S. Krug
% Notes:
clear all
close all
clc


load('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleDeskTest1_processed_v2.mat');

sbgData = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\SBGDeskTest1.txt');


time_zeroed_s = time_s - time_s(end);
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(end)) + 1.2450;

rssf = 1.15; %rate_sensitivity_scaling_factor

Wx_dps = gyros_dps(:,2)*rssf;
Wy_dps = gyros_dps(:,1);
Wz_dps = -gyros_dps(:,3);

Ax_g = accels_g(:,2);
Ay_g = accels_g(:,1);
Az_g = accels_g(:,3);


figure(1)
hold on
title('ASM330 Accel vs. Time')
plot(time_zeroed_s, Ax_g, time_sbg_zeroed_s, sbgData.AccelerometerX/GNCConstants.Gravity_mps2,...
    time_zeroed_s, Ay_g, time_sbg_zeroed_s, sbgData.AccelerometerY/GNCConstants.Gravity_mps2,...
    time_zeroed_s, Az_g, time_sbg_zeroed_s, sbgData.AccelerometerZ/GNCConstants.Gravity_mps2)
legend('ASM X', 'SBG X', 'ASM Y', 'SBG Y','ASM Z', 'SBG Z')
xlabel('Time [s]')
ylabel('Accel Y [g]')
Plotter(1)


figure(2)
hold on
title('ASM330 Rate vs. Time')
plot(time_zeroed_s, Wx_dps, time_sbg_zeroed_s, sbgData.GyroscopeX,...
    time_zeroed_s, Wy_dps, time_sbg_zeroed_s, sbgData.GyroscopeY,...
    time_zeroed_s, Wz_dps, time_sbg_zeroed_s, sbgData.GyroscopeZ)
legend('ASM X', 'SBG X', 'ASM Y', 'SBG Y','ASM Z', 'SBG Z')
xlabel('Time [s]')
ylabel('Rates [dps]')
Plotter(1)






%% Sensor Fusion Comparison Against Roll Angle Truth

% Time constant filter design, exponential decay function
dt = mean(gradient(time_zeroed_s));

tau_s = 15; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter

% roll_angle_filt = zeros(size(Roll_deg));
% accel_angle_filt = zeros(size(Accel_Angle_deg));
%
% roll_angle_filt(1) = Roll_deg(1); %Start at same offset
% accel_angle_filt(1) = Accel_Angle_deg(1); %Start at same offset


rate_offset_dps = ((-66.808 +82.0875)/(7158.75-7103.92));
% rate_offset_dps = 0;
thetaX_deg_loop = -4.39;
static_offset_deg = 3.25;
thetaX_deg_loop2 = 0;



for i = 1:length(Wx_dps)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel_test = -(unwrap(atan2(Ay_g(i), Az_g(i)) * 180/pi) - static_offset_deg);

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;

    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_loop = (1-alpha) * (thetaX_deg_loop + (Wx_dps(i) + rate_offset_dps) *dt) + (alpha) * thetaX_deg_fromAccel(i);
    thetaX_deg_complementary(i) = thetaX_deg_loop;

    thetaX_deg_loop2 = (thetaX_deg_loop2 + Wx_dps(i)*dt);
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

     
end



figure(3)
hold on
title('SBG Angle v. ASM Complementary')
plot(time_sbg_zeroed_s, sbgData.Roll, time_zeroed_s, thetaX_deg_complementary)%, time_zeroed_s, thetaX_deg_fromAccel)
legend('SBG', 'ASM Complementary, Tau = 75', 'ASM Estimate from Accel')
% xlim([-7278 -7266])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
Plotter(1)

