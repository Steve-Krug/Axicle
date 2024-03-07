% SerialPortAnalyzer_v1.m
% 12/28/23
% S. Krug
% Notes:
clear
clc
close all


s = serialport("COM5", 921600);


time = 0;
i = 1;
j = 1;
window = 1000;

while(1)

    data_parse1{i,1} = fscanf(s);

    % seconds(i) = str2double(time_parse1{i,1}(13:14))*3600 + str2double(time_parse1{i,1}(16:17))*60 + str2double(time_parse1{i,1}(19:24));

    if strlength(data_parse1(i,1))  > 62 % this seems to be ignored also

        gyro_reg{i,1} = data_parse1{i,1}(24:37); %unsigned integer64


        if ~isempty(gyro_reg{i,1}) % if cell is not empty, be true (1). This doesn't work
            dps = 2000;
            gyros(i,:) = (parse_int16_v1(gyro_reg{i,1})*dps)/32678;

            if abs(gyros(i,1)) > 0
                gyrosX(j) = gyros(i,1);
                
            end

            % if gyros(i,1) ~= 0
            %     plot(i, gyros(i,1), 'r')
            %     % ylim([-10 10])
            %     % xlim([0 1000])
            % end
            if abs(gyros(i,1)) > 0 % this also isn't working for some reason
                if j <= window
                    % plot(gyros(:,1)) %
                    plot(gyrosX(:)) %
                    j  = j+1;
                    
                else
                    % plot(gyros(end-window:end,1)) %
                    plot(gyrosX(end-window:end)) %
                    j  = j+1;

                end
                ylim([-100 100])
                xlim([0 2000])
            end
        end
    end
    % status_reg(i) = str2double(data_parse1{i,1}(7:10));

    % gyro_reg{i,1} = data_parse1{i,1}(24:37); %unsigned integer64
    % dps = 2000;
    % gyros(i,:) = (parse_int16_v1(gyro_reg{i,1})*dps)/32678;

    % set(s, 'Parity', 'none');
    % set(s, 'DataBits', 8);
    % set(s, 'StopBit', 1);
    % readline(s)
    %open serial port
    % fopen(s)
    % a = fscanf(s);
    % data{count} = readline(s);

    % pause(0.00001) %with any pause at all, the plot becomes very lagged.
    % time = time + 0.005;
    i = i+1;

end

fclose(s)


