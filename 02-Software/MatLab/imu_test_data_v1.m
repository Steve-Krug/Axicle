%imu_test_data_v1

clear all
close all
clc


load('C:\Git\Axicle\Firmware\Arduino\Code\testdata1.mat');

% columns: yaw, pitch, roll
time1 = linspace(0, (length(testdata1(:,3))/50),(length(testdata1(:,3))));
roll1 = testdata1(:,1);
sensor1 = testdata1(:,2);
plot(time1, roll1, time1, sensor1)

title('arduino sd card reader, 50hz');
xlabel('time, s');
ylabel('roll angle, deg & sensor state');

Plotter(1);