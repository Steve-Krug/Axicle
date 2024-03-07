%% Title: RunTruckSim_Tractor_Only_RollFind_v4_NegativeTTRollover.m
% 9/3/23
% S. Krug
% Notes:
%This function runs a tractor only rollover simulation at increasing
%roll angles until the tractor rolls over by itself, to find the last/highest
%angle that's recoverable
% Use this function if the TT signals show a negative rollover trace (-).

%dataMatrix must be matrix/array of a single tractor + trailer
%sim in the following column format:

% Columns - Variable Name
% 1 - Time
% 2 - Vx
% 3 - Vy
% 4 - Vz
% 5 - AVx
% 6 - AVy
% 7 - AVz
% 8 - Pitch
% 9 - Roll
% 10 - Yaw
% 11 - Ax
% 12 - Ay
% 13 - Az
% 14 - Ax_S1
% 15 - Ay_S1
% 16 - Az_S1

% Must first have a tractor sim.
clc
clear
close all


%% Load Data from Tractor and Trailer Rollovers
load('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\230918_JTurn_n3654_v1.mat')
load('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\wind_array_v1.mat')
% dataMatrix = table2array(data{1,6}); %Convert from table to array of one set of sim results
indexOld = 0;
indexFlag1 = 1;
indexFlag2 = 0;
simSlow1 = 0;
simSlow2 = 0;
lowerRollAngleThreshold_deg = 5;
upperRollAngleThreshold_deg = 48;
rolloverCounter = 0;
allTractorRunCounter = 1;
flag = 1;
simSlowFlag1 = 0;
failedSim = 1;

for tractorTrailerSims = 1:length(data) %Loop through tractor + trailer sim results
    dataMatrix = table2array(data{1,tractorTrailerSims});

    %% Find max roll angle between thresholds
    runCounter = 1;
    tractorRollThreshold_deg = 50; %deg
    clear tractorData;

    % if allTractorRunCounter == 41
    %     flag = flag +1 ;
    % end

    for rollThreshold = lowerRollAngleThreshold_deg:upperRollAngleThreshold_deg %iterate at increasing roll angles in increments of 1 deg
        % dataMatrix = table2array(data{1,6}); %Convert from table to array

        rollIndices = find(dataMatrix(:,9) < -rollThreshold); %Indices at which a roll angle above "rollThreshold" is achieved.
        %Roll angle is read as negative in this tractor/trailer simulation...

        %check if a rollover actually occurs. If there is no rollover, break out of this loop to next dataMatrix/tractortrailer sim data.
        if max(dataMatrix(:,9)) < tractorRollThreshold_deg && min(dataMatrix(:,9)) > -tractorRollThreshold_deg % Check for LH or RH turn. If both are true, there's no rollover in either direction

            % noRolloverSim(tractortrailerSims) = isempty(rollIndices);
            % Record if no rollovers occur

            break
        else
            rollIndex = rollIndices(1); %Pick the first index at which the rollThreshold is achieved test if it's unrecoverable

            % Log the state of the tractor/trailer during the rollover, such that
            % it can be imposed into tractor only to see if it will recover

            % Vehicle Target Speed
            SPEED = dataMatrix(rollIndex,2); %kph
            speedStore(runCounter) = SPEED;
            %ODE: Global Z coord. of sprung-mass origin, unit 1 {Zo}. Set in
            %TruckSim
            %Euler pitch Unit 1
            SV_PITCH = abs(dataMatrix(rollIndex,8))*GNCConstants.DegreeToRadian; % deg to rad Pitch angle
            pitchStore(runCounter) = SV_PITCH;
            %Euler roll Unit 1
            SV_ROLL = abs(dataMatrix(rollIndex,9))*GNCConstants.DegreeToRadian; % deg to rad Roll angle
            rollStore(runCounter) = SV_ROLL;
            %Steer Angle
            STEER_SW = abs(dataMatrix(rollIndex,17));  %deg?
            steerStore(runCounter) = STEER_SW*GNCConstants.DegreeToRadian;
            %Lateral Acceleration
            Ay = 1; %g? Does not intialize Lateral acceleration
            ayStore(runCounter) = dataMatrix(rollIndex,12);
            %Chassis slip angle
            SV_BETA = -3/57.3; %deg to rad Chassis slip angle (sideslip angle)
            %Roll rate of unit 1
            SV_AVX = abs(dataMatrix(rollIndex,5))*GNCConstants.DegreeToRadian;  %deg/s to rad/s Vehicle roll rate
            rollrateStore(runCounter) = SV_AVX;

            %Wind speed gain
            wind_speed_gain_input = wind_speed_gain(tractorTrailerSims);

            %Set simulink model
            block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL_Tractor_Only_Test1'));


            %Set parameters for simulation
            set_param(block1{1,1}, 'Value', 'SPEED');
            set_param(block1{2,1}, 'Value', 'SV_PITCH');
            set_param(block1{3,1}, 'Value', 'SV_ROLL');
            set_param(block1{4,1}, 'Value', 'STEER_SW');
            set_param(block1{5,1}, 'Value', 'Ay');
            set_param(block1{6,1}, 'Value', 'SV_BETA');
            set_param(block1{7,1}, 'Value', 'SV_AVX');
            set_param(block1{8,1}, 'Value', 'wind_speed_gain_input');
            
            sim('batch_iteration_SWD_SL_Tractor_Only_Test1');
            % close_system('batch_iteration_SWD_SL')
            % waitbar(i/total_runs)
            % pause(1)
            pause(1)


            %Get list of .csv files in result folder
            % files = dir(fullfile(folder_path, '*.csv'));
            % % h = waitbar(0,'Loading data...');
            % % for i = 1:length(files)
            % filename = fullfile(folder_path, files(end).name);
            % % end


            %% Load Result Data & Slow Sim Handling
            folder_path = 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_4f673585-764b-467b-a0eb-1562355ad8c5';
            d            = dir('C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_4f673585-764b-467b-a0eb-1562355ad8c5/*.csv');
            [~, index]   = max([d.datenum]);



            if isempty(index) || isempty(indexOld) % For first sim run
                pause(1)
                files = dir(fullfile(folder_path, '*.csv'));

                for i = 1:length(files)
                    filename = fullfile(folder_path, files(end).name);
                end

                youngestFile = filename;
            elseif index > indexOld

                youngestFile = fullfile(d(index).folder, d(index).name);  % [EDITED], typo fixed
            elseif index == indexOld
                while index == indexOld
                    pause(1)
                    disp('Pausing for 1sec, Sim Slow Warning.')
                    simSlow1 = simSlow1 + 1;
                    simSlowFlag1 = simSlowFlag1 +1;
                    [~, index]   = max([d.datenum]);
                    youngestFile = fullfile(d(index).folder, d(index).name);
                    % indexFlag1 = index;
                    if simSlowFlag1 == 10
                        
                        failedSimNumber(failedSim) = tractorTrailerSims;
                        failedSim = failedSim + 1;
                        disp('Sim failed after 10 attempts. Break to next configuration.')
                        
                        break
                    end
                end
            end

            if simSlowFlag1 == 10
                simSlowFlag1 = 0;
                 break
            end
            indexOld = index;


            % if isempty(index) || isempty(indexOld) % For first sim run
            %     pause(1)
            %     files = dir(fullfile(folder_path, '*.csv'));
            %
            %     for i = 1:length(files)
            %         filename = fullfile(folder_path, files(end).name);
            %     end
            %
            %     youngestFile = filename;
            % elseif index > indexOld
            %
            %     youngestFile = fullfile(d(index).folder, d(index).name);  % [EDITED], typo fixed
            % elseif index == indexOld
            %     pause(1)
            %     disp('Pausing for 1sec, Sim Slow Warning.')
            %     simSlow1 = simSlow1 + 1;
            %     [~, index]   = max([d.datenum]);
            %     indexFlag1 = index;
            %
            %     if indexFlag1 > index
            %         youngestFile = fullfile(d(index).folder, d(index).name);
            %         % indexFlag1 = indexOld;
            %     else
            %         indexFlag2 = index;
            %
            %     end
            %
            % elseif indexFlag2 == indexOld
            %     pause(7)
            %     disp('Pausing for 7sec, Sim Slow Warning.')
            %     simSlow2 = simSlow2 + 1;
            %     youngestFile = fullfile(d(index).folder, d(index).name);
            % end

            % if index > indexOld

            % dataTractor{i} = readtable(filename);
            %store all tractor rollover data
            tractorData = readtable(youngestFile);
            allTractorData{allTractorRunCounter} = tractorData;
            allTractorRunCounter = allTractorRunCounter + 1;
            tractorDataMatrix = table2array(tractorData);
            runCounter = runCounter + 1;

            %Check if the release angle DID create a rollover, such that
            %the previous rollover release angle was the last possible
            %angle.
            % if max(tractorDataMatrix(:,9)) > tractorRollThreshold_deg && rollThreshold == 16
            %     flag = flag + 1;
            %
            % end


            %% Rollover Check, Iteration

            if max(tractorDataMatrix(:,9)) > tractorRollThreshold_deg % Did a rollover occur? If yes, store the last values where a tractor rollover was prevented, i.e. previous run.
                maxRollAngle_deg = rollThreshold - 1; %deg previous angle

                rolloverCounter = rolloverCounter + 1; %

                %Store variables of interest, last SAFE values
                maxSafeRollAngle_deg(rolloverCounter) = maxRollAngle_deg;
                tractorVx(rolloverCounter) = speedStore(runCounter - 1);
                tractorPitch(rolloverCounter) = pitchStore(runCounter - 1)*GNCConstants.RadianToDegree;
                tractorRoll(rolloverCounter) = rollStore(runCounter - 1)*GNCConstants.RadianToDegree;
                tractorAy(rolloverCounter) = ayStore(runCounter - 1);
                tractorSWA(rolloverCounter) = steerStore(runCounter - 1)*GNCConstants.RadianToDegree;
                tractorRollRate(rolloverCounter) =  rollrateStore(runCounter - 1)*GNCConstants.RadianToDegree;

                break %exit loop and return max roll angle tolerable
            end
        end


    end

    %TractorTrailer condition progress bar.
    waitbar(tractorTrailerSims/length(data))


end



% For Plots
%
% figure(2)
% hold on
% for i = 1:length(allTractorData)
%     hold on
%     title('Tractor Only Sims')
%     plot(allTractorData{1,i}.Time, allTractorData{1,i}.Roll)
%     xlabel('Roll Angle [deg]')
%     ylabel('Time [s]')
%     grid on
% end

figure(3)
hold on
title('Tractor Max Safe Roll Angle and Roll Rate, SWD n = 1000, 261 Rollovers')
scatter(tractorRoll, tractorRollRate)
xlabel('Tractor Roll Angle [deg]')
ylabel('Tractor Roll Rate [deg/s]')
% xlim([0 35])
% ylim([0 70])
Plotter(1)
hold on

% figure(3)
% hold on
% title('Tractor Max Safe Roll Angle and Roll Rate, SWD n = 1000, 261 Rollovers')
% scatter(tractorRoll, tractorVx)
% xlabel('Tractor Roll Angle [deg]')
% ylabel('Tractor Roll Rate [deg/s]')
% % xlim([0 35])
% % ylim([0 70])
% Plotter(1)
% hold on



for k = 1:length(data)
    dataMatrix = table2array(data{1,k});
    if max(dataMatrix(:,9)) < tractorRollThreshold_deg && min(dataMatrix(:,9)) > -tractorRollThreshold_deg % Check for LH or RH turn. If both are true, there's no rollover in either direction
        % noRolloverSim(tractortrailerSims) = isempty(rollIndices);
        % Record if no rollovers occur
        figure(3)
        hold on
        scatter(abs(data{1,k}.Roll), abs(data{1,k}.AVx), 1, 'k', '.' )
        xlabel('Tractor Roll Angle [deg]')
        ylabel('Tractor Roll Rate [deg/s]')
        xlim([0 35])
        ylim([0 70])
        hold on
    end

    waitbar(k/length(data))

end
m = 1;
% for j = 2:length(allTractorData)
%
%     if length(allTractorData{1,j}.Time) == length(allTractorData{1,j-1}.Time) && length(allTractorData{1,j}.Time) ~= 10001
%
%         repeatedSimIndex(m) = j;
%
%     m = m+1;
%
%     end
%
% end


% for b = 1:length(repeatedSimIndex)
%     figure(4)
%     hold on
%     scatter(repeatedSimIndex(b),run_input_array(b,3))
%     legend('Mass','CG Height','Speed')
%     hold on
% 
% end