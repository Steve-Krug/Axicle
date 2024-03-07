%% OBMS_Data_Axicle_Filter_SIL_v1.m
% 8/20/23
% S. Krug
% Notes:
%
% 8/20/23 - Initial start
% 1/29/24 - Rehash for rest of imported online data.
% Redo integration with new comp. functions
% 1/30/24 - The passcode for the AEGIS Padlock HD is 4078192350762598
% 1/31/24 - Modified for importing folders
% 2/2/24 - Revision v5 to process VTTI harddrive data. Starting with "FD"
% file names


clear
close all
clc
%% Settings
% Set true to make all raw data plots.
plotEnable = false;
Rate_AnglePlotEnable = true;
resample_rate = 15; %hz
allRunTimeTotal_s = 0; %for adding up entire time processed

failCounter = 0;
fs = 10; %hz
dt = 1/fs; %s
%% Load Data

files = dir('G:\Timeseries\*FD4_*.csv');
fullpaths = string(fullfile({files.folder}, {files.name}));

for i = 1:13 %13 'FD' data sets
    %Load first 'FD' data set. Each file is about 800MB...
    index_Ax = strcmp(fullpaths,'G:\Timeseries\FD4_Accel_X_' + string(i)+ '.csv');
    all_data_Ax = table2array(readtable(fullpaths(index_Ax)));
    fprintf('Ax Loaded...1/6  ')
    index_Ay = strcmp(fullpaths,'G:\Timeseries\FD4_Accel_Y_' + string(i)+ '.csv');
    all_data_Ay = table2array(readtable(fullpaths(index_Ay)));
    fprintf('Ay Loaded...2/6  ')
    index_Az = strcmp(fullpaths,'G:\Timeseries\FD4_Accel_Z_' + string(i)+ '.csv');
    all_data_Az = table2array(readtable(fullpaths(index_Az)));
    fprintf('Az Loaded...3/6  ')
    index_Wx = strcmp(fullpaths,'G:\Timeseries\FD4_Gyro_X_' + string(i)+ '.csv');
    all_data_Wx = table2array(readtable(fullpaths(index_Wx)));
    fprintf('Wx Loaded...4/6  ')
    index_Wy = strcmp(fullpaths,'G:\Timeseries\FD4_Gyro_Y_' + string(i)+ '.csv');
    all_data_Wy = table2array(readtable(fullpaths(index_Wy)));
    fprintf('Wy Loaded...5/6  ')
    index_Wz = strcmp(fullpaths,'G:\Timeseries\FD4_Gyro_Z_' + string(i)+ '.csv');
    all_data_Wz = table2array(readtable(fullpaths(index_Wz)));
    fprintf('Wz Loaded...6/6  ')

    % Find unique all unique file id's
    new_id_Ax = unique(all_data_Ax(:,1)); % same file_ID's for all channels

    for j = 1:length(new_id_Ax) %there are 1000 individual data sets per "FD"
        %Reset flag that detects if a data set is corrupt/meets error
        %conditions
        rollFlag1 = true;
        %% Find indices of first FILE_ID and sort the data
        data_Ax_indices = find(all_data_Ax(:,1) == new_id_Ax(j));
        data_Ax = all_data_Ax(data_Ax_indices, :);
        data_Ax_Sorted = sortrows(data_Ax, 2); %sorting might be unncessary, looks like they're aligned but they might not be
        data_Ay_indices = find(all_data_Ay(:,1) == new_id_Ax(j));
        data_Ay = all_data_Ay(data_Ay_indices, :);
        data_Ay_Sorted = sortrows(data_Ay, 2); %sorting might be unncessary, looks like they're aligned but they might not be
        data_Az_indices = find(all_data_Az(:,1) == new_id_Ax(j));
        data_Az = all_data_Az(data_Az_indices, :);
        data_Az_Sorted = sortrows(data_Az, 2); %sorting might be unncessary, looks like they're aligned but they might not be
        data_Wx_indices = find(all_data_Wx(:,1) == new_id_Ax(j));
        data_Wx = all_data_Wx(data_Wx_indices, :);
        data_Wx_Sorted = sortrows(data_Wx, 2); %sorting might be unncessary, looks like they're aligned but they might not be
        data_Wy_indices = find(all_data_Wy(:,1) == new_id_Ax(j));
        data_Wy = all_data_Wy(data_Wy_indices, :);
        data_Wy_Sorted = sortrows(data_Wy, 2); %sorting might be unncessary, looks like they're aligned but they might not be
        data_Wz_indices = find(all_data_Wz(:,1) == new_id_Ax(j));
        data_Wz = all_data_Wz(data_Wz_indices, :);
        data_Wz_Sorted = sortrows(data_Wz, 2); %sorting might be unncessary, looks like they're aligned but they might not be
        fprintf('All IMU channels sorted for run ' + string(j) + '/' + string(length(new_id_Ax)));



        %% Find Data Channels
        Ax_g = data_Ax_Sorted(:,4); % column 4 is actual data
        time_ms_Ax = data_Ax_Sorted(:,2); % column 2 is time in milliseconds
        time_s_Ax = (time_ms_Ax - time_ms_Ax(1))*GNCConstants.SecToMillisecond;

        Ay_g = data_Ay_Sorted(:,4); % column 4 is actual data
        time_ms_Ay = data_Ay_Sorted(:,2); % column 2 is time in milliseconds
        time_s_Ay = (time_ms_Ay - time_ms_Ay(1))*GNCConstants.SecToMillisecond;

        Az_g = data_Az_Sorted(:,4); % column 4 is actual data
        Az_g(isnan(Az_g)) = 0;
        if mean(Az_g) > 0.85 %This checks if the Az channel is reversed. Az should read negative, otherwise accel calculated angle will be wrong and throw off complementary filter
            Az_g = -Az_g;
        elseif length(Az_g) < 2000 || (mean(Az_g(1:2000))) > -0.85  % if the average valuve at the start is a bad Az hold, it's probably like corrupted data set 3949985.csv
            rollFlag1 = false;
        end
        time_ms_Az = data_Az_Sorted(:,2); % column 2 is time in milliseconds
        time_s_Az = (time_ms_Az - time_ms_Az(1))*GNCConstants.SecToMillisecond;

        Wx_dps = data_Wx_Sorted(:,4);
        Wx_dps(isnan(Wx_dps)) = 0;
        if length(Wx_dps) < 2000
            rollFlag1 = false;
        elseif abs(mean(Wx_dps(1:2000))) > 1.8 %sometimes the gyros are statically broken/reading high, ignore data set if this happens
            rollFlag1 = false;
        end
        time_ms_Wx = data_Wx_Sorted(:,2); % column 2 is time in milliseconds
        time_s_Wx = (time_ms_Wx - time_ms_Wx(1))*GNCConstants.SecToMillisecond;

        Wy_dps = data_Wy_Sorted(:,4);
        time_ms_Wy = data_Wy_Sorted(:,2); % column 2 is time in milliseconds
        time_s_Wy = (time_ms_Wy - time_ms_Wy(1))*GNCConstants.SecToMillisecond;

        Wz_dps = data_Wz_Sorted(:,4);
        time_ms_Wz = data_Wz_Sorted(:,2); % column 2 is time in milliseconds
        time_s_Wz = (time_ms_Wz - time_ms_Wz(1))*GNCConstants.SecToMillisecond;

        % Enter statement that throws error if time series are different
        % lengths, and if only a few off the others, make it match ?
        try
            allTime_s = [time_s_Ax time_s_Ay time_s_Az time_s_Wx time_s_Wy time_s_Wz]; % checker to make sure all time signals lineup
            totalTime = allTime_s(end,1) - allTime_s(1,1);
        catch
            failCounter = failCounter + 1;
            disp(failCounter);
            totalTime = time_s_Ax(end) - time_s_Ax(1);
        end
        %% Time Series Modification

        time_100_s = linspace(0, totalTime, resample_rate*totalTime); %new fs time vector

        Ax_tss_g = TSseries(Ax_g, time_s_Ax); %takes in orginal data (data, time vector) %10hz
        Ax_100_g = Ax_tss_g.resample(time_100_s); %resample
        Ax_100_g.Data(isnan(Ax_100_g.Data)) = 0;
        Ay_tss_g = TSseries(Ay_g, time_s_Ay); %takes in orginal data (data, time vector) %10hz
        Ay_100_g = Ay_tss_g.resample(time_100_s); %resample
        Ay_100_g.Data(isnan(Ay_100_g.Data)) = 0;
        Az_tss_g = TSseries(Az_g, time_s_Az); %takes in orginal data (data, time vector) %10hz
        Az_100_g = Az_tss_g.resample(time_100_s); %resample
        Az_100_g.Data(isnan(Az_100_g.Data)) = 0;
        Wx_tss_dps = TSseries(Wx_dps, time_s_Wx); %takes in orginal data (data, time vector) %10hz
        Wx_100_dps = Wx_tss_dps.resample(time_100_s); %resample
        Wx_100_dps.Data(isnan(Wx_100_dps.Data)) = 0;
        Wy_tss_dps = TSseries(Wy_dps, time_s_Wy); %takes in orginal data (data, time vector) %10hz
        Wy_100_dps = Wy_tss_dps.resample(time_100_s); %resample
        Wy_100_dps.Data(isnan(Wy_100_dps.Data)) = 0;
        Wz_tss_dps = TSseries(Wz_dps, time_s_Wz); %takes in orginal data (data, time vector) %10hz
        Wz_100_dps = Wz_tss_dps.resample(time_100_s); %resample
        Wz_100_dps.Data(isnan(Wz_100_dps.Data)) = 0;

        if true(plotEnable)
            figure(1)
            hold on
            subplot(2,1,1)
            plot(time_s_Ax, Ax_g, time_100_s, Ax_100_g.Data, time_s_Ay, Ay_g, time_100_s, Ay_100_g.Data, time_s_Az, Az_g, time_100_s, Az_100_g.Data)
            title('Event ID: 3,190,358 Rollover')
            legend('Ax raw', 'Ay raw', 'Az raw',...
                'Ax resampled', 'Ay resampled', 'Az resampled')
            ylabel('Accels [g]')
            Plotter(1)
            hold on
            subplot(2,1,2)
            plot(time_s_Wx, Wx_dps, time_100_s, Wx_100_dps.Data, time_s_Wy, Wy_dps, time_100_s, Wy_100_dps.Data, time_s_Wz, Wz_dps, time_100_s, Wz_100_dps.Data)
            legend('Wx raw', 'Wy raw', 'Wz raw',...
                'Wx resampled', 'Wy resampled', 'Wz resampled')
            xlabel('Time [s]')
            ylabel('Rate [dps]')
            Plotter(1)
        end
        %% Filters
        newFreq = resample_rate; %After decimating
        % Filters for profile roughness rebuilding, zero mean.
        filt_freq = [0.05/(newFreq/2);...   %Accelerations high pass frequency
            0.05/(newFreq/2);...            %Velocity high pass frequency
            0.4/(newFreq/2);...             %Displacement high pass frequency
            7/(newFreq/2);...             %general low pass settings
            0.1/(newFreq/2);...             %Isolate MT filter, Acc
            0.175/(newFreq/2);...             %Isolate MT filter, Vel
            0.01/(newFreq/2)];                 %string pot low pass
        [B,A]=butter(1,filt_freq(1),'High'); %Accelerations high pass frequency
        [D,C]=butter(1,filt_freq(2),'High'); %Velocity high pass frequency
        [H,G]=butter(1,filt_freq(4),'Low'); %general low pass settings

        Ax_filt_g = filtfilt(H,G,Ax_100_g.Data);
        Ay_filt_g = filtfilt(H,G,Ay_100_g.Data);
        Az_filt_g = filtfilt(H,G,Az_100_g.Data);
        Wx_filt_dps = filtfilt(H,G,Wx_100_dps.Data);
        Wy_filt_dps = filtfilt(H,G,Wy_100_dps.Data);
        Wz_filt_dps = filtfilt(H,G,Wz_100_dps.Data);

        if true(plotEnable)
            figure(2)
            hold on
            subplot(2,1,1)
            plot(time_s_Ax, Ax_g, time_100_s, Ax_filt_g, time_s_Ay, Ay_g, time_100_s, Ay_filt_g, time_s_Az, Az_g, time_100_s, Az_filt_g)
            title('Event ID: 3,190,358 Rollover')
            legend('Ax raw','Ax filtered', 'Ay raw', 'Ay filtered','Az raw', 'Az filtered')
            ylabel('Accels [g]')
            % xlim([1444 1464])
            Plotter(1)
            hold on
            subplot(2,1,2)
            plot(time_s_Wx, Wx_dps, time_100_s, Wx_filt_dps, time_s_Wy, Wy_dps, time_100_s, Wy_filt_dps, time_s_Wz, Wz_dps, time_100_s, Wz_filt_dps)
            legend('Wx raw', 'Wx filtered', 'Wy raw','Wy filtered', 'Wz raw','Wz filtered')
            xlabel('Time [s]')
            ylabel('Rate [dps]')
            % xlim([1444 1464])
            Plotter(1)
        end

        %% Complementary Filter
        tau_s_hp = 12;
        tau_s = 500;
        [angleAccel_LP_deg, thetaX_comp_deg, angleAccel_raw_deg, anglePureIntegration_HP_deg, gyroLP, gyroHP]...
            = Axicle_Rate2Angle_Comp_v1(time_100_s, Wx_filt_dps, Ay_filt_g, -Az_filt_g, tau_s, tau_s_hp);

        %% Calculate statistics
        if false(rollFlag1)
            meanAx(i,j) = 0; %#ok<UNRCH>
            meanAy(i,j) = 0;
            meanAz(i,j) = 0;
            meanWx(i,j) = 0;
            meanWy(i,j) = 0;
            meanWz(i,j) = 0;
            meanRollAngle(i,j) = 0;
            stdAx(i,j) = 0;
            stdAy(i,j) = 0;
            stdAz(i,j) = 0;
            stdWx(i,j) = 0;
            stdWy(i,j) = 0;
            stdWz(i,j) = 0;
            stdRollAngle(i,j) = 0;
            maxAx(i,j) = 0;
            maxAy(i,j) = 0;
            maxAz(i,j) = 0;
            maxWx(i,j) = 0;
            maxWy(i,j) = 0;
            maxWz(i,j) = 0;
            maxRollAngle(i,j) = 0; 
            % maxThetaXatRR(i,j) = 0;
            % RRatmaxThetaX(i,j) = 0;
            % RR_index = 0;
            % maxRRatThetaX(i,j) = 0;
            % thetaXatmaxRR(i,j) = 0;
            
        else

            meanAx(i,j) = mean(Ax_filt_g);
            meanAy(i,j) = mean(Ay_filt_g);
            meanAz(i,j) = mean(Az_filt_g);
            meanWx(i,j) = mean(Wx_filt_dps);
            meanWy(i,j) = mean(Wy_filt_dps);
            meanWz(i,j) = mean(Wz_filt_dps);
            meanRollAngle(i,j) = mean(thetaX_comp_deg);
            stdAx(i,j) = std(Ax_filt_g);
            stdAy(i,j) = std(Ay_filt_g);
            stdAz(i,j) = std(Az_filt_g);
            stdWx(i,j) = std(Wx_filt_dps);
            stdWy(i,j) = std(Wy_filt_dps);
            stdWz(i,j) = std(Wz_filt_dps);
            stdRollAngle(i,j) = std(thetaX_comp_deg);
            maxAx(i,j) = max(Ax_filt_g);
            maxAy(i,j) = max(Ay_filt_g);
            maxAz(i,j) = max(Az_filt_g);
            maxWx(i,j) = max(Wx_filt_dps);
            maxWy(i,j) = max(Wy_filt_dps);
            maxWz(i,j) = max(Wz_filt_dps);
            maxRollAngle(i,j) = max(thetaX_comp_deg);

            % thetaX_index = find(thetaX_comp_deg == maxabs(thetaX_comp_deg));
            % maxThetaXatRR(i,j) = abs(thetaX_comp_deg(thetaX_index));
            % RRatmaxThetaX(i,j) = abs(Wx_filt_dps(thetaX_index));
            % 
            % RR_index = find(Wx_filt_dps == maxabs(Wx_filt_dps));
            % maxRRatThetaX(i,j) = abs(Wx_filt_dps(RR_index));
            % thetaXatmaxRR(i,j) = abs(thetaX_comp_deg(RR_index));


        end

        if true(plotEnable)
            figure(4)
            subplot(3,1,1)
            plot(time_100_s, thetaX_comp_deg, time_100_s, angleAccel_raw_deg, time_100_s, angleAccel_LP_deg)
            grid on
            ylabel('Angle [deg]')
            title('VTTI Real Rollover Run')
            legend('Axicle Complementary, Roll Angle', 'angle accel raw', 'angle accel lp')
            % xlim([1444 1464])
            Plotter(1)
            subplot(3,1,2)
            plot(time_100_s, Wx_filt_dps, time_100_s, Wy_filt_dps, time_100_s, Wz_filt_dps)
            ylabel('rate [deg/s]')
            legend('RollR', 'PitchR', 'YawR')
            % xlim([1444 1464])
            Plotter(1)
            subplot(3,1,3)
            plot(time_100_s, Ax_filt_g, time_100_s, Ay_filt_g, time_100_s, Az_filt_g)
            legend('Ax', 'Ay', 'Az')
            % xlim([1444 1464])
            Plotter(1)
            ylabel('Accel [g]')
            xlabel('Time [s]')
        end

        if true(Rate_AnglePlotEnable)
            figure(5)
            hold on
            if max(abs(thetaX_comp_deg)) > 20 & true(rollFlag1)
                % plot(abs(thetaX_comp_deg), abs(Wx_100_dps.Data), 'r')
                failCounter = failCounter+ 1;
                hold on
                Plotter(1)
                xlabel('Roll Angle [deg]')
                ylabel('Roll Rate [deg/s]')
                % allRunTimeTotal_s = allRunTimeTotal_s + totalTime;

            else
                if true(rollFlag1) %only plot data sets that don't have corrupted gyro data
                    hold on
                    scatter(abs(thetaX_comp_deg), abs(Wx_100_dps.Data), '.k')

                    % scatter(maxThetaXatRR(i,j), RRatmaxThetaX(i,j), '.k')
                    % scatter(thetaXatmaxRR(i,j), maxRRatThetaX(i,j), '.r')
                    Plotter(1)
                    xlabel('Roll Angle [deg]')
                    ylabel('Roll Rate [deg/s]')

                    allRunTimeTotal_s = allRunTimeTotal_s + totalTime; %Add up cumulative time from all data sets.
                end
            end
        end
    end
    hold on
end