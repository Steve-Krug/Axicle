function [angleAccel, angleComp, angleLP, angleHP] = Rate2Angle_Complementary_HP_v4(time_s, rate_dps, Ay_g, Az_g, tau_s, tau_s_hp)
% Rate2Angle_v2.m
% 1/24/24
% S. Krug
% Notes:
% time_s - time array
% rate_dps - rate array
% Ay_g - lateral acceleration array
% Az_g - vertical acceleration array
% tau_s - time constant for accelerometer angle estimate
% freq_hz - high pass filter frequency
% 1/22/24 -

initialization_period = 100;
dt = mean(gradient(time_s));
%Complementary filter tau in seconds
% alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter
% alpha = (tau_s) / (dt+tau_s);
% %High Pass Alpha
% % tau_s_hp = .000005;
% alpha_hp = (tau_s_hp) / (dt+tau_s_hp);

% tau_s_hp = 1/freq_hz; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
% alpha_hp = 1 - exp(-dt/tau_s_hp); % Alpha for 1st order filter

thetaX_deg_loop = 0; %1.5095
% static_offset_deg = 3.25;
thetaX_deg_LP(1) = 0;
static_offset_deg = 0;
thetaX_deg_loop2 = 0; %static angle offset at t= 0? only if zero wasn't calibrated in the SBG software 1.5095
rate_dps(1) = 0;
thetaX_deg_LP_xl(1) = 0;
tau_s_lp = .00001;

for i = 2:length(rate_dps)

    alpha = (tau_s) / (dt+tau_s);
    %High Pass Alpha
    alpha_hp = (tau_s_hp) / (dt+tau_s_hp);

    alpha_lp_xl = tau_s_lp / (dt + tau_s_lp);
    thetaX_deg_fromAccel_test = -(unwrap(atan2(Ay_g(i), Az_g(i)) * 180/pi) - static_offset_deg);

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;
    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_LP_xl(i) = ( thetaX_deg_fromAccel(i) * alpha_lp_xl) + (1-alpha_lp_xl) * thetaX_deg_LP_xl(i-1); %Low pass the accelerations angle

    thetaX_deg_loop2 = (thetaX_deg_loop2 + rate_dps(i)*dt); %Pure integration
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

    thetaX_deg_comp(i) = ( alpha * thetaX_deg_fromIntegration(i) ) + ( (1-alpha) * thetaX_deg_LP_xl(i) ); %Apply acceleration complementary filter

    thetaX_deg_LP(i) = ( thetaX_deg_comp(i) * alpha_hp) + (1-alpha_hp) * thetaX_deg_LP(i-1); %Low pass the gyro data

    % thetaX_deg_HP(i) = (thetaX_deg_comp(i) - thetaX_deg_LP(i)); %High pass the gyro data from the low pass
    thetaX_deg_HP(i) = (thetaX_deg_comp(i) - thetaX_deg_LP(i)) ; %High pass the gyro data from the low pass

    % if moving average of rate is low
if i > initialization_period
    if abs(thetaX_deg_LP_xl(i)) > 1 && ~all(abs(rate_dps(i-75:i))) < 0.2

        tau_s = 0.0015; %sec
        thetaX_deg_HP(i) = (thetaX_deg_comp(i)); %don't high pass the data if there's a bank with little rate change

    else 

        tau_s = 0.5;
        thetaX_deg_HP(i) = (thetaX_deg_comp(i) - thetaX_deg_LP(i)) ; %High pass the gyro data from the low pass
    end
end


end

angleAccel = thetaX_deg_LP_xl;
angleComp = thetaX_deg_comp;
angleLP = thetaX_deg_LP;
angleHP = thetaX_deg_HP;


