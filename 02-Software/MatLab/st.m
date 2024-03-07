function [angleAccel_LP, angleComp, angleAccelRaw, anglePureIntegration_HP, gyro_LP_dps, gyro_HP_dps] = Axicle_Rate2Angle_Comp_v1(time_s, rate_dps, Ay_g, Az_g, tau_s, tau_s_hp)
%% Axicle, Inc. Not for redistribution without consent.
% Axicle_Rate2Angle_Comp_v1.m
% Last update: 1/29/24

%% Variable Key:
% time_s - time array
% rate_dps - rate array from "ASM330LHHx"
% sbg_rate_dps - for comparing against commercial IMU. Add variable to 3rd
% position
% Ay_g - lateral acceleration array
% Az_g - vertical acceleration array
% tau_s - time constant for accelerometer angle estimate
% freq_hz - high pass filter frequency
%%

dt = mean(gradient(time_s)); %Mean timestep to interpolate between discontinous timesteps
%Initialize arrays for speed
gyro_LP_dps = zeros(length(rate_dps), 1);
gyro_HP_dps = zeros(length(rate_dps), 1);
thetaX_Accel_deg = zeros(length(rate_dps), 1);
thetaX_LP_Accel_deg = zeros(length(rate_dps), 1);
thetaX_GyroIntegration_deg = zeros(length(rate_dps), 1);
thetaX_Integration_HP_deg = zeros(length(rate_dps), 1);
thetaX_deg_Complementary_deg = zeros(length(rate_dps), 1);

%Init. cond.
rate_dps(1) = 0;
thetaX_LP_Accel_deg(1) = 0;
tau_s_lp = .00001; % This isn't really doing anything with this low of a time constant
thetaX_GyroIntegration_deg(1) = 0;
thetaX_Integration_HP_deg(1) = 0;
thetaX_deg_Complementary_deg(1) = 0;
gyro_LP_dps(1) = rate_dps(1);
gyro_HP_dps(1) = 0;

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

%  Complementary should be on the order of tau_s =~ 1000s;
%  Gyro high pass should be on the order of tau_s_hp =~ 30s;

alpha_comp = (dt) / (dt+tau_s);
%Gyro high pass
alpha_hp = (dt) / (dt+tau_s_hp);
% %Gyro low pass
% alpha_lp_gyro = (dt) / (dt+tau_s_lp_gyro); 
%Accel low pass
alpha_lp_accel = dt / (dt + tau_s_lp);



%gyro_LP_dps(i) = ( rate_dps(i) * alpha_hp) + (1-alpha_hp) * gyro_LP_dps(i-1); %Low pass the gyro data
gyro_LP_dps(2:end) = rate_dps .* alpha_hp + (1-alpha_hp) .* gyro_LP_dps(1:end-1);

%gyro_HP_dps(i) = (rate_dps(i) - gyro_LP_dps(i)) ; %High pass the gyro data from the low pass
gyro_HP_dps = rate_dps - gyro_LP_dps;

%thetaX_Accel_null_deg = -(unwrap(atan2(Ay_g(i), Az_g(i)) * 180/pi)); % I think this is swapped - DJAN (Putting negative here will make it align with ref. angle direction)
thetaX_Accel_deg = atand(Ay_g ./ Az_g);
thetaX_Accel_deg(isnan(thetaX_Accel_deg)) = 0; % make all NANs zero

%thetaX_LP_Accel_deg(i) = ( thetaX_Accel_deg(i) * alpha_lp_accel) + (1-alpha_lp_accel) * thetaX_LP_Accel_deg(i-1); %Low pass the accelerations angle
thetaX_Accel_deg(2:end) = thetaX_Accel_deg(1:end-1) * alpha_lp_accel + (1-alpha_lp_accel) * thetaX_LP_Accel_deg(1:end-1);

%thetaX_GyroIntegration_deg(i) = (thetaX_deg_Complementary_deg(i-1) + gyro_HP_dps(i)*dt); %Pure integration. thetaX_deg_comp(i-1) was the error from before (used to be thetaX_deg_fromIntegration(i))
thetaX_GyroIntegration_deg(2:end) = thetaX_deg_Complementary_deg(1:end-1) + gyro_HP_dps(2:end)*dt;

thetaX_Integration_HP_deg(i) = (thetaX_Integration_HP_deg(i-1) + gyro_HP_dps(i)*dt); %Pure integration. thetaX_deg_comp(i-1) was the error from before (used to be thetaX_deg_fromIntegration(i))

thetaX_deg_Complementary_deg(i) = ( alpha_comp * thetaX_LP_Accel_deg(i) ) + ( (1-alpha_comp) * thetaX_GyroIntegration_deg(i) ); %Apply acceleration complementary filter



angleAccel_LP = thetaX_LP_Accel_deg;
angleComp = thetaX_deg_Complementary_deg;
angleAccelRaw = thetaX_Accel_deg;
anglePureIntegration_HP = thetaX_Integration_HP_deg;

%keyboard

