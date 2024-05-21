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

num_runs = 1;

for j = 1:num_runs
    % MASSPAYLOAD_increments = factor_one_steps; %qty. of steps
    MASSPAYLOAD_high_kg = 0; %kg
    MASSPAYLOAD_low_kg = 10000; %kg
    MASSPAYLOAD(j) = (MASSPAYLOAD_high_kg - MASSPAYLOAD_low_kg).*rand(1,1) +  MASSPAYLOAD_low_kg;
    % MASSPAYLOAD = linspace(masspayload_low_kg, masspayload_high_kg, masspayload_increments);

    % zcgpayload_increments = factor_two_steps; %qty. of steps
    ZCGPAYLOAD_high_m = 2.4; %m %it's parsed as mm in sim, but put m here low: 1.527
    ZCGPAYLOAD_low_m = 1.4; %m
    ZCGPAYLOAD(j) = (ZCGPAYLOAD_high_m - ZCGPAYLOAD_low_m).*rand(1,1) + ZCGPAYLOAD_low_m;

    % ZCGPAYLOAD = linspace(zcgpayload_low_m, zcgpayload_high_m, zcgpayload_increments);


    % LXCGPAYLOAD_increments = factor_three_steps;
    LXCGPAYLOAD_high_m = 11.5; %m %100kph is the normal windspeed input
    LXCGPAYLOAD_low_m = 1.0; %m
    LXCGPAYLOAD(j) = (LXCGPAYLOAD_high_m - LXCGPAYLOAD_low_m).*rand(1,1) + LXCGPAYLOAD_low_m;
    % LXCGPAYLOAD = linspace(LXCGPAYLOAD_low_m, LXCGPAYLOAD_high_m, LXCGPAYLOAD_increments);


    % vx_increments = factor_four_steps; %qty. of steps
    SPEEDTARGETCONSTANT_high_kph = 70; %kph
    SPEEDTARGETCONSTANT_low_kph = 40; %kph
    SPEEDTARGETCONSTANT(j) = (SPEEDTARGETCONSTANT_high_kph - SPEEDTARGETCONSTANT_low_kph).*rand(1,1) + SPEEDTARGETCONSTANT_low_kph;
    
    % SPEEDTARGETCONSTANT(j) = linspace(vx_low_kph, vx_high_kph, vx_increments);
end

% run_input_array = allcomb(MASSPAYLOAD, ZCGPAYLOAD, LXCGPAYLOAD, SPEEDTARGETCONSTANT);
run_input_array = [MASSPAYLOAD; ZCGPAYLOAD; LXCGPAYLOAD; SPEEDTARGETCONSTANT;]';

run_input_table = array2table(run_input_array, 'VariableNames', {'MASS PAYLOAD KG', 'ZCGPAYLOAD METERS', 'LXCGPAYLOAD METERS', 'SPEEDTARGET KPH'});

% total_runs = length(run_input_array);


%% Run Sims
% hbar = parfor_progressbar(total_runs,'Computing...');
% parfor (i = 1:total_runs,12)  %20 logical processors, 12 cores on SKRUG machine

% simIn(1:length(run_input_array)) = Simulink.Simulation('batch_iteration_SWD_SL');
% f = waitbar(0,'Progress...');
% open_system('batch_iteration_SWD_SL')
for i = 1:num_runs
    % Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl

    MASSPAYLOAD = run_input_array(i,1);

    ZCGPAYLOAD = run_input_array(i,2);

    LXCGPAYLOAD = run_input_array(i,3); %LX_CG_PL

    SPEED = run_input_array(i,4);


    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_SL'));
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
    % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
    % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');


    set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
    set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
    set_param(block1{3,1}, 'Value', 'LXCGPAYLOAD');
    set_param(block1{4,1}, 'Value', 'SPEED');
    %
    sim('batch_iteration_SWD_SL');
    % close_system('batch_iteration_SWD_SL')
    waitbar(i/num_runs)
    pause(.75)

end


