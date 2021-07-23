%% dynamics_test_v1.m
% 7/122/21
% S. Krug
% Notes:
clear all
close all
clc

v_mph = linspace(67.5,70, 20);
for i = 1:length(v_mph)
    
    [tlr_theta, tlr_omega,  tcr_theta, tcr_omega, time_s]= Axicle_Tractor_Rollover_Dyn_ETS_FUNCTION_v1(v_mph(i));
    
    hold on
    figure(4)
    scatter(tcr_theta*57.29,tcr_omega*57.29,'LineWidth',5)
    xlabel('Tractor Roll Angle [deg]')
    ylabel('Tractor Roll Rate [deg/s]')
    Plotter(1)
    hold on
    
    figure(1)
    title('Tractor Roll Angle, 2deg slack, 67-70mph Wind Sweep')
    scatter(time_s,tcr_theta*57.29,'*')
    %legend({'Tractor Roll Angle'})
    ylabel('Angle [deg]')
    xlabel('Time [s]')
    ylim([0 10])
    xlim([0 5])
    Plotter(1)
    hold on
    
end

