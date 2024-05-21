%% SimAutomation_v1
% 3/28/24
% S. Krug
% Notes:
%
%
%

clc
clear
close all

%% Pack Runs

factor_one_steps = 1;
factor_two_steps = 1;
factor_three_steps = 1;
factor_four_steps = 1;

% MASSPAYLOAD_increments = factor_one_steps; %qty. of steps
MASSPAYLOAD_high_kg = 0; %kg
MASSPAYLOAD_low_kg = 11000; %kg
MASSPAYLOAD = (MASSPAYLOAD_high_kg - MASSPAYLOAD_low_kg).*rand(factor_one_steps,1) +  MASSPAYLOAD_low_kg;
% MASSPAYLOAD = linspace(masspayload_low_kg, masspayload_high_kg, masspayload_increments);

% zcgpayload_increments = factor_two_steps; %qty. of steps
ZCGPAYLOAD_high_m = 2.5; %m %it's parsed as mm in sim, but put m here low: 1.527
ZCGPAYLOAD_low_m = 1.4; %m
ZCGPAYLOAD = (ZCGPAYLOAD_high_m - ZCGPAYLOAD_low_m).*rand(factor_two_steps,1) + ZCGPAYLOAD_low_m;

% ZCGPAYLOAD = linspace(zcgpayload_low_m, zcgpayload_high_m, zcgpayload_increments);


% LXCGPAYLOAD_increments = factor_three_steps;
LXCGPAYLOAD_high_m = 14.0; %m %100kph is the normal windspeed input
LXCGPAYLOAD_low_m = 1.0; %m
LXCGPAYLOAD = (LXCGPAYLOAD_high_m - LXCGPAYLOAD_low_m).*rand(factor_three_steps,1) + LXCGPAYLOAD_low_m;
% LXCGPAYLOAD = linspace(LXCGPAYLOAD_low_m, LXCGPAYLOAD_high_m, LXCGPAYLOAD_increments);

time = linspace(0, 10, 100);
angle = time*10;
steering = [time; angle;]';



vx_increments = factor_four_steps; %qty. of steps
vx_high_kph = 120; %kph
vx_low_kph = 120; %kph
SPEEDTARGETCONSTANT = linspace(vx_low_kph, vx_high_kph, vx_increments);


run_input_array = allcomb(MASSPAYLOAD, ZCGPAYLOAD, LXCGPAYLOAD, SPEEDTARGETCONSTANT);
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
    
    LXCGPAYLOAD = run_input_array(i,3); %LX_CG_PL

    STEER_SW = steering;

    SPEED = run_input_array(i,4);

    
    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL'));
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
    % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
    % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');
    
    
    set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
    set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');   
    set_param(block1{3,1}, 'Value', 'LXCGPAYLOAD');
    set_param(block1{4,1}, 'Value', 'STEER_SW');
    set_param(block1{5,1}, 'Value', 'SPEED');

 
    

    % set_param(block1{5,1}, 'Value', 'SPEED');
    % 
    sim('batch_iteration_SWD_SL');
    % close_system('batch_iteration_SWD_SL')
    waitbar(i/total_runs)
    pause(.75)
    
end


