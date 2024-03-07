% SBG_SerialPortAnalyzer_v1.m
% 

clear
clc
close all


s = serialport("COM4", 115200);
i = 1;
while(1)


    data_parse1{i,1} = fscanf(s);
    i = i+1;
end

fclose(s)