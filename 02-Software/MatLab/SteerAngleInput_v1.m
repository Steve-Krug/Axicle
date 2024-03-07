%% SteerAngleInput_v1.m
% 4/20/23
% S. Krug
% Notes:
%
% 
%

close
clc
clear all
% Set parameters
fs = 100; % Sampling frequency (Hz)
total_time = 7; %(sec)
t = 0:1/fs:total_time; % Time vector (seconds)
f = .7; % Sine wave frequency (Hz)
A = 180; % Sine wave amplitude (steering angle
dwell_time = 3/4 * (1/f); % Dwell time (seconds)
dwell_length = 3; % (second)
dwell_time_end1 = 3/4 * (1/f);
dwell_time_end2 = 1 * (1/f);

% Create sine wave
sine_wave = A * sin(2*pi*f*t);

% Segment end of sine wave
end_wave_index_start = length(find(t<dwell_time_end1));
diff = length(find(t<dwell_time_end2)) - length(find(t<dwell_time_end1));
end_wave_index_end = end_wave_index_start + diff;
end_wave = sine_wave(end_wave_index_start:end_wave_index_end); %save end wave

% Add dwell
dwell_start_index = length(find(t<=dwell_time));
dwell_end_index = dwell_start_index + dwell_length*fs;
% dwell_start = round((length(t)/2) - (dwell_time/2 * fs));
% dwell_end = round((length(t)/2) + (dwell_time/2 * fs));
sine_wave(dwell_start_index:dwell_end_index) = -A;
sine_wave(dwell_end_index:dwell_end_index+diff) = end_wave;
sine_wave(dwell_end_index+diff:end) = 0;

time_shift = .5; % (second)
sine_wave_final = circshift(sine_wave, fs*time_shift);

% Plot sine wave
plot(t, sine_wave_final);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Sine Wave with Dwell');
Plotter(1)

signal(:,1) = t;
signal(:,2) = sine_wave_final;