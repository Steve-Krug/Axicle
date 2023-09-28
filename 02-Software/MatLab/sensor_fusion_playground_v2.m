clear all
load 'C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Test 7'

% Relevant indices
time_idx =1; % s
pitch_idx = 4; % deg
roll_idx = 5; % deg
yaw_idx = 6; % deg
Ax_idx = 7; % Gs
Ay_idx = 8; % Gs
Az_idx = 9; % Gs

run_idx = 180; % 180 is a good rollover


%for i=1:1000
    %run_idx = i;
single_run_data = table2array(data{run_idx});

time = single_run_data(:, time_idx);
roll = single_run_data(:, roll_idx);
pitch = single_run_data(:, pitch_idx);
yaw = single_run_data(:, yaw_idx);
Ax = single_run_data(:, Ax_idx);
Ay_raw = single_run_data(:, Ay_idx);
Az_raw = single_run_data(:, Az_idx);
Ay = single_run_data(:, Ay_idx) - 1*sind(roll); % Add gravity effect
Az = single_run_data(:, Az_idx) - 1*cosd(roll); % Add gravity effect

accel_angle = unwrap(atan2(Ay, Az) + pi) * 180/pi;
    % max_roll(i) = max(abs(roll));
    % max_pitch(i) = max(abs(pitch));
    % max_yaw(i) = max(abs(yaw));
%end

dt = mean(gradient(time));
tau_s = 100; % Time constant, seconds, needs to be long enough to filter out any aggressive lateral acceleration maneuvers
alpha = 1 - exp(-dt/tau_s); % Alpha for 1st order filter


% Filter loops
roll_filt = zeros(size(roll));
accel_angle_filt=zeros(size(accel_angle));
roll_filt(1) = roll(1);
accel_angle_filt(1) = accel_angle(1);
for i=2:length(time)
    roll_filt(i) = roll_filt(i-1) * (1-alpha) + roll(i) * alpha;
    accel_angle_filt(i) = accel_angle_filt(i-1) * (1-alpha) + accel_angle(i) * alpha;
end
roll_filt_hp = roll - roll_filt; % LPF + HPF = 1, HPF = 1 - LPF

roll_complementary = accel_angle_filt + roll_filt_hp; % Combine accel and roll angles

% figure
% plot(time,Ax,time,Ay,time,Az)
% legend('X','Y','Z')
% 
% figure
% plot(time,pitch,time,roll,time,yaw)
% legend('Pitch','Roll','Yaw')


figure
plot(time,roll, time, accel_angle, time, roll_complementary)
xlabel('Time')
ylabel('Roll [deg]')
legend('True Roll','Inferred Roll from Accel','Filtered Roll')
grid on

