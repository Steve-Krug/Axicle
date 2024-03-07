clear
clc
close all


load('240212_mpu_151pm.mat'); %Must first open .txt data in excel, then paste 7 columns into matlab. save varaible as "mpuData".

sbgData = readtable('240212_sbgCenter_151pm.txt');

asmData = load('240212_AxicleExport_151pm.mat'); %Asm data time histories don't line up. time array might not be calc'ing properly.

startOffset_sbg = 14.8470; %sec
startOffset_asm =  5.3438 - 1.4;

time_sbg_s = sbgData.TimeStamp - (sbgData.TimeStamp(1)) - startOffset_sbg;
time_mpu_s = mpuData(:,1)/GNCConstants.SecToMillisecond;
time_asm_s = asmData.time - startOffset_asm;

Wx_mpu_dps = mpuData(:,5);
Wy_mpu_dps = -mpuData(:,6);
Wz_mpu_dps = -mpuData(:,7);

Tx_mpu_deg = mpuData(:,4) - (mpuData(1,4));
Ty_mpu_deg = mpuData(:,3) - (mpuData(1,3));
Tz_mpu_deg = mpuData(:,2)- (mpuData(1,2));

Wx_sbg_dps = sbgData.GyroscopeX; 
Wy_sbg_dps = sbgData.GyroscopeY;
Wz_sbg_dps = sbgData.GyroscopeZ;

Tx_sbg_deg = sbgData.Roll - sbgData.Roll(1);
Ty_sbg_deg = sbgData.Pitch - sbgData.Pitch(1);
Tz_sbg_deg = sbgData.Yaw -sbgData.Yaw(1);

Wx_asm_dps = asmData.gyrosX;




figure(1)
subplot(3,1,1)
plot(time_mpu_s, Wx_mpu_dps, time_sbg_s, Wx_sbg_dps);
ylabel('Roll [deg/s]')
legend('MPU', 'SBG', 'ASM')

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





