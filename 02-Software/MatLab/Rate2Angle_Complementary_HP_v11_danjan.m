function [angleAccel, angleComp, angleLP, angleHP, angleAccelRaw, anglePureIntegration, gyro_LP, gyro_HP] = Rate2Angle_Complementary_HP_v11_danjan(time_s, rate_dps, rate_dps2, Ay_g, Az_g, tau_s, tau_s_hp)
% Rate2Angle_v6.m
% 1/26/24
% S. Krug
% Notes: 


% time_s - time array
% rate_dps - rate array
% Ay_g - lateral acceleration array
% Az_g - vertical acceleration array
% tau_s - time constant for accelerometer angle estimate
% freq_hz - high pass filter frequency


initialization_period = 100;
dt = mean(gradient(time_s));
thetaX_deg_LP(1) = 0;
rate_dps(1) = 0;
thetaX_deg_LP_xl(1) = 0;
tau_s_lp = .00001; % This isn't really doing anything with this low of a time constant
thetaX_deg_fromIntegration(1) = 0;
thetaX_deg_fromPureIntegration(1) = 0;
thetaX_deg_comp(1) = 0;
gyro_LP(1) = rate_dps(1);
gyro_HP(1) = 0;


% filtering: https://stackoverflow.com/questions/11812490/time-discrete-implementation-of-1st-order-rc-filter
%alpha = (tau_s) / (dt+tau_s);
alpha = (dt) / (dt+tau_s);
%High Pass Alpha
%alpha_hp = (tau_s_hp) / (dt+tau_s_hp);
alpha_hp = (dt) / (dt+tau_s_hp);

%alpha_lp_xl = tau_s_lp / (dt + tau_s_lp);
alpha_lp_xl = dt / (dt + tau_s_lp);



for i = 2:length(rate_dps)
    %rate_dps(i) = rate_dps2(i); % Uncomment to use sbg
    gyro_LP(i) = ( rate_dps(i) * alpha_hp) + (1-alpha_hp) * gyro_LP(i-1); %Low pass the gyro data

    gyro_HP(i) = (rate_dps(i) - gyro_LP(i)) ; %High pass the gyro data from the low pass

    thetaX_deg_fromAccel_test = (unwrap(atan2(Ay_g(i), Az_g(i)) * 180/pi)); % I think this is swapped

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;
    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_LP_xl(i) = ( thetaX_deg_fromAccel(i) * alpha_lp_xl) + (1-alpha_lp_xl) * thetaX_deg_LP_xl(i-1); %Low pass the accelerations angle

 %   thetaX_deg_fromIntegration(i) = (thetaX_deg_comp(i-1) + rate_dps(i)*dt); %Pure integration. thetaX_deg_comp(i-1) was the error from before (used to be thetaX_deg_fromIntegration(i))
    thetaX_deg_fromIntegration(i) = (thetaX_deg_comp(i-1) + gyro_HP(i)*dt); %Pure integration. thetaX_deg_comp(i-1) was the error from before (used to be thetaX_deg_fromIntegration(i))

    thetaX_deg_fromPureIntegration(i) = (thetaX_deg_fromPureIntegration(i-1) + gyro_HP(i)*dt); %Pure integration. thetaX_deg_comp(i-1) was the error from before (used to be thetaX_deg_fromIntegration(i))

    %thetaX_deg_comp(i) = ( alpha * thetaX_deg_fromIntegration(i) ) + ( (1-alpha) * thetaX_deg_LP_xl(i) ); %Apply acceleration complementary filter
    thetaX_deg_comp(i) = ( alpha * thetaX_deg_LP_xl(i) ) + ( (1-alpha) * thetaX_deg_fromIntegration(i) ); %Apply acceleration complementary filter

    thetaX_deg_LP(i) = ( thetaX_deg_comp(i) * alpha_hp) + (1-alpha_hp) * thetaX_deg_LP(i-1); %Low pass the gyro data

    thetaX_deg_HP(i) = (thetaX_deg_comp(i) - thetaX_deg_LP(i)) ; %High pass the gyro data from the low pass


end

angleAccel = thetaX_deg_LP_xl;
angleComp = thetaX_deg_comp;
angleLP = thetaX_deg_LP;
angleHP = thetaX_deg_HP;
angleAccelRaw = thetaX_deg_fromAccel;
anglePureIntegration = thetaX_deg_fromPureIntegration;

%keyboard

