%% ComplementaryFilter_v1
% 8/14/23
% S. Krug
% Notes:
%
% 8/14/23 - Initial start

% // a=tau / (tau + loop time)
% // newAngle = angle measured with atan2 using the accelerometer
% // newRate = angle measured using the gyro
% // looptime = loop time in millis()
% 
% float tau=0.075;
% float a=0.0;
% 
% float Complementary(float newAngle, float newRate,int looptime) {
% float dtC = float(looptime)/1000.0;
% a=tau/(tau+dtC);
% x_angleC= a* (x_angleC + newRate * dtC) + (1-a) * (newAngle);
% return x_angleC;
% }

alpha = 0.98; %complementary filter constant 1

omega_x_rad = c_alpha_1 * (theta_x + omega_x * dt) + (1-alpha) * (Az_mps2);


