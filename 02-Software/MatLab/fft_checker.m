clear
clc
close all


load('240327_data_i94Road_v2.mat')

sg_order = 2;
sg_framelength = 101;
fs = 1/(data{1,40}.Time(2)-data{1,40}.Time(1));
[freq, mag, phase] = fft_lite_v2(fs, data{1,40}.Az_S2);


sgf_1 = sgolayfilt(mag, sg_order, sg_framelength );

figure(1)
subplot(2,1,1)
plot(freq, sgf_1, 'r')
hold on
ylabel('amplitude')
xlabel('freq [hz]')
% ylim([0 300])
xlim([0 20])
Plotter(1);

subplot(2,1,2)
plot(freq, mag, 'k')
hold on
ylabel('amplitude')
xlabel('freq [hz]')
xlim([0 20])
Plotter(1);