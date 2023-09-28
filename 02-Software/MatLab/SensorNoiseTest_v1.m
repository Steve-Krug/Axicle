%% SensorNoiseTest_v1.m
% 8/29/23
% S. Krug
% Notes:
%
clc
clear
close all

load('C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\Electrical\IMU\noise_data.mat');
load('C:\Users\SteveKrug\OneDrive - Axicle\Public\6. Engineering\Electrical\IMU\indexData.mat')
data =table2cell(t);

% cellfind = @(string)(@(cell_contents)(strcmp(string,cell_contents)));
% indexG = cellfun(cellfind('G'),data); %gyro data
% indexA = cellfun(cellfind('A'),data); %acceleration data
% indexX = cellfun(cellfind('X'),data);
% indexY = cellfun(cellfind('Y'),data);
% indexZ = cellfun(cellfind('Z'),data);
j1 = 1;
j2 = 1;
j3 = 1;
j4 = 1;
j5 = 1;
j6 = 1;

for i = 1:length(data)

    if indexG(i,2) == 1 && indexX(i,3) == 1 %Gyro X
        omegax_noise(j1) = cell2mat(data(i,4));
        time_omegax_noise(j1) = cell2mat(data(i,1));
        j1 = j1+1;

    elseif indexG(i,2) ==1 && indexY(i,3) == 1 %Gyro Y
        omegay_noise(j2) = cell2mat(data(i,4));
        time_omegay_noise(j2) = cell2mat(data(i,1));
        j2 = j2+1;

    elseif indexG(i,2) ==1 && indexZ(i,3) == 1 %Gyro Z
        omegaz_noise(j3) = cell2mat(data(i,4));
        time_omegaz_noise(j3) = cell2mat(data(i,1));
        j3 = j3+1;

    elseif indexA(i,2) ==1 && indexX(i,3) == 1 %Accel X
        Ax_noise(j4) = cell2mat(data(i,4));
        time_Ax_noise(j4) = cell2mat(data(i,1));
        j4 = j4+1;

    elseif indexA(i,2) ==1 && indexY(i,3) == 1 %Accel Y
        Ay_noise(j5) = cell2mat(data(i,4));
        time_Ay_noise(j5) = cell2mat(data(i,1));
        j5 = j5+1;

    elseif indexA(i,2) ==1 && indexZ(i,3) == 1 %Accel Z
        Az_noise(j6) = cell2mat(data(i,4));
        time_Az_noise(j6) = cell2mat(data(i,1));
        j6 = j6+1;

    end
    waitbar(i/length(data))
end
figure(2)
grid on
plot(time_omegax_noise, omegax_noise, time_omegay_noise, omegay_noise, time_omegaz_noise, omegaz_noise)
ylabel('Rate [deg/s]')
xlabel('Time [s]')
title('Gyro Noise')
legend('x', 'y', 'z')
grid on



figure(3)
grid on
plot(time_Ax_noise, Ax_noise, time_Ay_noise, Ay_noise, time_Az_noise, Az_noise)
ylabel('Acceleration [G]')
xlabel('Time [s]')
title('Accelerometer Noise')
legend('x', 'y', 'z')
grid on

% gyroData = strfind(t.Var2,'G');
%

% gyroIndices = find(gyroData=1);

% index = find([gyroData{:}] ==1);
% index = false(1,numel(gyroData));
%
% for i = 1:length(gyroData)
%     try true
%         index(i) = (gyroData{i} == 1);
%     catch
%
%     end
%     waitbar(i/length(gyroData))
%
% end