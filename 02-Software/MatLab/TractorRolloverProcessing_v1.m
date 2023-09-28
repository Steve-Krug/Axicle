%% Title: TractorRolloverProcessing_v1.m
% 9/22/23
% S. Krug
% Notes:

close all
clc
clear
dir = 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\';
tData{1} = load(append(dir,'230909_SWD_n1000_50_100_185_225_5k_25k_v1_ResultsTractorRollovers.mat'));
tData{2} = load(append(dir, '230908_F8_n1000_v1_ResultsTractorRollovers.mat'));
tData{3} = load(append(dir,'230911_neg20Slope_n1000_v3_ResultsTractorRollovers.mat'));
tData{4} = load(append(dir, '230914_LH_100mRad_Wind_n1296_v1_ResultsTractorRollovers.mat'));
tData{5} = load(append(dir, '230914_StraightWind_n900_v1_ResultsTractorRollovers.mat'));
tData{6} = load(append(dir, '230921_JTurn_n3654_v1_ResultsTractorRollovers.mat'));


for i = 1:length(tData)
    tRoll_deg = tData{i}.tractorRoll;
    tRollRate_dps = tData{i}.tractorRollRate;
    xLow = tRoll_deg > 13.1;
    % yLow = tRollRate_dps > 20;
    figure(1)
    hold on
    scatter(tRoll_deg(xLow), tRollRate_dps(xLow))
    xlabel('Roll Angle [deg]')
    ylabel('Roll Rate [deg/s]')
    hold on
end

clear tData

TTData{1} = load(append(dir,'230909_SWD_n1000_50_100_185_225_5k_25k_v1.mat'));
TTData{2} = load(append(dir, '230908_F8_n1000_v1.mat'));
TTData{3} = load(append(dir,'230911_neg20Slope_n1000_v3.mat'));
TTData{4} = load(append(dir, '230914_LH_100mRad_Wind_n1296_v1.mat'));
TTData{5} = load(append(dir, '230914_StraightWind_n900_v1.mat'));
TTData{6} = load(append(dir, '230921_JTurn_n3654_v1.mat'));

tractorRollThreshold_deg = 70;

for j = 1:length(TTData)
    for k = 1:length(TTData{1,j}.data)
        dataMatrix = table2array(TTData{1,j}.data{1,k});
        if max(dataMatrix(:,9)) < tractorRollThreshold_deg && min(dataMatrix(:,9)) > -tractorRollThreshold_deg % Check for LH or RH turn. If both are true, there's no rollover in either direction
            % noRolloverSim(tractortrailerSims) = isempty(rollIndices);
            % Record if no rollovers occur
            figure(1)
            hold on
            scatter(abs(TTData{1,j}.data{1,k}.Roll), abs(TTData{1,j}.data{1,k}.AVx), 1, 'k', '.' )
            hold on
        end

        % waitbar(k/length(TTData{1,1}.data))

    end
end

