function [angleAccel_LP, angleComp, anglePureIntegration_HP, gyro_LP] = Axicle_Rate2Angle_Comp_TimeDiscrete_v2(dt, rate_dps, thetaX_LP_Accel_deg, thetaX_Complementary_deg, thetaX_Integration_HP_deg, gyro_LP_dps, Ay_g, Az_g, tau_s, tau_s_hp)
%% Axicle, Inc. Not for redistribution without consent.
% Axicle_Rate2Angle_Comp_TimeDiscrete_v1.m
% Last update: 2/6/24
% Notes:
% - This script has been modified to accept time discrete steps for live serial port monitoring

%% Variable Key:
% dt - time increment
% rate_dps - Pass through rate amplitude from "ASM330LHHx"
% thetaX_LP_Accel_deg - must pass 1 accel angle estimate from previous time step
% thetaX_deg_Complementary_deg - must pass 1 comp angle estimate from
% previous time step
% thetaX_Integration_HP_deg - must pass 1 integrated HP angle estimate from
% previous time step
% Ay_g - lateral acceleration amplitude
% Az_g - vertical acceleration amplitude
% tau_s - time constant for accelerometer angle estimate

%% Functional Notes:
% - "AngleComp" should be stored on other end, then sent back into "thetaX_deg_Complementary_deg"
% - "angleAccel_LP" should be sent back into "thetaX_LP_Accel_deg"
% - "anglePureIntegration_HP" should be sent back into "thetaX_Integration_HP_deg"


%% Init. cond.
tau_s_lp = .00001; % This isn't really doing anything with this low of a time constant. But keep for now to low pass the accelerations.

% Filtering ref w/ bode plot for discrete time:
% https://stackoverflow.com/questions/11812490/time-discrete-implementation-of-1st-order-rc-filter
% Ex.)
% fs = 96000.0;                         % Sample rate.
% delta_t = 1.0 / fs;                   % Sample period.
% fc = 5000.0;                          % Filter cut off freq., low pass
% tau = 1 / ( 2 * pi * fc );            % Time constant of filter.
% alpha = delta_t / ( tau + delta_t );  % Smoothing factor per Wikipedia page.
% freqz( b, a, 1024, fs );              % 1024 point FFT used.
% b = [ alpha ];                        % 'b' coefficients
% a = [ 1.0, ( 1 - alpha ) ];           % 'a' coefficents
% a = a ./ a(1)
% y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
%                  - a(2)*y(n-1) - ... - a(na+1)*y(n-na)

%Complementary should be on the order of tau_s =~ 1000s;
alpha_comp = (dt) / (dt+tau_s);
%Gyro high pass - Gyro high pass should be on the order of tau_s_hp =~ 30s;
alpha_hp = (dt) / (dt+tau_s_hp);
%Accel low pass
alpha_lp_accel = dt / (dt + tau_s_lp);

i = 2; %For time discrete

gyro_LP_dps(i) = (rate_dps * alpha_hp) + (1-alpha_hp) * gyro_LP_dps(i-1); %Low pass the gyro data

gyro_HP_dps = (rate_dps - gyro_LP_dps(i)) ; %High pass the gyro data from the low pass

thetaX_Accel_null_deg = -(unwrap(atan2(Ay_g, Az_g) * 180/pi)); % I think this is swapped - DJAN (Putting negative here will make it align with ref. angle direction)

%Takes out conditions where the acceleration signal is missing,
%replaces with zero. Sometimes happens with poor data collection/conversion.
if isnan(thetaX_Accel_null_deg)
    thetaX_Accel_deg = 0;
else
    thetaX_Accel_deg = thetaX_Accel_null_deg;
end

thetaX_LP_Accel_deg(i) = ( thetaX_Accel_deg * alpha_lp_accel) + (1-alpha_lp_accel) * thetaX_LP_Accel_deg(i-1); %Low pass the accelerations angle

thetaX_GyroIntegration_deg = (thetaX_Complementary_deg(i-1) + gyro_HP_dps*dt); %Pure integration. thetaX_deg_comp(i-1) was the error from before (used to be thetaX_deg_fromIntegration(i))

thetaX_Integration_HP_deg(i) = (thetaX_Integration_HP_deg(i-1) + gyro_HP_dps*dt); %Pure integration for tesing purposes.

thetaX_Complementary_deg(i) = ( alpha_comp * thetaX_LP_Accel_deg(i) ) + ( (1-alpha_comp) * thetaX_GyroIntegration_deg ); %Apply acceleration complementary filter

angleAccel_LP = thetaX_LP_Accel_deg(i);
angleComp = thetaX_Complementary_deg(i);
anglePureIntegration_HP = thetaX_Integration_HP_deg(i);
gyro_LP = gyro_LP_dps(i);

end