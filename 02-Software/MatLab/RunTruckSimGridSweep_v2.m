%% RunTruckSimGridSweep_v2.m
% 5/31/23
% S. Krug
% Notes:
%
%
%

clc
clear
close all

%% Pack Runs

% MASSPAYLOAD = 15000; %kg
% ZCGPAYLOAD = 1500; %mm
% SPEEDTARGETCONSTANT = 45; %kph

factor_one_steps =2;
factor_two_steps = 2;
factor_three_steps = 2;
qty_of_factors = 2;

masspayload_increments = factor_one_steps; %qty. of steps
masspayload_high_kg = 18142; %kg
masspayload_low_kg = 100; %kg
MASSPAYLOAD = linspace(masspayload_low_kg, masspayload_high_kg, masspayload_increments);

zcgpayload_increments = factor_two_steps; %qty. of steps
zcgpayload_high_mm = 2500; %mm
zcgpayload_low_mm = 1250; %mm
ZCGPAYLOAD = linspace(zcgpayload_low_mm, zcgpayload_high_mm, zcgpayload_increments);

vx_increments = factor_three_steps; %qty. of steps
vx_high_kph = 100; %kph
vx_low_kph = 30; %kph
SPEEDTARGETCONSTANT = linspace(vx_low_kph, vx_high_kph, vx_increments);



run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD,SPEEDTARGETCONSTANT);
% run_input_array = allcomb(MASSPAYLOAD,ZCGPAYLOAD);
total_runs = length(run_input_array);

%% Run Sims
% hbar = parfor_progressbar(total_runs,'Computing...');
% parfor (i = 1:total_runs,12)  %20 logical processors, 12 cores on SKRUG machine

% simIn(1:length(run_input_array)) = Simulink.Simulation('batch_iteration_SWD_SL');
% f = waitbar(0,'Progress...');
for i = 1:total_runs
% Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl

    MASSPAYLOAD = run_input_array(i,1);

    ZCGPAYLOAD= run_input_array(i,2);

    SPEEDTARGETCONSTANT = run_input_array(i,3);

    block1 = getfullname(Simulink.findBlocks('batch_iteration_SWD_FMU'));
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
    % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
    % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');
    
    
    set_param(block1{1,1}, 'Value', 'MASSPAYLOAD');
    set_param(block1{2,1}, 'Value', 'ZCGPAYLOAD');
    set_param(block1{3,1}, 'Value', 'SPEEDTARGETCONSTANT');
    
    sim('batch_iteration_SWD_FMU');

    waitbar(i/total_runs)
    
end


