% asm330_converter_v3.m
% 12/30/23
% S. Krug
% Notes:
clear all
close all
clc
% Format:
% [0 00:00:08.672] 0x1E: 0x07  0x22-0x27: 0x0600faff0500 0x22-0x27: 0xb70026ff3610

% hex2dec
% data = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\datatest1.txt'); %opens as cell array

% data = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleDeskTest1.log'); %opens as cell array
load('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleDeskTest1.mat')

time_parse1 = data.x_2024_01_10T11_25_46_908;
minuteOffset = 0; %sec
data_parse1 = data.tud_cdc_connected__;
seconds = zeros(length(time_parse1),1);
status_reg = zeros(length(time_parse1),1);
gyro_reg = cell(length(time_parse1),1);
imuDataAlpha = zeros(length(time_parse1),6);
accel_reg  = cell(length(time_parse1),3);


hw = waitbar(0,'Running... Part 1/2');

for i = 1:length(time_parse1)

    % seconds(i) = str2num(time_parse1{i,1}(19:24)) + minuteOffset; % (H, MI, S, MS)

    seconds(i) = str2num(time_parse1{i,1}(13:14))*3600 + str2num(time_parse1{i,1}(16:17))*60 + str2num(time_parse1{i,1}(19:24));

    % if i > 1
    %     if seconds(i - 1) > seconds(i)
    %         minuteOffset =  minuteOffset + 60; %sec
    %         seconds(i) =  minuteOffset;
    %     end
    % end

    %Status Reg
    status_reg(i) = str2num(data_parse1{i,1}(7:10)); %Unsigned integer 4 or 7

    % Gyro 24:37
    if strlength(data_parse1(i,1))  > 62

        gyro_reg{i,1} = data_parse1{i,1}(24:37); %unsigned integer64

        dps = 2000;
        imuDataAlpha(i,1:3) = (parse_int16_v1(gyro_reg{i,1})*dps)/32678;
        % Accel 50:63

        accel_reg{i,1} = data_parse1{i,1}(50:63); %unsigned integer64
        imuDataAlpha(i,4:6) = (parse_int16_v1(accel_reg{i,1})*dps)/32678;

    end
    waitbar(i/length(time_parse1),hw);

end

j = 1;

% hw = waitbar(0,'Running... Part 2/2');
% for k = 1:length(imuDataAlpha) %Takes out the zero elements
% 
%     if imuDataAlpha(k,1) || imuDataAlpha(k,2) || imuDataAlpha(k,3)...
%             || imuDataAlpha(k,4) || imuDataAlpha(k,5) || imuDataAlpha(k,6)   ~= 0 %Only read the columns where there's data
% 
%         time_s(j) = seconds(1,k);
% 
%         imuDataBeta(j,1) = imuDataAlpha(k,1);
%         imuDataBeta(j,2) = imuDataAlpha(k,2);
%         imuDataBeta(j,3) = imuDataAlpha(k,3);
%         imuDataBeta(j,4) = imuDataAlpha(k,4);
%         imuDataBeta(j,5) = imuDataAlpha(k,5);
%         imuDataBeta(j,6) = imuDataAlpha(k,6);
% 
%         j = j+1;
% 
%     end
% 
%     waitbar(k/length(imuDataAlpha),hw);
% 
% end


% dt = mean(gradient(time_s));
% time_linearized_s = linspace(time_s(1), time_s(end), length(time_s));

hold on
title('ASM330 Rate vs. Time')
plot(time_s, imuDataAlpha(:,1))
legend('Raw Time')
xlabel('Time [s]')
ylabel('Rate [dps]')
Plotter(1)


