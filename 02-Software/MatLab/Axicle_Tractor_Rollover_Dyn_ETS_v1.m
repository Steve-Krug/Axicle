%% Axicle_Tractor_Rollover_Dyn_ETS_v1.m
% 7/15/21
% S. Krug
% Notes:
%
% 7/15/21 - Initial start
%

clear all
close all
clc
%% Time Series Parameters
sampling_freq_hz = 100; %hz
time_step_s = 1/sampling_freq_hz; % s
total_run_time_s = 6; % sec
time_s = linspace(0, total_run_time_s, sampling_freq_hz*total_run_time_s)';

%% Mass Properties
g_mps2 = 9.81;

%Tractor
TRAC_height_cg_m = 1.1;
TRAC_mass_kg = 6917;
TRAC_inertia_roll_kgm2 = 37500;
TRAC_trackwidth_m = 2.53;
TRAC_height_cp_m = 1.925;
TRAC_force_drag_N = 45000;
TRAC_force_weight_N = g_mps2*TRAC_mass_kg;

%Trailer
TRAIL_height_cg_m = 1.1;
TRAIL_mass_kg = 6917;
TRAIL_inertia_roll_kgm2 = 37500;
TRAIL_trackwidth_m = 2.53;
TRAIL_height_cp_m = 1.925;
TRAIL_force_drag_N = 122000;
TRAIL_force_weight_N = g_mps2*TRAIL_mass_kg;

%% Variables & Inputs
%Tractor
TRAC_d_cg_y_m_i = TRAC_height_cg_m;
TRAC_d_cg_x_m_i = TRAC_trackwidth_m/2;
TRAC_theta_cg_rad_i = atan(TRAC_d_cg_x_m_i/TRAC_d_cg_y_m_i);


TRAC_d_cp_y_m_i = TRAC_height_cp_m;
TRAC_d_cp_x_m_i = TRAC_trackwidth_m/2;
TRAC_theta_cp_rad_i = atan(TRAC_d_cp_x_m_i/TRAC_d_cp_y_m_i);

%Trailer
TRAIL_d_cg_y_m_i = TRAIL_height_cg_m;
TRAIL_d_cg_x_m_i = TRAIL_trackwidth_m/2;
TRAIL_theta_cg_rad_i = atan(TRAIL_d_cg_x_m_i/TRAIL_d_cg_y_m_i);


TRAIL_d_cp_y_m_i = TRAIL_height_cp_m;
TRAIL_d_cp_x_m_i = TRAIL_trackwidth_m/2;
TRAIL_theta_cp_rad_i = atan(TRAIL_d_cp_x_m_i/TRAIL_d_cp_y_m_i);

%Inertias
TRAC_r_cg_m = TRAC_d_cg_x_m_i/(sin(TRAC_theta_cg_rad_i));
TRAC_I_pat_kgm2 = TRAC_inertia_roll_kgm2 + TRAC_mass_kg*TRAC_r_cg_m^2; %use this inertia

TRAIL_r_cg_m = TRAC_d_cg_x_m_i/(sin(TRAC_theta_cg_rad_i));
TRAIL_I_pat_kgm2 = TRAIL_inertia_roll_kgm2 + TRAIL_mass_kg*TRAIL_r_cg_m^2; %use this inertia
%Radii to calculate d_cg_x_m and d_cp_y_m during dynamic motion
TRAC_r_cp_m = TRAC_d_cp_x_m_i/(sin(TRAC_theta_cp_rad_i));
TRAIL_r_cp_m = TRAIL_d_cp_x_m_i/(sin(TRAIL_theta_cp_rad_i));

%% Time Domain Dynamics
% Trailer initiates rollover motion typically, so calculate that one first,
% then that inertia/energy addds to tractor, which already had 'some' force
% on it from original aerodynamics

% Calculate new angle instance
% if XXXX_tq_nm <0, no tip acceleration

%calculate angles for cp and cg, then calculate global "reference" angle,
%i.e. trailer/trac angles


%initialize vars
TRAC_tq_nm = zeros(length(time_s),1);
TRAC_d_cg_x_m = zeros(length(time_s),1);
TRAC_d_cp_y_m = zeros(length(time_s),1);
TRAC_alpha_rps2 = zeros(length(time_s),1);
TRAC_omega_rps = zeros(length(time_s),1);
TRAC_theta_cg_rad = zeros(length(time_s),1);
TRAC_theta_cp_rad = zeros(length(time_s),1);
TRAC_theta_cg_rad(1) = TRAC_theta_cg_rad_i; %first angle is static angle
TRAC_theta_cp_rad(1) = TRAC_theta_cp_rad_i; %first angle is static angle
TRAC_roll_angle_rad = zeros(length(time_s),1);
TRAC_roll_angle_rad(1) = 0; %first angle is static angle

for t = 1:length(time_s)-1
    
    dt = time_s(t+1) - time_s(t);
    
    if t == 1
        TRAC_tq_nm(t) = ((TRAC_force_drag_N*TRAC_d_cp_y_m_i)-(TRAC_force_weight_N*TRAC_d_cg_x_m_i));
        %TRAC_tq_nm(t) = 0;
    else
        TRAC_d_cg_x_m(t) = sin(TRAC_theta_cg_rad(t))*TRAC_r_cg_m; %new moment arm for new cg torque
        TRAC_d_cp_y_m(t) = cos(TRAC_theta_cp_rad(t))*TRAC_r_cp_m; %new moment arm for cp torque
        TRAC_tq_nm(t) = (TRAC_force_drag_N*TRAC_d_cp_y_m(t))-(TRAC_force_weight_N*TRAC_d_cg_x_m(t));
    end
    
    %check if tq is negative, reset to zero tq for acceleration
    if TRAC_tq_nm(t) < 0
        TRAC_tq_nm(t) = 0;
    end
    
    %Angular Acceleration
    TRAC_alpha_rps2(t+1) = TRAC_tq_nm(t)/TRAC_I_pat_kgm2;
    %Angular Rate
    TRAC_omega_rps(t+1) = TRAC_omega_rps(t)+TRAC_alpha_rps2(t+1)*dt;
    %Angle Change
   
%     TRAC_theta_cg_rad(t+1) = TRAC_theta_cg_rad(t)+TRAC_omega_rps(t+1)*dt;
%     TRAC_theta_cp_rad(t+1) = TRAC_theta_cp_rad(t)+TRAC_omega_rps(t+1)*dt;

    %Resolved roll angle assuming start = 0deg
    TRAC_roll_angle_rad(t+1) = TRAC_roll_angle_rad(t)+TRAC_omega_rps(t+1)*dt;
    %new angles?
    TRAC_theta_cg_rad(t+1) = TRAC_theta_cg_rad(1) - TRAC_roll_angle_rad(t+1); %angles are decreasing..?
    TRAC_theta_cp_rad(t+1) = TRAC_theta_cp_rad(1) - TRAC_roll_angle_rad(t+1); %angles are decreasing..?
    
    if (TRAC_roll_angle_rad(t+1)*57.29) > 90
        break
    end
    
end

figure(1)
plot(time_s,TRAC_roll_angle_rad*57.29)
Plotter(1)
% figure(5)
% plot(time_s,TRAC_force_drag_N*TRAC_d_cp_y_m, time_s, -TRAC_force_weight_N*TRAC_d_cg_x_m)
% legend({'aero moment','weight moment'})
figure(5)
plot(time_s,TRAC_d_cp_y_m, time_s, TRAC_d_cg_x_m)
legend({'cp vertical moment arm','cg lateral moment arm'})

figure(2)
plot(time_s, TRAC_tq_nm)
legend({'net torque'})
Plotter(1)

figure(6)
plot(time_s,TRAC_force_drag_N*TRAC_d_cp_y_m-TRAC_force_weight_N*TRAC_d_cg_x_m)
legend({'net torque, calc"d'})
Plotter(1)

% figure(3)
% plot(time_s, TRAC_d_cp_y_m)
% Plotter(1)
% 
% figure(4)
% plot(time_s, TRAC_d_cg_x_m)
% Plotter(1)



% new angles after acceleration
%TRAC_d_cg_y_m_i = TRAC_height_cg_m;
%TRAC_d_cg_x_m_i = TRAC_trackwidth_m/2;
%TRAC_theta_cg_deg_i = arctan(TRAC_d_cg_x_m_i/TRAC_d_cg_y_m_i);


%TRAC_d_cp_y_m_i = TRAC_height_cp_m;
%TRAC_d_cp_x_m_i = TRAC_trackwidth_m/2;
%TRAC_theta_cp_deg_i = arctan(TRAC_d_cp_x_m_i/TRAC_d_cp_y_m_i);

% end for loop

