% asm330_converter_v2.m
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

data = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\AxicleDeskTest1.log'); %opens as cell array

time_parse1 = data.x_2024_01_10T11_25_46_908;
minuteOffset = 0; %sec
data_parse1 = data.tud_cdc_connected__;
seconds = zeros(length(time_parse1),1);
status_reg = zeros(length(time_parse1),1);
gyro_reg = cell(length(time_parse1),1);
test1 = zeros(length(time_parse1),3);
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
        test1(i,:) = (parse_int16_v1(gyro_reg{i,1})*dps)/32678;
        % Accel 50:63

        accel_reg{i,1} = data_parse1{i,1}(50:63); %unsigned integer64

    end
          waitbar(i/length(time_parse1),hw);

end

j = 1;

hw = waitbar(0,'Running... Part 2/2');
for k = 1:length(test1)

    if test1(k,1) || test1(k,2) || test1(k,3) ~= 0 %Only read the columns where there's data

        time_s(j) = seconds(1,k);

        dataTest(j,1) = test1(k,1);
        dataTest(j,2) = test1(k,2);
        dataTest(j,3) = test1(k,3);

        j = j+1;

    end

     waitbar(k/length(test1),hw);

end


% dt = mean(gradient(time_s));
% time_linearized_s = linspace(time_s(1), time_s(end), length(time_s));

hold on
title('ASM330 Rate vs. Time')
plot(time_s, dataTest(:,1))
legend('Raw Time')
xlabel('Time [s]')
ylabel('Rate [dps]')
Plotter(1)


