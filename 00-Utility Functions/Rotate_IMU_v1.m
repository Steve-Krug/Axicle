function [d2xdt2, d2ydt2, d2zdt2, d2roll, d2pitch, d2yaw] = Rotate_IMU_v1(roll, pitch, yaw, d2xdt20, d2ydt20, d2zdt20, d2roll, d2pitch, d2yaw)
%%  Rotate_IMU_v1.m
%   S. Krug
%   ~8/23/18
%   Notes:
%

%% Static angles of misalignment for IMU
psi=roll; %static roll offset angle, rad
theta=pitch; %static pitch offset angle, rad
phi=yaw; %static yaw offset angle, rad
% Translational accelerations in m/s^2
% Rotational accelerations in rad/s^2

%% Calculations
% http://mathworld.wolfram.com/EulerAngles.html
R(1,1)=cos(theta)*cos(phi);
R(1,2)=cos(theta)*sin(phi);
R(1,3)=-sin(theta);
R(2,1)=sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi);
R(2,2)=sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi);
R(2,3)=cos(theta)*sin(psi);
R(3,1)=cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi);
R(3,2)=cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi);
R(3,3)=cos(theta)*cos(psi);

a_imu = [d2xdt20; d2ydt20; d2zdt20;];
alpha_imu = [d2roll; d2pitch; d2yaw;];

a_imu_rotated = (R*a_imu);
alpha_imu_rotated = (R*alpha_imu);

d2xdt2 = a_imu_rotated(1,1); %m/s^2
d2ydt2 = a_imu_rotated(2,1); %m/s^2
d2zdt2 = a_imu_rotated(3,1); %m/s^2

d2roll = alpha_imu_rotated(1,1); %rad/s^2
d2pitch = alpha_imu_rotated(2,1); %rad/s^2
d2yaw = alpha_imu_rotated(3,1); %rad/s^2


end