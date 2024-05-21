%% SimAutomation_MonteCarlo_FFT_v1.m
% 4/05/24
% S. Krug
% Notes:
%
%
%

clc
clear
close all

%% Pack Runs
num_runs = 500;

for j = 1:num_runs

    MASSPAYLOAD_high_kg = 0; %kg
    MASSPAYLOAD_low_kg = 10000; %kg
    MASSPAYLOAD(j) = (MASSPAYLOAD_high_kg - MASSPAYLOAD_low_kg).*rand(1,1) +  MASSPAYLOAD_low_kg;


    ZCGPAYLOAD_high_m = 2.4; %m %it's parsed as mm in sim, but put m here low: 1.527
    ZCGPAYLOAD_low_m = 1.4; %m
    ZCGPAYLOAD(j) = (ZCGPAYLOAD_high_m - ZCGPAYLOAD_low_m).*rand(1,1) + ZCGPAYLOAD_low_m;

    LXCGPAYLOAD_high_m = 11.5; %m %100kph is the normal windspeed input
    LXCGPAYLOAD_low_m = 1.0; %m
    LXCGPAYLOAD(j) = (LXCGPAYLOAD_high_m - LXCGPAYLOAD_low_m).*rand(1,1) + LXCGPAYLOAD_low_m;

    % SPEEDTARGETCONSTANT_high_kph = 90; %kph
    % SPEEDTARGETCONSTANT_low_kph = 60; %kph
    % SPEEDTARGETCONSTANT(j) = (SPEEDTARGETCONSTANT_high_kph - SPEEDTARGETCONSTANT_low_kph).*rand(1,1) + SPEEDTARGETCONSTANT_low_kph;

    % Current road: C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Scene_Import\gps_2018_grapevine.vsscene
    max_Roaddistance_m = 13760;
    segment_length_m = 5000;
    SSTART_high_m = max_Roaddistance_m-segment_length_m;
    SSTART_low_m = 0;
    SSTART(j) = (SSTART_high_m - SSTART_low_m).*rand(1,1) + SSTART_low_m;
    SSTOP(j) = SSTART(j) + segment_length_m;

end

run_input_array = [MASSPAYLOAD; ZCGPAYLOAD; LXCGPAYLOAD;]';
run_input_table = array2table(run_input_array, 'VariableNames', {'MASS PAYLOAD KG', 'ZCGPAYLOAD METERS', 'LXCGPAYLOAD METERS'});


%% Run Sims
% hbar = parfor_progressbar(total_runs,'Computing...');
% parfor (i = 1:total_runs,12)  %20 logical processors, 12 cores on SKRUG machine
% simIn(1:length(run_input_array)) = Simulink.Simulation('batch_iteration_SWD_SL');
% f = waitbar(0,'Progress...');
% open_system('batch_iteration_SWD_SL')

for i = 1:num_runs

    MASSPAYLOAD = run_input_array(i,1);
    ZCGPAYLOAD = run_input_array(i,2);
    LXCGPAYLOAD = run_input_array(i,3);
    % SPEED = run_input_array(i,4);
    SSTART_sim = SSTART(i);
    SSTOP_sim = SSTOP(i);

    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL_RoadRandomization'));

    set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
    set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
    set_param(block1{3,1}, 'Value', 'LXCGPAYLOAD');
    % set_param(block1{4,1}, 'Value', 'SPEED');
    set_param(block1{4,1}, 'Value', 'SSTART_sim');
    set_param(block1{5,1}, 'Value', 'SSTOP_sim');
    sim('batch_iteration_SWD_SL_RoadRandomization');

    waitbar(i/num_runs)
    pause(1.5)

    folder_path = "C:\Users\SteveKrug\Documents\TruckSim\05-Trucksim_DesktopDatabase\Results\Run_3e88d285-e1b2-43c4-9d5b-a8949b0afe7e";
    files = dir(fullfile(folder_path, '*.mat'));
    filename = fullfile(folder_path, files(end).name);
    load(filename(end), "-mat");

    ts = Time(2) - Time(1);
    fs = 1/ts;

    Time_indices = find(Time > 0 & Time < 180); %take first 180sec of run.
    Ax_S1_seg = Ax_S1(Time_indices);
    Ay_S1_seg = Ay_S1(Time_indices);
    Az_S1_seg = Az_S1(Time_indices);
    AVx_S1_seg = AVx_S1(Time_indices);
    AVy_S1_seg = AVy_S1(Time_indices);
    AVz_S1_seg = AVz_S1(Time_indices);

    Ax_S2_seg = Ax_S2(Time_indices);
    Ay_S2_seg = Ay_S2(Time_indices);
    Az_S2_seg = Az_S2(Time_indices);
    AVx_S2_seg = AVx_S2(Time_indices);
    AVy_S2_seg = AVy_S2(Time_indices);
    AVz_S2_seg = AVz_S2(Time_indices);

    Ax_S5_seg = Ax_S5(Time_indices);
    Ay_S5_seg = Ay_S5(Time_indices);
    Az_S5_seg = Az_S5(Time_indices);
    AVx_S5_seg = AVx_S5(Time_indices);
    AVy_S5_seg = AVy_S5(Time_indices);
    AVz_S5_seg = AVz_S5(Time_indices);

    % Data Columns:
    % 1 Freq);
    % 2 Ax_S1);
    % 3 Ay_S1);
    % 4 Az_S1);
    % 5 AVx_S1);
    % 6 AVy_S1);
    % 7 AVz_S1);
    % 8 Ax_S2);
    % 9 Ay_S2);
    % 10 Az_S2);
    % 11 AVx_S2);
    % 12 AVy_S2);
    % 13 AVz_S2);
    % 14 Ax_S5);
    % 15 Ay_S5);
    % 16 Az_S5);
    % 17 AVx_S5);
    % 18 AVy_S5);
    % 19 AVz_S5);

    % [data(i,:,1), data(i,:,2) , ~] = fft_lite_v2(fs, Ax_S1_seg);
    % [~, data(i,:,3), ~] = fft_lite_v2(fs, Ay_S1_seg);
    % [~, data(i,:,4), ~] = fft_lite_v2(fs, Az_S1_seg);
    % [~, data(i,:,5), ~] = fft_lite_v2(fs, AVx_S1_seg);
    % [~, data(i,:,6), ~] = fft_lite_v2(fs, AVy_S1_seg);
    % [~, data(i,:,7), ~] = fft_lite_v2(fs, AVz_S1_seg);
    % 
    % [~, data(i,:,8), ~] = fft_lite_v2(fs, Ax_S2_seg);
    % [~, data(i,:,9), ~] = fft_lite_v2(fs, Ay_S2_seg);
    % [~, data(i,:,10), ~] = fft_lite_v2(fs, Az_S2_seg);
    % [~, data(i,:,11), ~] = fft_lite_v2(fs, AVx_S2_seg);
    % [~, data(i,:,12), ~] = fft_lite_v2(fs, AVy_S2_seg);
    % [~, data(i,:,13), ~] = fft_lite_v2(fs, AVz_S2_seg);
    % 
    % [~, data(i,:,14), ~] = fft_lite_v2(fs, Ax_S5_seg);
    % [~, data(i,:,15), ~] = fft_lite_v2(fs, Ay_S5_seg);
    % [~, data(i,:,16), ~] = fft_lite_v2(fs, Az_S5_seg);
    % [~, data(i,:,17), ~] = fft_lite_v2(fs, AVx_S5_seg);
    % [~, data(i,:,18), ~] = fft_lite_v2(fs, AVy_S5_seg);
    % [~, data(i,:,19), ~] = fft_lite_v2(fs, AVz_S5_seg);

    [data{i}(:,1), data{i}(:,2) , ~] = fft_lite_v2(fs, Ax_S1_seg);
    [~, data{i}(:,3), ~] = fft_lite_v2(fs, Ay_S1_seg);
    [~, data{i}(:,4), ~] = fft_lite_v2(fs, Az_S1_seg);
    [~, data{i}(:,5), ~] = fft_lite_v2(fs, AVx_S1_seg);
    [~, data{i}(:,6), ~] = fft_lite_v2(fs, AVy_S1_seg);
    [~, data{i}(:,7), ~] = fft_lite_v2(fs, AVz_S1_seg);

    [~, data{i}(:,8), ~] = fft_lite_v2(fs, Ax_S2_seg);
    [~, data{i}(:,9), ~] = fft_lite_v2(fs, Ay_S2_seg);
    [~, data{i}(:,10), ~] = fft_lite_v2(fs, Az_S2_seg);
    [~, data{i}(:,11), ~] = fft_lite_v2(fs, AVx_S2_seg);
    [~, data{i}(:,12), ~] = fft_lite_v2(fs, AVy_S2_seg);
    [~, data{i}(:,13), ~] = fft_lite_v2(fs, AVz_S2_seg);

    [~, data{i}(:,14), ~] = fft_lite_v2(fs, Ax_S5_seg);
    [~, data{i}(:,15), ~] = fft_lite_v2(fs, Ay_S5_seg);
    [~, data{i}(:,16), ~] = fft_lite_v2(fs, Az_S5_seg);
    [~, data{i}(:,17), ~] = fft_lite_v2(fs, AVx_S5_seg);
    [~, data{i}(:,18), ~] = fft_lite_v2(fs, AVy_S5_seg);
    [~, data{i}(:,19), ~] = fft_lite_v2(fs, AVz_S5_seg);


    filenames_all(i) = filename(end);


end


