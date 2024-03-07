% ASM_SerialPortAnalyzer_v2.m
% 2/06/24
% S. Krug
% Notes:
clear
clc
close all


s = serialport("COM5", 921600);
time = 0;
i = 1;
j = 2;
window = 1000;
time(1:2) = 0;
gyrosX(1) = 0;
gyrosY(1) = 0;
gyrosZ(1) = 0;
accelX(1) = 0;
accelY(1) = 0;
accelZ(1) = 0;
angleComp(1:2) = 0;
angleAccel_LP(1:2) = 0;
anglePureIntegration_HP(1:2) = 0;
gyro_LP(1:2) = 0;
fs = 111;
dt = 1/fs;

while(1)

    data_parse1{i,1} = fscanf(s);

    % seconds(i) = str2double(time_parse1{i,1}(13:14))*3600 + str2double(time_parse1{i,1}(16:17))*60 + str2double(time_parse1{i,1}(19:24));

    if strlength(data_parse1(i,1)) > 62 % this seems to be ignored

        gyro_reg{i,1} = data_parse1{i,1}(24:37); %unsigned integer64
        accel_reg{i,1} = data_parse1{i,1}(50:63); %unsigned integer64

        if ~isempty(gyro_reg{i,1}) % if cell is not empty, be true (1).. but doesn't seem to be operating properly
            %Gyros
            dps = 2000;
            gyros(i,:) = (parse_int16_v1(gyro_reg{i,1})*dps)/32678;

            xlm = 8;
            accels(i,:) = (parse_int16_v1(accel_reg{i,1})*xlm)/32678;

            %% Store data and apply filter
            if abs(gyros(i,1)) > 0
                time(j) = time(j-1) + dt;
                gyrosY(j) = gyros(i,1);
                gyrosX(j) = gyros(i,2);
                gyrosZ(j) = gyros(i,3);
                accelY(j) = accels(i,1);
                accelX(j) = accels(i,2);
                accelZ(j) = accels(i,3);


                % Time-Discrete Complementary Filter
                tau_s_hp = 30; %higher the number will make the angle estimate be a higher amplitude and more stable,
                % (usually closer it seems by physical measurement if a high static angle being held)
                tau_s = 1000; %lower number will make it resolve faster to static angles


                if j == 2
                    thetaX_LP_Accel_deg = 0;
                    thetaX_Complementary_deg = 0;
                    thetaX_Integration_HP_deg = 0;
                    gyro_LP_dps = 0;
                end

                if j > 2
                    thetaX_LP_Accel_deg = angleAccel_LP(j-1);
                    thetaX_Complementary_deg = angleComp(j-1);
                    thetaX_Integration_HP_deg = anglePureIntegration_HP(j-1);
                    gyro_LP_dps = gyro_LP(j-1);

                    [angleAccel_LP(j), angleComp(j), anglePureIntegration_HP(j), gyro_LP(j)] = Axicle_Rate2Angle_Comp_TimeDiscrete_v1(...
                        dt, gyrosX(j), thetaX_LP_Accel_deg, thetaX_Complementary_deg, thetaX_Integration_HP_deg, gyro_LP_dps, accelY(j), accelZ(j), tau_s, tau_s_hp);
                end
                %%
            end


            if abs(gyros(i,1)) > 0 % this also isn't working for some reason
                if j <= window

                    % figure(1) this slows it down significantly

                    % plot(gyrosX(:)) % plotting with time(:) does not work
                    % for some reason
                    % subplot(2,1,1)


                    plot(angleComp(:))
                    % grid on

                    % hold on
                    % plot(time(:), angleComp(:))

                    % ylim([-100 100])
                    % xlim([0 2000])
                    % subplot(2,1,2)
                    % plot(gyrosX(:))

                    % plot(gyrosY(:))
                    % plot(gyrosZ(:))

                    j  = j+1;
                    % xlabel('Time [ms]')
                    % ylabel('Rate [deg/s]')
                else
                    % plot(gyros(end-window:end,1)) %
                    % figure(1) this slows it down significantly

                    % plot(gyrosX(end-window:end)) %
                    % subplot(2,1,1)

                    % hold on
                    plot(angleComp(end-window:end));
                    
                    % grid on %grid also slows it down
                    % hold on
                    % plot(time(j), angleComp(j))

                    % xlim([(time(j) - 5) (time(j) + 5)])

                    % drawnow %draw now makes huge delay
                    % ylim([-100 100]) this will also not make the plot show
                    % up
                    % xlim([0 2000])
                    % subplot(2,1,2)
                    % plot(gyrosX(end-window:end))
                    % plot(gyrosY(end-window:end)) % Won't plot more than 1
                    % channel...
                    %
                    % plot(gyrosZ(end-window:end)) %
                    j  = j+1;


                end
                % The plot will not show up with
                % labels...
                % xlabel('Time [ms]')
                % ylabel('Rate [deg/s]')

                ylim([-100 100])
                xlim([0 2000])

            end
        end
    end

    i = i+1;

end

fclose(s)


