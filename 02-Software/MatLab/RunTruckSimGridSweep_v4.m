%% RunTruckSimGridSweep_v3.m
% 8/31/23
% S. Krug
% Notes:
%
%
%

clc
clear
close all

%% Pack Runs

factor_one_steps = 10;
factor_two_steps = 10;
factor_three_steps = 4;
factor_four_steps = 10;

masspayload_increments = factor_one_steps; %qty. of steps
masspayload_high_kg = 25000; %kg
masspayload_low_kg = 0; %kg
MASSPAYLOAD = linspace(masspayload_low_kg, masspayload_high_kg, masspayload_increments);

zcgpayload_increments = factor_two_steps; %qty. of steps
zcgpayload_high_mm = 2.25; %m %it's parsed as mm in sim, but put m here.
zcgpayload_low_mm = 1.85; %m
ZCGPAYLOAD = linspace(zcgpayload_low_mm, zcgpayload_high_mm, zcgpayload_increments);


windspeed_increments = factor_three_steps;
windspeed_high_kph = 0.2; %kph %100kph is the normal windspeed input
windspeed_low_kph = 0; %kph
WINDSPEED = linspace(windspeed_low_kph,windspeed_high_kph, windspeed_increments);


vx_increments = factor_four_steps; %qty. of steps
vx_high_kph = 90; %kph
vx_low_kph = 70; %kph
SPEEDTARGETCONSTANT = linspace(vx_low_kph, vx_high_kph, vx_increments);




run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD, WINDSPEED, SPEEDTARGETCONSTANT);
% run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD);
total_runs = length(run_input_array);


%% Run Sims
% hbar = parfor_progressbar(total_runs,'Computing...');
% parfor (i = 1:total_runs,12)  %20 logical processors, 12 cores on SKRUG machine

% simIn(1:length(run_input_array)) = Simulink.Simulation('batch_iteration_SWD_SL');
% f = waitbar(0,'Progress...');
% open_system('batch_iteration_SWD_SL')
for i = 1:total_runs
% Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl
    
    MASSPAYLOAD = run_input_array(i,1);

    ZCGPAYLOAD = run_input_array(i,2);
    
    WIND_SPEED_GAIN = run_input_array(i,3);

    SPEED = run_input_array(i,4);

    
    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL'));
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
    % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
    % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');
    
    
    set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
    set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
    set_param(block1{3,1}, 'Value', 'WIND_SPEED_GAIN');
    set_param(block1{4,1}, 'Value', 'SPEED');
    % 
    sim('batch_iteration_SWD_SL');
    % close_system('batch_iteration_SWD_SL')
    waitbar(i/total_runs)
    pause(.75)
    
end


