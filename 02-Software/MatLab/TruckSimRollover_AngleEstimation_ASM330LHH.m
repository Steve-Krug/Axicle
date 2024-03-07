%%TruckSimRollover_AngleEstimation_ASM330LHH.m
% 12/2/23
% S. Krug


clc
clear
close all

load('C:\Users\slkru\OneDrive - Axicle\Public\9. Data\TruckSim Results\SandBox Data\230909_SWD_n1000_50_100_185_225_5k_25k_v1.mat');

% Columns - Variable Name
% 1 - Time
% 2 - Vx
% 3 - Vy
% 4 - Vz
% 5 - AVx
% 6 - AVy
% 7 - AVz
% 8 - Pitch
% 9 - Roll
% 10 - Yaw
% 11 - Ax
% 12 - Ay
% 13 - Az
% 14 - Ax_S1
% 15 - Ay_S1
% 16 - Az_S1
% 17 - Steer_SW

row = 1; %always same
col = 820;

Time_s = data{row,col}.Time;
Vx_kph = data{row,col}.Vx;
Vy_kph = data{row,col}.Vy;
Vz_kph =  data{row,col}.Vz;
AVx_dps =  data{row,col}.AVx;
AVy_dps =  data{row,col}.AVy;
AVz_dps =  data{row,col}.AVz;
Pitch_deg = data{row,col}.Pitch;
Roll_deg = data{row,col}.Roll;
Yaw_deg = data{row,col}.Yaw;
Ax_g = data{row,col}.Ax;
Ay_g = data{row,col}.Ay;
Az_g = data{row,col}.Az;
Ax_S1_g = data{row,col}.Ax_S1;
Ay_S1_g = data{row,col}.Ay_S1;
Az_S1_g = data{row,col}.Az_S1;
Steer_SW_deg = data{row,col}.Steer_SW;

dt = mean(gradient(Time_s)); %s
freq = 1/dt; %hz

figure(1)

hold on
subplot(2,1,1)
plot(Time_s, Roll_deg)
xlabel('Time [s]')
ylabel('Tractor Roll Angle [deg]')
Plotter(1)
hold on

subplot(2,1,2)
plot(Time_s, AVx_dps)
xlabel('Time [s]')
ylabel('Tractor Roll Rate [deg/s]')
hold on
Plotter(1)

acc_mps2 = [Ax_S1_g Ay_S1_g Az_S1_g]*9.81; 
angVel_rps = [AVx_dps AVy_dps AVz_dps]/57.29; 

%% IMU Parameters

IMU = imuSensor;
IMU.SampleRate = freq;

ASM330_Accel = accelparams( ...
    'MeasurementRange',16*9.81, ... %mps2
    'Resolution',0.0000488*9.81, ... %mps2/LSB ...(0.488 milliG/LSB)
    'ConstantBias',0, ... %mps2
    'AxesMisalignment',0, ... %
    'NoiseDensity', 0.000400*9.81, ... %mps2/sqrt(Hz) 200 MicroG/sqrt(Hz)
    'BiasInstability',0, ... %mps2
    'TemperatureBias', [0 0 0], ... % mps2/degC
    'TemperatureScaleFactor', 0); % %/degC

IMU.Accelerometer = ASM330_Accel;


ASM330_Gyro =  gyroparams( ...
    'MeasurementRange',4000/57.29, ... % rad/s
    'Resolution',0.0140/57.29, ... % (rad/s) / LSB ...(140.0 mdps/LSB)
    'AxesMisalignment',0, ... % %
    'NoiseDensity',0.012/57.29, ... % (rad/s) / sqrt(Hz) (12.0 mdps/sqrt(Hz)
    'BiasInstability', .01,...  % rad/s   (3 deg/h) <--wtf?
    'RandomWalk', 0.005/57.29,... % rad/s * sqrt(hz) *  (0.21 deg/sqrt(h)) <--wtf? "Rate Noise Spectral Density".005 deg/s *Sqrt(Hz)  for MPU6050
    'TemperatureBias',0, ... % (rad/s) / degC
    'TemperatureScaleFactor',0, ... % %
    'AccelerationBias',0.00017809, ...  % (rad/s) / (mps2)
    'ConstantBias',[0,0,0]); % rad/s

IMU.Gyroscope = ASM330_Gyro;


[accData, gyroData] = IMU(acc_mps2, angVel_rps);


figure(2)
subplot(2,1,1)
plot(Time_s, angVel_rps(:,1), '--', Time_s, gyroData(:,1))
xlabel('Time (s)')
ylabel('Angular Velocity (rad/s)')
title('TruckSim Rollover SWD Run 820')
legend('x, Roll (truth)', 'x, Roll (Simulated ASM330LH)')
hold on
Plotter(1);

subplot(2,1,2)
plot(Time_s, acc_mps2(:,2), '--', Time_s, -accData(:,2))
xlabel('Time (s)')
ylabel('Lateral Acceleration (mps2)')
legend('y, (truth)', 'y, (Simulated ASM330LH)')
Plotter(1);
hold on

%% IMU Sensor Fusion

% FUSE = imufilter('SampleRate',Freq,'ReferenceFrame','ENU');
% 
% quaternions = FUSE(accelReadings*9.81, gyroReadings/57.296);
% 
% eulerAnglesDegrees = eulerd(quaternions,'ZYX','frame');