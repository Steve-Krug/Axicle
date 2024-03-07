clear
clc
close all


load('mpuData_v2.mat');

sbgData = readtable('sbgCenterExport_MPU6050Comparison_v2.txt');

startOffset = .79-2; %sec

time_sbg_s = sbgData.TimeStamp - (sbgData.TimeStamp(1)) - startOffset;
time_mpu_s = mpuData(:,1)/GNCConstants.SecToMillisecond;

Wx_mpu_dps = -mpuData(:,5);
Wy_mpu_dps = mpuData(:,6);
Wz_mpu_dps = -mpuData(:,7);

Tx_mpu_deg = -mpuData(:,4);
Ty_mpu_deg = -mpuData(:,3);
Tz_mpu_deg = mpuData(:,2);

Wx_sbg_dps = sbgData.GyroscopeX; 
Wy_sbg_dps = sbgData.GyroscopeY;
Wz_sbg_dps = sbgData.GyroscopeZ;

Tx_sbg_deg = sbgData.Roll;
Ty_sbg_deg = sbgData.Pitch;
Tz_sbg_deg = sbgData.Yaw -sbgData.Yaw(1);



figure(1)
subplot(3,1,1)
plot(time_mpu_s, Wx_mpu_dps, time_sbg_s, Wx_sbg_dps);
ylabel('Roll [deg/s]')
legend('MPU', 'SBG')

subplot(3,1,2)
plot(time_mpu_s, Wy_mpu_dps, time_sbg_s, Wy_sbg_dps);
ylabel('Pitch [deg/s]')
legend('MPU', 'SBG')

subplot(3,1,3)
plot(time_mpu_s, Wz_mpu_dps, time_sbg_s, Wz_sbg_dps);
legend('MPU', 'SBG')
xlabel('Time [s]')
ylabel('Yaw [deg/s]')




figure(2)
subplot(3,1,1)
plot(time_mpu_s, Tx_mpu_deg, time_sbg_s, Tx_sbg_deg);
legend('MPU', 'SBG')
ylabel('Roll Angle [deg]')

subplot(3,1,2)
plot(time_mpu_s, Ty_mpu_deg, time_sbg_s, Ty_sbg_deg);
legend('MPU', 'SBG')
ylabel('Pitch Angle [deg]')

subplot(3,1,3)
plot(time_mpu_s, Tz_mpu_deg, time_sbg_s, Tz_sbg_deg);
legend('MPU', 'SBG')
ylabel('Yaw Angle [deg]')





