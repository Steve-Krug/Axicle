% asm330_converter_v1.m
% 12/30/23
% S. Krug
% Notes:
clear all
close all
clc
% Format:
% [0 00:00:08.672] 0x1E: 0x07  0x22-0x27: 0x0600faff0500 0x22-0x27: 0xb70026ff3610

% hex2dec

data = readtable('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\datatest1.txt'); %opens as cell array

time_parse1 = data.x_000_00_00_016;
minuteOffset = 0; %sec
data_parse1 = data.Var2;


for i = 1:length(time_parse1)

    % Time
    % (clean up to int(ts[0:2]) * 3600 + int(ts[3:5]) * 60 + float(ts[6:]) next
    seconds(i) = str2num(time_parse1{i,1}(10:15)) + minuteOffset; % (H, MI, S, MS)
    if i > 1
        if seconds(i - 1) > seconds(i)
            minuteOffset =  minuteOffset + 60; %sec
            seconds(i) =  minuteOffset;
        end
    end

    %Status Reg
    status_reg(i) = str2num(data_parse1{i,1}(7:10)); %Unsigned integer 4 or 7

    % Gyro 24:37
    if strlength(data_parse1(i,1))  > 62
      
        gyro_reg(i) = str2num(data_parse1{i,1}(24:37)); %unsigned integer64

        % Accel 50:63
        accel_reg(i) = str2num(data_parse1{i,1}(50:63)); %unsigned integer64

    end

end

