clear
clc
close all


load('240227_mpuHindry_v1.mat'); %Must first open .txt data in excel, then paste 7 columns into matlab. save varaible as "mpuData".


sbgData = readtable('240227_sbgCenterExport_hindryJturn.txt');

% asmData = load('240212_AxicleExport_151pm.mat'); %Asm data time histories don't line up. time array might not be calc'ing properly.
% time, rpy rate, ax,ay,az, comp angle, accel angle
startOffset_sbg = 4.541; %sec

dt_mpu = 1/66.6667;

time_sbg_s = sbgData.TimeStamp - (sbgData.TimeStamp(1)) - startOffset_sbg;
time_mpu_s = mpuData(:,1)/GNCConstants.SecToMillisecond;


Wx_mpu_dps = -mpuData(:,2);
Wy_mpu_dps = mpuData(:,3);
Wz_mpu_dps = -mpuData(:,4);

Ay_mpu_g = mpuData(:,6);
Ay_sbg_g = sbgData.AccelerometerY;

Tx_mpu_deg = -mpuData(:,8) - (mpuData(1,8));
% Ty_mpu_deg = mpuData(:,3) - (mpuData(1,3));
% Tz_mpu_deg = mpuData(:,2)- (mpuData(1,2));

Wx_sbg_dps = sbgData.GyroscopeX; 
Wy_sbg_dps = sbgData.GyroscopeY;
Wz_sbg_dps = sbgData.GyroscopeZ;

Tx_sbg_deg = sbgData.Roll - sbgData.Roll(1);
Ty_sbg_deg = sbgData.Pitch - sbgData.Pitch(1);
Tz_sbg_deg = sbgData.Yaw - sbgData.Yaw(1);




figure(1)
subplot(3,1,1)

plot(time_mpu_s, Wx_mpu_dps, time_sbg_s, Wx_sbg_dps);
title('MPU vs. SBG, Corolla JTurn with Rolling IMU Assy.')
grid on
ylabel('Roll [deg/s]')
legend('MPU', 'SBG')


subplot(3,1,2)
plot(time_mpu_s, Wy_mpu_dps, time_sbg_s, Wy_sbg_dps);
ylabel('Pitch [deg/s]')
grid on
legend('MPU', 'SBG')

subplot(3,1,3)
plot(time_mpu_s, Wz_mpu_dps, time_sbg_s, Wz_sbg_dps);
grid on
legend('MPU', 'SBG')
xlabel('Time [s]')
ylabel('Yaw [deg/s]')




figure(2)
subplot(2,1,1)
plot(time_mpu_s, Tx_mpu_deg, time_sbg_s, Tx_sbg_deg);
grid on
title('MPU vs. SBG, Corolla JTurn with Rolling IMU Assy.')
legend('MPU', 'SBG')
ylabel('Roll Angle [deg]')
xlim([0 50])
subplot(2,1,2)
plot(time_mpu_s, Ay_mpu_g - Ay_mpu_g(1), time_sbg_s, (Ay_sbg_g - Ay_sbg_g(1))/10);
grid on
legend('MPU', 'SBG')
ylabel('Accel [g]')
xlim([0 50])

% subplot(3,1,2)
% plot(time_mpu_s, Ty_mpu_deg, time_sbg_s, Ty_sbg_deg);
% legend('MPU', 'SBG')
% ylabel('Pitch Angle [deg]')
% 
% subplot(3,1,3)
% plot(time_mpu_s, Tz_mpu_deg, time_sbg_s, Tz_sbg_deg);
% legend('MPU', 'SBG')
% ylabel('Yaw Angle [deg]')





