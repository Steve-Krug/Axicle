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
time_sbg_zeroed_s = (sbgData.TimeStamp - sbgData.TimeStamp(end)) + ( 1.4320 - 4.7920)+1000;

%ASM330 Data
rssf_x = 1.13; %rate_sensitivity_scaling_factor
rssf_y = 1.10;
rssf_z = 1.14;
rso_x = 0.0;  %rate static offset, dps
rso_y = -0.0;
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

rate_offset_dps = 0;
thetaX_deg_loop = 0;
static_offset_deg = 0;
thetaX_deg_loop2 = 0; %static angle offset at t= 0? only if zero wasn't calibrated in the SBG software 1.5095
thetaX_deg_LP(1) = 0;
thetaX_deg_comp(1) = 0;

tau = 20;
[asm_roll_cf, asm_roll_pi, asm_roll_ac] = compfilter(time_zeroed_s, Ay_g, Az_g, Wx_dps, tau);
[sbg_roll_cf, sbg_roll_pi, sbg_roll_ac] = compfilter(time_sbg_zeroed_s, sbgData.AccelerometerY, sbgData.AccelerometerZ, sbgData.GyroscopeX, tau);

% Multiple Tau
[asm_tau5, ~, ~] = compfilter(time_zeroed_s, Ay_g, Az_g, Wx_dps, 15);
[asm_tau20, ~, ~] = compfilter(time_zeroed_s, Ay_g, Az_g, Wx_dps, 45);
asm_mt = min(abs(asm_tau5), abs(asm_tau20)) .* sign(asm_tau5);

asm_tau5_err = zeros(length(asm_tau5), 1);
asm_tau20_err = zeros(length(asm_tau5), 1);
asm_mt_err = zeros(length(asm_tau5), 1);

j = 1;

for i = 1:length(time_zeroed_s)

    asm_tau5_err(i) = asm_tau5(i) - sbgData.Roll(j);
    asm_tau20_err(i) = asm_tau20(i) - sbgData.Roll(j);
    asm_mt_err(i) = asm_mt(i) - sbgData.Roll(j);

    if time_zeroed_s(i) > time_sbg_zeroed_s(j)
        j = j + 1;
        if j > length(time_sbg_zeroed_s)
            break
        end
    end

end


tlo = tiledlayout(2,2);
tlo.TileSpacing = 'compact';
tlo.Padding = 'compact';

nexttile(1)
hold on
grid on
title('Pure Gyro Integration w/ Calibration')
plot(time_sbg_zeroed_s, sbgData.Roll, time_sbg_zeroed_s, sbg_roll_pi,  time_zeroed_s, asm_roll_pi)
legend('SBG "Truth"', 'SBG Pure Integration', 'ASM Pure Integration')
xlim([0 1000])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')

nexttile(3)
hold on
grid on
title('Complementary Filter, Tau = ' + string(tau) + ' seconds')
plot(time_sbg_zeroed_s, sbgData.Roll, time_sbg_zeroed_s, sbg_roll_cf, time_zeroed_s, asm_roll_cf)
legend('SBG "Truth"', 'SBG Complementary Filter', 'ASM Complementary Filter')
xlim([0 1000])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')

nexttile(2)
hold on
grid on
title('Complementary Filter, Tau Test')
plot(time_sbg_zeroed_s, sbgData.Roll, time_zeroed_s, asm_tau5, time_zeroed_s, asm_tau20, time_zeroed_s, asm_mt)
legend('SBG "Truth"', 'ASM Tau = 5', 'ASM Tau = 20', 'ASM, Minimum between Tau = 5 and 20 Tau')
xlim([0 1000])
xlabel('Time [s]')
ylabel('Roll Angle [deg]')

nexttile(4)
hold on
grid on
title('Complementary Filter, Tau Test')
plot(time_sbg_zeroed_s, zeros(length(time_sbg_zeroed_s),1), time_zeroed_s, asm_tau5_err, time_zeroed_s, asm_tau20_err, time_zeroed_s, asm_mt_err)
legend('SBG "Truth"', 'ASM Tau = 5', 'ASM Tau = 20', 'ASM, Minimum between Tau = 5 and 20 Tau')
xlim([0 1000])
xlabel('Time [s]')
ylabel('Difference from Truth [deg]')


function [roll_cf, roll_pi, roll_ac] = compfilter(T, Ay, Az, Wx, tau)

    % Cheat the bias calibration for roll rate.  Can't really do this.
    roll_rate_bias = trapz(T, Wx) / (T(end) - T(1));
    Wx = Wx - roll_rate_bias;
    roll_pi = cumtrapz(T, Wx); 

    % Calculate roll as indicated by the acceleration vector
    roll_ac = atand(Ay ./ Az);                     
    roll_ac(isnan(roll_ac)) = 0;
    dt = diff(T);
    roll_cf = zeros(length(T),1);

    for i = 2:length(dt)
        
        alpha = tau / (tau + dt(i-1));
        roll_cf(i) = alpha * (roll_cf(i-1) + Wx(i) * dt(i-1)) + (1-alpha) * roll_ac(i);

    end

end
