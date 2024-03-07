%% OctoberTestData_Analysis_v1.m
% 11/22/23
% S. Krug
% Notes:
% - includes loop for optimizing time constant coefficients

close all
clear
clc


load('C:\Users\slkru\OneDrive - Axicle\Public\8. Test\231013_SEA_RollTesting\axicleData1_rolloverEvent.mat')
load('C:\Users\slkru\OneDrive - Axicle\Public\8. Test\231013_SEA_RollTesting\seaData1043_OxTSRT3000_Oct23.mat')

% seaData is time, ax,ay,az,wx,wy,wz,roll,pitch,yaw

figure(1)
hold on
plot(axicleData1(:,2), axicleData1(:,7))
plot(axicleData1(:,2), axicleData1(:,8))
plot(axicleData1(:,2), axicleData1(:,9))
% xlim([62620 axicleData1(length(axicleData1),2)])
xlim([62620 62620+100])
legend('x vehicle lateral', 'y vehicle longitudinal', 'z')
xlabel('Time [s]')
ylabel('Accel [G]')
Plotter(1);

figure(2)
hold on
plot(axicleData1(:,2), axicleData1(:,4))
plot(axicleData1(:,2), axicleData1(:,5))
plot(axicleData1(:,2), axicleData1(:,6))
% xlim([62620 axicleData1(length(axicleData1),2)])
xlim([62620 62620+100])
legend('x (pitch rate)', 'y (roll rate)', 'z')
xlabel('Time [s]')
ylabel('Rate [deg/s]')
Plotter(1);
% 

% Time Clipping used for Rates and Accel Data
lowerClip_s = 62620 + 28.61; %s
upperClip_s = 62620 + 100 ; %s


time_s = axicleData1( find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),2);
time_s_zeroed = time_s -time_s(1);
Ax_g = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),8)); %#ok<*FNDSB>
Ay_g = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),7));
Az_g = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),9));
Wx_dps = -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),5));
Wy_dps =  -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),4));
Wz_dps =  -(axicleData1(find(axicleData1(:,2) > lowerClip_s & axicleData1(:,2) < upperClip_s),6));





time_s_sea = seaData(:,1);
time_s_sea_zeroed = time_s_sea - time_s_sea(1);
Ax_g_sea = seaData(:,2)/9.81;
Ay_g_sea = seaData(:,3)/9.81;
Az_g_sea = seaData(:,4)/9.81;
Wx_dps_sea = seaData(:,5);
Wy_dps_sea =  seaData(:,6);
Wz_dps_sea = seaData(:,7);
Tx_deg_sea = seaData(:,8) - seaData(1,8); %roll, plus zero offset
Ty_deg_sea = seaData(:,9); %pitch
Tz_deg_sea = seaData(:,10); %yaw



dt = mean(gradient(time_s_sea_zeroed));
%% Filters
newFreq = 1/dt; %After decimating
% Filters for profile roughness rebuilding, zero mean.
% (cutoff freq/(sample freq/2))
filt_freq = [0.05/(newFreq/2);...   %Accelerations high pass frequency
    0.05/(newFreq/2);...            %Velocity high pass frequency
    0.4/(newFreq/2);...             %Displacement high pass frequency
    10/(newFreq/2);...             %general low pass settings
    10/(newFreq/2);...             %Isolate MT filter, Acc
    0.175/(newFreq/2);...             %Isolate MT filter, Vel
    0.01/(newFreq/2)];                 %string pot low pass


[B,A]=butter(1,filt_freq(1),'High'); %Accelerations high pass frequency
[D,C]=butter(1,filt_freq(2),'High'); %Velocity high pass frequency
% [F,E]=butter(3,filt_freq(3),'High'); %Displacements high pass frequency
[H,G]=butter(1,filt_freq(4),'Low'); %general low pass settings
[J,I]=butter(1,filt_freq(5),'Low'); %Isolate MT filter, Using for attitude estimation
% [L,K]=butter(1,filt_freq(6),'Low'); %Isolate MT filter, Vel
% [N,M]=butter(1,filt_freq(7),'Low'); %Isolate MT filter, Displ
% [P,O]=butter(1,filt_freq(8),'Low'); %General Low Pass, camera data
% [R,Q]=butter(1,filt_freq(9),'Low'); %flight accel low pass
% [T,S]=butter(1,filt_freq(10),'Low');%flight rates low pass
% [V,U]=butter(1,filt_freq(11),'Low');%test accel low pass
% [X,W]=butter(1,filt_freq(12),'Low');%test rates low pass
% [Z,Y]=butter(1,filt_freq(13),'Low'); %general low pass string po



Ax_g_filt = filtfilt(H,G, Ax_g);
Ay_g_filt = filtfilt(H,G, Ay_g);
Az_g_filt = filtfilt(H,G, Az_g);

accelReadings(:,1) = Ax_g_filt;
accelReadings(:,2) = Ay_g_filt;
accelReadings(:,3) = Az_g_filt;

Wx_dps_filt = filtfilt(H,G, Wx_dps);
Wy_dps_filt = filtfilt(H,G, Wy_dps);
Wz_dps_filt = filtfilt(H,G, Wz_dps);

gyroReadings(:,1) = Wx_dps_filt;
gyroReadings(:,2) = Wy_dps_filt;
gyroReadings(:,3) = Wz_dps_filt;


Ax_g_sea_filt = filtfilt(H,G, Ax_g_sea);
Ay_g_sea_filt = filtfilt(H,G, Ay_g_sea);
Az_g_sea_filt = filtfilt(H,G, Az_g_sea);

Wx_dps_sea_filt = filtfilt(H,G, Wx_dps_sea);
Wy_dps_sea_filt = filtfilt(H,G, Wy_dps_sea);
Wz_dps_sea_filt = filtfilt(H,G, Wz_dps_sea);

% Ax_g_filt(1) = 0;
% Ay_g_filt(1) = 0;
% Az_g_filt(1) = 0;

Wx_dps_filt(1) = 0;
Wy_dps_filt(1) = 0;
Wz_dps_filt(1) = 0;

% 
figure(3)
hold on
plot(time_s, Wx_dps)
plot(time_s, Wx_dps_filt)

% xlim([62620 axicleData1(length(axicleData1),2)])
% xlim([62620 62620+100])
legend('Raw', 'Filtered')
xlabel('Time [s]')
ylabel('Rate [deg/s]')
Plotter(1);

%% Sensor Fusion Comparison Against Roll Angle Truth

% Time constant filter design, exponential decay function

tau_s = 100; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter

% roll_angle_filt = zeros(size(Roll_deg));
% accel_angle_filt = zeros(size(Accel_Angle_deg));
%
% roll_angle_filt(1) = Roll_deg(1); %Start at same offset
% accel_angle_filt(1) = Accel_Angle_deg(1); %Start at same offset



thetaX_deg_loop = 0;
thetaX_deg_loop2 = 0;

for i = 1:length(Wx_dps_sea_filt)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel_test = -unwrap(atan2(Ay_g_sea_filt(i), Az_g_sea_filt(i) + pi) * 180/pi);

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;

    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_loop = (1-alpha) * (thetaX_deg_loop + Wx_dps_sea_filt(i)*dt) + (alpha) * thetaX_deg_fromAccel(i);
    thetaX_deg_complementary(i) = thetaX_deg_loop;

    thetaX_deg_loop2 = (thetaX_deg_loop2 + Wx_dps_sea_filt(i)*dt);
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

end


figure(9)
hold on
title('OxTS Kalman vs. Pure integration of OxTS Rates')
plot(time_s_sea, thetaX_deg_fromIntegration, time_s_sea, Tx_deg_sea)
xlabel('Time [s]')
ylabel('Roll [deg]')
ylim([-10 10])
% xlim([62620 62620+100])
legend('Pure Integration of OxTS Rates','OxTS RT3000 Extended Kalman estimation')

Plotter(1)
grid on


subplot(2,1,2)
plot(time_s_sea, Ay_g_sea, time_s_sea, Ay_g_sea_filt)
legend('Ay Raw','Ay Filtered')
xlabel('Time [s]')
ylabel('Acceleration [g]')
Plotter(1)
grid on


%% Acceleration Comparison
figure(11)
subplot(3,2,1)
plot(time_s_zeroed, Ax_g, time_s_sea_zeroed, Ax_g_sea)
legend('ASM330LHH raw','OxTS RT3100 raw')
ylabel('Acceleration X [g]')
ylim([-1 1])
subplot(3,2,3)
plot(time_s_zeroed, Ay_g, time_s_sea_zeroed, Ay_g_sea)
ylabel('Acceleration Y [g]')
ylim([-1 1])
subplot(3,2,5)
plot(time_s_zeroed, Az_g, time_s_sea_zeroed, Az_g_sea)
xlabel('Time [s]')
ylabel('Acceleration Z [g]')
ylim([-2 0])

subplot(3,2,2)
plot(time_s_zeroed, Ax_g_filt, time_s_sea_zeroed, Ax_g_sea_filt)
legend('ASM330LHH filtered','OxTS RT3100 filtered')
ylabel('Acceleration X [g]')
ylim([-1 1])
subplot(3,2,4)
plot(time_s_zeroed, Ay_g_filt, time_s_sea_zeroed, Ay_g_sea_filt)
ylabel('Acceleration Y [g]')
ylim([-1 1])
subplot(3,2,6)
plot(time_s_zeroed, Az_g_filt, time_s_sea_zeroed, Az_g_sea_filt)
xlabel('Time [s]')
ylabel('Acceleration Z [g]')
ylim([-2 0])


%% Rate Comparison

figure(12)
subplot(3,2,1)
plot(time_s_zeroed, Wx_dps, time_s_sea_zeroed, Wx_dps_sea)
legend('ASM330LHH raw','OxTS RT3100 raw')
ylabel('Rate X [deg/s]')
ylim([-50 50])
subplot(3,2,3)
plot(time_s_zeroed, Wy_dps, time_s_sea_zeroed, Wy_dps_sea)
ylabel('Rate Y [deg/s]')
ylim([-50 50])
subplot(3,2,5)
plot(time_s_zeroed, Wz_dps, time_s_sea_zeroed, Wz_dps_sea)
xlabel('Time [s]')
ylabel('Rate Z [deg/s]')
ylim([-50 50])

subplot(3,2,2)
plot(time_s_zeroed, Wx_dps_filt, time_s_sea_zeroed, Wx_dps_sea_filt)
legend('ASM330LHH filtered','OxTS RT3100 filtered')
ylabel('Rate X [deg/s]')
ylim([-50 50])
subplot(3,2,4)
plot(time_s_zeroed, Wy_dps_filt, time_s_sea_zeroed, Wy_dps_sea_filt)
ylabel('Rate Y [deg/s]')
ylim([-50 50])
subplot(3,2,6)
plot(time_s_zeroed, Wz_dps_filt, time_s_sea_zeroed, Wz_dps_sea_filt)
xlabel('Time [s]')
ylabel('Rate Z [deg/s]')
ylim([-50 50])


%% Angle Comparison


figure(13)
hold on
title('OxTS Ext. Kalman vs. Axicle Complementary Tau = 100')
plot(time_s_sea_zeroed, Tx_deg_sea, time_s_sea_zeroed, thetaX_deg_complementary)
xlabel('Time [s]')
ylabel('Angle [deg]')
legend('OxTS RT3000 Kalman estimation', 'Axicle complementary')
ylim([-10 10])
Plotter(1)


%% IMU Sensor Fusion
% 
% FUSE = imufilter('SampleRate',newFreq,'ReferenceFrame','ENU');
% 
% quaternions = FUSE(accelReadings*9.81, gyroReadings/57.296);
% 
% eulerAnglesDegrees = eulerd(quaternions,'ZYX','frame');
% 
% %
% figure(14)
% plot(time_s_sea_zeroed, Tx_deg_sea, time_s_zeroed, eulerAnglesDegrees(:,3),time_s_zeroed, thetaX_deg_complementary)
% title('Orientation Estimate')
% legend( 'SEA Roll Angle', 'imufilter FUSE (Toolbox)','Complementary Filter' )
% xlabel('Time (s)')
% ylabel('Rotation (degrees)')
% ylim([-20 10])
% Plotter(1);


%% RMS Error Sweep


% Time constant filter design, exponential decay function

tau_s = linspace(1, 100, 100); % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers

for x = 1:length(tau_s)
    alphaSweep(x) = 1 - exp(-dt/tau_s(x)); % Alpha for 1st order filter
end

thetaX_deg_loop = 0;
thetaX_deg_loop2 = 0;
for z = 1:length(alphaSweep)
    for i = 1:length(Wx_dps_sea_filt)
        % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

        thetaX_deg_fromAccel_test = -unwrap(atan2(Ay_g_sea_filt(i), Az_g_sea_filt(i) + pi) * 180/pi);

        if isnan(thetaX_deg_fromAccel_test)
            thetaX_deg_fromAccel(i) = 0;

        else
            thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
        end

        thetaX_deg_loop = (1-alphaSweep(z)) * (thetaX_deg_loop + Wx_dps_sea_filt(i)*dt) + (alphaSweep(z)) * thetaX_deg_fromAccel(i);
        thetaX_deg_complementary(i) = thetaX_deg_loop;

        thetaX_deg_loop2 = (thetaX_deg_loop2 + Wx_dps_sea_filt(i)*dt);
        thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

    end
    %calculate RMS error

    errorRMS(z) = rmse(thetaX_deg_complementary', Tx_deg_sea); %(predicted, then actual)
    waitbar(z/length(alphaSweep))
end


figure(14)
hold on
title('RMSE for Complementary Tau Values Against OxTS Ext. Kalman ')
plot(tau_s, errorRMS);
xlabel('Tau, Time Constant [s]')
ylabel('RMSE Value')

minVal = min(errorRMS);
minTauIndex = find(errorRMS == minVal);

legend(append('Time Constant (Tau) at Min Error',' = ', num2str(tau_s(minTauIndex))))

Plotter(1);

%% Calculate Signal at min Tau

tau_s_optimized = tau_s(minTauIndex); % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alphaOptimized = 1 - exp(-dt/tau_s_optimized); % Alpha for 1st order filter

thetaX_deg_loop = 0;
thetaX_deg_loop2 = 0;

for i = 1:length(Wx_dps_sea_filt)
    % thetaX_deg_fromAccel_test = atan(AySimNoise_g(i)/AzSimNoise_g(i))*57.3;

    thetaX_deg_fromAccel_test = -unwrap(atan2(Ay_g_sea_filt(i), Az_g_sea_filt(i) + pi) * 180/pi);

    if isnan(thetaX_deg_fromAccel_test)
        thetaX_deg_fromAccel(i) = 0;

    else
        thetaX_deg_fromAccel(i) = thetaX_deg_fromAccel_test;
    end

    thetaX_deg_loop = (1-alphaOptimized) * (thetaX_deg_loop + Wx_dps_sea_filt(i)*dt) + (alphaOptimized) * thetaX_deg_fromAccel(i);
    thetaX_deg_complementary(i) = thetaX_deg_loop;

    thetaX_deg_loop2 = (thetaX_deg_loop2 + Wx_dps_sea_filt(i)*dt);
    thetaX_deg_fromIntegration(i) = thetaX_deg_loop2;

end


figure(15)
hold on
title('OxTS Ext. Kalman vs. Axicle Complementary Optimized Tau')
plot(time_s_sea_zeroed, Tx_deg_sea, time_s_sea_zeroed, thetaX_deg_complementary)
xlabel('Time [s]')
ylabel('Angle [deg]')
legend('OxTS RT3000 Kalman estimation', append('Optimzied Time Constant (Tau)',' = ', num2str(tau_s(minTauIndex))))
% legend('OxTS RT3100 Kalman estimation', 'Axicle complementary')
ylim([-10 10])
Plotter(1)

