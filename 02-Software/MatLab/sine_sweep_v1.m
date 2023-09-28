%% sine_sweep_v1.m
close
clear all
clc

% Define the chirp parameters
t_start = 0;     % start time
t_end = 5;       % end time
f_start = 0.5;   % starting frequency (Hz)
f_end = 3;      % ending frequency (Hz)
num_cycles = 50; % total number of cycles in the chirp
max_steer_angle_deg = 90; %deg
% Calculate the number of samples needed
fs = 100;                % sampling frequency (Hz)
num_samples = fs * t_end;  % total number of samples

% Create the time vector
t = linspace(t_start, t_end, num_samples);

% Calculate the instantaneous frequency as a function of time
f_inst = linspace(f_start, f_end, num_samples);

% Calculate the sine chirp
sine_chirp = max_steer_angle_deg*sin(2*pi * cumsum(f_inst) / fs);
time = linspace(0,20,length(sine_chirp));
% % Truncate the sine chirp to the desired number of cycles
% cycle_duration = 1 / f_start; % duration of one cycle at the start frequency
% num_samples_per_cycle = cycle_duration * fs; % number of samples per cycle
% num_samples_to_keep = num_cycles * num_samples_per_cycle;
% sine_chirp = sine_chirp(1:num_samples_to_keep);

% Plot the sine chirp
plot(time, sine_chirp)
xlabel('Sample Number')
ylabel('Amplitude')
title('Time')

signal(:,1) = time; 
signal(:,2) = sine_chirp;