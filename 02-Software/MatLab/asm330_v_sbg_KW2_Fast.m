% asm330_v_sbg_v6.m
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

load('AxicleExport_554pm_Jan20_Hindry_NoLeverArm_NoGPS_Processed.mat');

sbgData = readtable('SBGCenterExport_554pm_Jan20_2024_Hindry_NoLeverArm_NoGPS.txt');

time_zeroed_s = time_s - time_s(end)+1000;
time_zeroed_s = time_zeroed_s.';
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(end)) + (1.4320 - 4.7920)+1000;

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

aso_x = 0.0; %acceleration static offset, g
aso_y = 0.0;
aso_z = -0.0;

Ax_g = accels_g(:,2) + aso_x;
Ay_g = -accels_g(:,1) + aso_y;
Az_g = accels_g(:,3) + aso_z;

tau = 20;
[asm_roll_cf, asm_roll_pi, asm_roll_ac, asm_roll_ac_cor] = compfilter(time_zeroed_s, Ay_g, Az_g, Wx_dps, tau, 0.0);
[sbg_roll_cf, sbg_roll_pi, sbg_roll_ac, sbg_roll_ac_cor] = compfilter(time_sbg_zeroed_s, sbgData.AccelerometerY, sbgData.AccelerometerZ, sbgData.GyroscopeX, tau, 0.0);

j = 1;

asm_cf_err = zeros(length(asm_roll_cf),1);
sbg_cf_err = sbg_roll_cf - sbgData.Roll;

for i = 1:length(time_zeroed_s)

    asm_cf_err(i) = asm_roll_cf(i) - sbgData.Roll(j);

    if time_zeroed_s(i) > time_sbg_zeroed_s(j)
        j = j + 1;
        if j > length(time_sbg_zeroed_s)
            break
        end
    end

end


tlo = tiledlayout(3,1);
tlo.TileSpacing = 'compact';
tlo.Padding = 'compact';

nexttile(1)
hold on
grid on
title('Pure Gyro Integration w/ Calibration')
plot(time_sbg_zeroed_s, sbgData.Roll, time_sbg_zeroed_s, sbg_roll_pi,  time_zeroed_s, asm_roll_pi, time_zeroed_s, asm_roll_ac_cor)
legend('SBG "Truth"', 'SBG Pure Integration', 'ASM Pure Integration', 'ASM Pure Integration w/Correction')
xlim([0 1000])
ylim([-20 20])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
hold off

nexttile(2)
hold on
grid on
title('Complementary Filter, Tau = ' + string(tau) + ' seconds')
plot(time_sbg_zeroed_s, sbgData.Roll, time_sbg_zeroed_s, sbg_roll_cf, time_zeroed_s, asm_roll_cf)
legend('SBG "Truth"', 'SBG Complementary Filter', 'ASM Complementary Filter')
xlim([0 1000])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
hold off

nexttile(3)
hold on
grid on
title('Error from "Truth"')
plot(time_sbg_zeroed_s, zeros(length(time_sbg_zeroed_s),1), time_sbg_zeroed_s, sbg_cf_err, time_zeroed_s, asm_cf_err)
legend('SBG "Truth"', 'SBG Complementary Filter', 'ASM Complementary Filter Error')
xlim([0 1000])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
hold off


function [roll_cf, roll_pi, roll_ac, roll_pi_cor] = compfilter(T, Ay, Az, Wx, tau, rrb)

    % Roll rate bias smoothing coefficient
    bias_smooth_coef = 0.0001;
    
    roll_cf = zeros(length(T),1);
    roll_pi = zeros(length(T),1);
    roll_ac = zeros(length(T),1);
    roll_pi_cor = zeros(length(T),1);
    rrb = zeros(length(T),1);

    alpha = tau / (tau + mean(diff(T)));

    Tsize = length(T)
    Wxsize = length(Wx)

    roll_pi(1:end) = cumtrapz(Wx, T);
    rrb(2:end) = cumprod((1-bias_smooth_coef) * Wx(1:end-1)) + bias_smooth_coef * Wx(2:end);
    roll_ac = atand(Ay ./ Az);

    assignin('base','rrb',rrb)

    roll_acSIZE = length(roll_ac)

    %test1 = length(alpha * (roll_cf(1:end-1) + (Wx(2:end)-rrb(2:end))))
    %test2 = length(diff(T(2:end))) + (1-alpha) * roll_ac(2:end)

    roll_cf(2:end) = alpha * (roll_cf(1:end-1) + (Wx(2:end)-rrb(2:end)) .* diff(T)) + (1-alpha) * roll_ac(2:end);

%{
    for i = 2:length(T)

        dt = T(i) - T(i-1);
        
        % Calculate average roll rate during timestep to make the integration 
        % a little more accurate
        Wxi = (Wx(i) + Wx(i-1))/2;

        % Update the roll rate bias.  We know the true roll angle must be
        % small, so the majority of roll calculated over a long period of
        % time must be from gyro bias.  This is just a dumb smoothing 
        % function of the raw roll rate.
        rrb = (1-bias_smooth_coef)*rrb + bias_smooth_coef*Wxi;

        % Calculate roll using pure integration
        roll_pi(i) = roll_pi(i-1) + Wxi*dt;

        % Calculate roll pure using integration with the rate bias correction
        roll_pi_cor(i) = roll_pi_cor(i-1) + (Wxi-rrb)*dt;

        % Calculate roll as indicated by the acceleration vector
        roll_ac(i) = atand(Ay(i) / Az(i));
        if isnan(roll_ac(i))
            roll_ac(i) = 0;
        end
        
        alpha = tau / (tau + dt);
        roll_cf(i) = alpha * (roll_cf(i-1) + (Wxi-rrb) * dt) + (1-alpha) * roll_ac(i);

    end

%}

end
