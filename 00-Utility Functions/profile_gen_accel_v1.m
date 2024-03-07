function [points] = profile_gen_accel_v1(Az_raw, time_raw, Vx_raw, Dz_filt_freq, road_sampling_interval, desired_distance, desired_width, initialization_distance, phase_distance)
%   Title: profile_gen_accel_v1.m
%   Author: S. Krug
%   Date: 12/8/17
%   Notes:
%   - added tire TF
%   - added plots for ISO 8608 correlation
% 

%% Inputs
% Az_raw - m/s^2
% time_raw - s
% Vx - m/s
% Dz_filt_freq - high pass frequency, hz
% road_sampling_interval - m
% desired_distance - m
% desired_width - m
% initialization_distance - m
% phase_distance - L/R offset of hub accelerometer signal for phasing, m

%% Outputs
% x - Longitudinal (length), rows, (1,:), Dymola Tabular
% y - Lateral (width), columns, (:,1), Dymola Tabular
% z - Vertical (height), (2,:), Dymola Tabular
% z_map - map of road for CRG's

%% Change time series to 50Hz, so displacement conversion array isn't too large
ts_raw = time_raw(2)-time_raw(1); %s
fs_raw = 1/ts_raw; %hz
fs = 50; %hz
try
    time = linspace(0, time_raw(length(time_raw)), round(length(time_raw)*(fs/fs_raw)))';
    ts = time(2)-time(1);
    
    Az = TSseries(Az_raw, time_raw);
    Az = Az.resample(time);
    Vx = TSseries(Vx_raw, time_raw);
    Vx = Vx.resample(time);
    
    %% Convert to displacement using frequency domain
    [Az_f, ws_f] = fft_easy(Az.Data, time);
    Dz_f = diag(-ws_f.^-2)*Az_f;
    Dz_f(ws_f<Dz_filt_freq*2*pi,:) = 0;
    [Dz_raw, ~] = ifft_easy(Dz_f, ws_f);
    %% Tire transfer function
    mu = 42;
    kt = 380000;
    ct = 1200;
    zu = Dz_raw;
    t = time;
    
    road = sdof_tire_v1(mu,kt,ct,zu,t);
    
    figure(5)
    subplot(2,1,1)
    title('Road Profile, After Tire Transfer Function');
    semilogy(road.freq, road.zr_f, road.freq, road.zu_f, road.freq, road.xf)
    legend('Input, Road','Output, Hub',  'Tire Transfer Function');
    xlabel('Frequency [Hz]')
    ylabel('FFT Amplitude')
    xlim([0 50])
    ylim([10^-4 10^2])
    Plotter(1);
 
    %% Take desired distance from data
    % decimated_road_height = road_height.Data(road_indices);
    distance = cumtrapz(Vx.Data)*ts; %integration of Vx for distance
    TS_Dz = TSseries(road.zr, time);
    distance_indices = find(distance <= desired_distance);
    Dz = TS_Dz.Data(distance_indices);
    TS_distance = TSseries(distance, time);
    distance_decimated = TS_distance.Data(distance_indices);
    
    subplot(2,1,2)
    plot(distance, road.zr, distance, road.zu)
    legend('Tire Contact Patch Position', 'Hub Position')
    xlabel('Distance [m]')
    ylabel('Displacement [m]')
    Plotter(1);
    %% PSD Comparison to IRI Roads
    figure(6)
    hold on
    for j = 3:9
        
        [n_max(j), n_eff(j), Delta_n(j), N(j), Road{j}] = ISO_profile_generator_v0(road_sampling_interval, round(distance(end)), 1/round(distance(end)), 1/road_sampling_interval, j, 0);
        %% Time series of generated road
        x = Road{1,j}(1,:);
        h = Road{1,j}(2,:);
        %% PSD of generated road
        [ws, psd_xt, ~] = psd_v0(x, h);
        
        hold on
        subplot(2,1,1)
        plot(x, h);
        xlabel('Distance [m]')
        ylabel('Elevation [m]')
        title('ISO 8608 Road Profile Classification')
        hold on
        
        subplot(2,1,2)
        loglog(ws, psd_xt)
        xlim([0 1])
        ylim([10^-10 10])
        xlabel('Wavenumber [Cycle/m]')
        ylabel('Power Spectral Density Amplitude m^2/[cycle/m]')
        
    end
    
    [ws_road, psd_xt_road, ~] = psd_v0(distance, road.zr);
    hold on
    subplot(2,1,1)
    plot(distance, road.zr,'k')
    grid on
    hold on
    subplot(2,1,2)
    loglog(ws_road, psd_xt_road,'k');
    Plotter(1);
    ylim([10^-10 10])
    
    legend('Road Class ISO 8608 A-B: k = 3',...
        'Road Class ISO 8608 B-C: k = 4',...
        'Road Class ISO 8608 C-D: k = 5',...
        'Road Class ISO 8608 D-E: k = 6',...
        'Road Class ISO 8608 E-F: k = 7',...
        'Road Class ISO 8608 F-G: k = 8',...
        'Road Class ISO 8608 G-H: k = 9',...
        'Generated Road PSD');
    
    hold off
    
    
    %% Create road x, y, z outputs
    % x - Longitudinal (length), rows, (1,:)
    % y - Lateral (width), columns, (:,1)
    % z - Vertical (height), (2,:)
    distance_inc = distance_decimated(2)-distance_decimated(1);
    left_road = Dz;
    final_height_left = left_road';
    phase_distance_ind = round(phase_distance/distance_inc);
    right_road = circshift(Dz,phase_distance_ind);
    final_height_right = right_road';
    nv = desired_width; %width, m
    vinc = road_sampling_interval;
    final_height_combined_decimated = [final_height_left; final_height_right];
    
    % Create map
    z_map = zeros(nv*(1/road_sampling_interval), length(Dz));
    z_map(1:nv*(1/road_sampling_interval)/2,:) = repmat(final_height_combined_decimated(1,:), [(nv/vinc)/2, 1]);
    z_map((nv*(1/road_sampling_interval)/2)+1:nv*(1/road_sampling_interval),:) = repmat(final_height_combined_decimated(2,:), [(nv/vinc)/2, 1]);
    z = [zeros(nv*(1/road_sampling_interval), initialization_distance/road_sampling_interval) z_map];
    z(:, 1:initialization_distance/road_sampling_interval) = (z_map(length(z_map(:,1))/2) + z_map((length(z_map(:,1))/2)+1))/2;
    initialization = linspace((z_map(length(z_map(:,1))/2) + z_map((length(z_map(:,1))/2)+1))/2,...
        (z_map(length(z_map(:,1))/2) + z_map((length(z_map(:,1))/2)+1))/2,...
        initialization_distance/road_sampling_interval);
    z_l_r(1,:) = [initialization left_road'];
    z_l_r(2,:) = [initialization right_road'];
    points.x = linspace(0, length(z_map(:,2))/road_sampling_interval, length(z_map(:,2))); % Distance, m
    points.y = linspace(0, desired_width, length(z_map(:,1))); % Width, m
    points.z = z_l_r; % Height, m
    points.z_map = z;
catch
    disp('Error: Array size is too large for conversion to displacement or a different error occured');
    points = 'Error: Array size is too large for conversion to displacement or a different error occured';
end
end