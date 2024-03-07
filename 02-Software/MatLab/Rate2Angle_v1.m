function [angle] = Rate2Angle_v1(time_s, rate_dps, Ay_g, Az_g)

% Rate2Angle_v1.m
% 1/22/24
% S. Krug
% Notes:
% 1/22/24 - 
dt = mean(gradient(time_s));

thetaX_deg_loop = 0; %1.5095
% static_offset_deg = 3.25;
static_offset_deg = 0;
thetaX_deg_loop2 = 0; %static angle offset at t= 0? only if zero wasn't calibrated in the SBG software 1.5095
thetaX_deg_C_LP(1) = 0;


for i = 2:length(rate_dps)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel_test = -(unwrap(atan2(Ay_g(i), Az_g(i) + pi) * 180/pi) - static_offset_deg);

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;
    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_loop2 = (thetaX_deg_loop2 + Wx_dps(i)*dt); %Pure integration
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

    thetaX_deg_C_LP(i) = (thetaX_deg_loop2 * alpha_hp) + (1-alpha_hp) * thetaX_deg_C_LP(i-1); %Low pass the gyro data

    thetaX_deg_loop = (1-alpha) * (thetaX_deg_fromIntegration(i)) + (alpha) * thetaX_deg_fromAccel(i); %Apply acceleration complementary filter
    thetaX_deg_complementary_HP(i) = thetaX_deg_loop - thetaX_deg_C_LP(i); %High pass the gyro data from the low pass


    % thetaX_deg_C_HP(i) = thetaX_deg_complementary(i) - (thetaX_deg_complementary(i) * (1-alpha_hp));




end


angle = rate;