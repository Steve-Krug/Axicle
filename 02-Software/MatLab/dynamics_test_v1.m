%% dynamics_test_v1.m
% 7/122/21
% S. Krug
% Notes:
clear all
close all
clc

runs = 1000;

v_mph = linspace(35,120, runs)';
TRAIL_height_cg_m = linspace(2.1-0.15*3,2.1+0.15*3, runs)'; %2.1 +- 0.15*3
v_mph_space = v_mph(2) - v_mph(1);
TRAIL_height_cg_m_space = TRAIL_height_cg_m (2) - TRAIL_height_cg_m (1);

%pack inputs (should be a "runs^2 x 2" size array
for j = 1:length(v_mph)
    input_array((j-1)*runs+1:j*runs,1) = v_mph; %vmph
    input_array((j-1)*runs+1:j*runs,2) = TRAIL_height_cg_m(j); %trail_cgheight
end

results = zeros(runs^2,3);
results(:,1:2) = input_array;

for i = 1:length(input_array)
    
    [tlr_theta, tlr_omega,  tcr_theta, tcr_omega, time_s]= Axicle_Tractor_Rollover_Dyn_ETS_FUNCTION_v2(input_array(i,1),input_array(i,2));
    
    if tcr_theta(tcr_theta*57.29 > 80)
        results(i,3) = 1; %rollover
    else
        results(i,3) = 0; %no rollover
    end
    
    
%     hold on
%     figure(1)
%     scatter(tcr_theta*57.29,tcr_omega*57.29,'LineWidth',5)
%     xlabel('Tractor Roll Angle [deg]')
%     ylabel('Tractor Roll Rate [deg/s]')
%     Plotter(1)
%     hold on
%     
%     figure(2)
%     title('Tractor Roll Angle, 2deg slack, 67-70mph Wind Sweep')
%     scatter(time_s,tcr_theta*57.29,'*')
%     
%     legend({'Tractor Roll Angle', 'Trailer Roll Angle'})
%     ylabel('Angle [deg]')
%     xlabel('Time [s]')
%     ylim([0 90])
%     xlim([0 10])
%     Plotter(1)
%     hold on
%     
    
end

%% unpack results
m = 1;
counter = 1;
spin = zeros(runs,runs);
%n is wind velocity
%m is cg height
for n = 1:length(results)
    
    if results(n,3) == 0
        spin(counter,m) = 0; %no rollover
    else
        spin(counter,m) = 1;  %rollover
    end
    
    if counter == runs
        counter = 0;
        m = m+1;
    end
    counter = counter + 1;
end

[X, Y] = meshgrid(v_mph, TRAIL_height_cg_m); %z must be a runs x runs grid with results
Z = spin';
figure(3)
title('Parameter Sweep')
contour(X,Y,Z)
ylabel('Parameter Sweep, unit')
xlabel('Wind Speed, mph')
legend({'Right Side of Curve = Rollover'})
Plotter(1);

% [px,py] = gradient(Z,v_mph_space,TRAIL_height_cg_m_space);
% figure(4)
% quiver(X,Y,px,py)
