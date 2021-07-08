%%%% Stage Separation Analysis %%%%

clear all
close all
clc
load('C:\Users\Krugs\Documents\VirginOrbitGit\Dynamics Modeling\01-Data Processing\Assorted_Data\IMU_DataFile_Date_8_2_2018_Time_2_49_47 PM.mat')

IMU = ReformatImuData(IMU);

% DataValid = Imu.DataValid;
% DataValidDT = zeros(length(DataValid)*2,1);
% DataValidDT(1:2:end-1) = DataValid;
% DataValidDT(2:2:end) = DataValid;
% DeltaTheta_rad = Imu.DeltaTheta_rad(logical(DataValidDT),:);
% DeltaV_fps = Imu.DeltaVel_fps(logical(DataValid),:);
% DeltaThetaFilt_rad = Imu.DeltaThetaFilt_rad;
% DeltaVFilt_fps = Imu.DeltaVelFilt_fps;
% MeanDeltaVFilt_fps = mean(DeltaVFilt_fps,1);

DeltaThetaRate_hz = 600;
DeltaVelRate_hz = 300;

DeltaTheta_dph = IMU.DeltaTheta_rad * DeltaThetaRate_hz * GNCConstants.RadianToDegree * GNCConstants.HourToSecond;
DeltaThetaFilt_dph = IMU.DeltaThetaFilt_rad * DeltaThetaRate_hz * GNCConstants.RadianToDegree * GNCConstants.HourToSecond;
DeltaTheta_dps = IMU.DeltaTheta_rad * DeltaThetaRate_hz * GNCConstants.RadianToDegree;
DeltaThetaFilt_dps = IMU.DeltaThetaFilt_rad * DeltaThetaRate_hz * GNCConstants.RadianToDegree;
DeltaV_g = IMU.DeltaVel_fps * DeltaVelRate_hz / GNCConstants.Gravity_fpsps;
DeltaVFilt_g = IMU.DeltaVelFilt_fps * DeltaVelRate_hz / GNCConstants.Gravity_fpsps;

idxDeltaTheta = 1:length(DeltaTheta_dph);
idxDeltaVel = 1:length(DeltaV_g);

TimeDTheta_sec = (1:length(DeltaTheta_dph))/DeltaThetaRate_hz;
TimeDVel_sec = (1:length(DeltaV_g))/DeltaVelRate_hz;

TimeDTFilt_sec = TimeDTheta_sec(IMU.DataValidDT==1);
TimeDVFilt_sec = TimeDVel_sec(IMU.DataValid==1);

%%

TimeStart_sec = 1740;
TimeStop_sec = 1770;
AccelYlims = [5;1;5];
GyroYlims = [25;25;25];
initialize_fig('Delta Vels',1);
AxisLabel = {'X';'Y';'Z'};
for idx = 1:3
  
s(idx) = subplot(3,1,idx);
hold on;
plot(TimeDVel_sec,DeltaV_g(:,idx),'r');
plot(TimeDVFilt_sec,DeltaVFilt_g(:,idx),'b');
ylabel([AxisLabel{idx} ' Axis [G]']);
ylim([-AccelYlims(idx) AccelYlims(idx)]);
if idx == 1
  legend('Raw','Filtered');
  title('Delta Vels');
end
end
linkaxes(s,'x');
xlim([TimeStart_sec TimeStop_sec]);
xlabel('Time Since Recording Start [sec]');
clear s

initialize_fig('Delta Thetas',1);
AxisLabel = {'X';'Y';'Z'};
for idx = 1:3
  
s(idx) = subplot(3,1,idx);
hold on;
plot(TimeDTheta_sec,DeltaTheta_dps(:,idx),'r');
plot(TimeDTFilt_sec,DeltaThetaFilt_dps(:,idx),'b');
ylabel([AxisLabel{idx} ' Axis [deg/sec]']);
ylim([-GyroYlims(idx) GyroYlims(idx)]);
if idx == 1
  legend('Raw','Filtered');
  title('Delta Thetas');
end
end
linkaxes(s,'x');
xlabel('Time Since Recording Start [sec]');
xlim([TimeStart_sec TimeStop_sec]);
clear s


%%
initialize_fig('Data Valid',1);
plot(TimeDVel_sec,IMU.DataValid,'b');
title('Data Valid');
ylabel('Data Valid []');
xlabel('Time Since Recording Start [sec]');
xlim([TimeStart_sec TimeStop_sec]);
