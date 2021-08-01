% Tractor_only_rollover_test_v1.m
clear
clc
close all
iterations = 500000;
% v_mph = 60;
% start_roll_angle_deg = 15;
% start_roll_rate_dps = 20;
% TRAC_height_cp_m =  1.925;
% TRAC_trackwidth_m = 2.53;
% TRAC_inertia_roll_kgm2 = 37500;
% TRAC_mass_kg = 6970;
% TRAC_height_cg_m = 1.1;
start_roll_angle_deg = zeros(iterations,1);
start_roll_rate_dps = zeros(iterations,1);
TRAC_height_cg_m = zeros(iterations,1);
TRAC_mass_kg = zeros(iterations,1);
TRAC_trackwidth_m = zeros(iterations,1);
TRAC_height_cp_m = zeros(iterations,1);
TRAC_inertia_roll_kgm2 = zeros(iterations,1);
roll_results = zeros(iterations,1);

for i = 1:length(start_roll_angle_deg)
    
    v_mph = 80; %%99.9999% trailers initiate roll over at or before 80mph
    start_roll_angle_deg(i) = randi([10 500])/10;
    start_roll_rate_dps(i) = randi([10 1000])/10;
    TRAC_height_cg_m(i) = (randi([75 200])/100);
    TRAC_mass_kg(i) = randi([5900 9000]);
    TRAC_inertia_roll_kgm2(i) = randi([20000 50000]);
    TRAC_trackwidth_m(i) = 2.53;
    TRAC_height_cp_m(i) = randi([125 275])/100;
    

    [time_s, TRAC_roll_angle_rad] = Axicle_Tractor_RolloverOnly_Dyn_ETS_FUNCTION_v2(...
        v_mph, start_roll_angle_deg(i), start_roll_rate_dps(i),...
        TRAC_height_cp_m(i), TRAC_trackwidth_m(i), TRAC_inertia_roll_kgm2(i), TRAC_mass_kg(i), TRAC_height_cg_m(i));
    
    if TRAC_roll_angle_rad(TRAC_roll_angle_rad*57.29 > 85)
        roll_results(i) = 1; %rollover
    else
        roll_results(i) = 0; %no rollover
    end

%     hold on
%     figure(1)
%     plot(time_s, TRAC_roll_angle_rad*57.29,'LineWidth',1);
%     xlabel('Time [s]')
%     ylabel('Roll Angle [deg]')
%     title('Tractor Roll Angle')
%     Plotter(1);
%     hold on
    
end

figure(3)
hold on
dotsize = 1;  %adjust as needed
scatter3( start_roll_angle_deg, start_roll_rate_dps, roll_results, dotsize, roll_results, 'Filled');

legend({'Tractor Rollovers, n = 500,000'})

xlabel('Roll Angle Trigger, deg')
ylabel('Roll Rate Trigger, deg/s')
title('Roll Rate and Angle Release Trigger Monte Carlo')
% ylim([0 34])
Plotter(1);


