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


%% Mass Properties
g_mps2 = 9.81;

%Tractor
TRAC_height_cg_m = 1.1;
TRAC_mass_kg = 6917;
TRAC_inertia_roll_kgm2 = 37500;
TRAC_trackwidth_m = 2.53;
TRAC_height_cp_m = 1.925;
TRAC_force_drag_N = 10000;
TRAC_force_weight_N = g_mps2*TRAC_mass_kg;

%Trailer
TRAIL_height_cg_m = 1.1;
TRAIL_mass_kg = 6917;
TRAIL_inertia_roll_kgm2 = 37500;
TRAIL_trackwidth_m = 2.53;
TRAIL_height_cp_m = 1.925;
TRAIL_force_drag_N = 10000;
TRAIL_force_weight_N = g_mps2*TRAIL_mass_kg;

%% Variables & Inputs
%Tractor
TRAC_d_cg_y_m_i = TRAC_height_cg_m; 
TRAC_d_cg_x_m_i = TRAC_trackwidth_m/2;
TRAC_theta_cg_deg_i = arctan(TRAC_d_cg_x_m_i/TRAC_d_cg_y_m_i);


TRAC_d_cp_y_m_i = TRAC_height_cp_m;
TRAC_d_cp_x_m_i = TRAC_trackwidth_m/2;
TRAC_theta_cp_deg_i = arctan(TRAC_d_cp_x_m_i/TRAC_d_cp_y_m_i);

%Trailer
TRAIL_d_cg_y_m_i = TRAIL_height_cg_m; 
TRAIL_d_cg_x_m_i = TRAIL_trackwidth_m/2;
TRAIL_theta_cg_rad_i = arctan(TRAIL_d_cg_x_m_i/TRAIL_d_cg_y_m_i);


TRAIL_d_cp_y_m_i = TRAIL_height_cp_m;
TRAIL_d_cp_x_m_i = TRAIL_trackwidth_m/2;
TRAIL_theta_cp_rad_i = arctan(TRAIL_d_cp_x_m_i/TRAIL_d_cp_y_m_i);


I = I+mr^2; %parallel axis theorem
%% Time Domain Dynamics

% Calculate new angle instance
% if XXXX_tq_nm <0, no tip acceleration

TRAC_theta_cp_rad(t) = ;

TRAC_tq_nm = (-(TRAC_force_drag_N*TRAC_d_cg_x_m_i)+(TRAC_force_weight_N*TRAC_d_cp_y_m_i));

TRAC_alpha_radps2 = TRAC_tq_nm/TRAC_inertia_roll_kgm2;

%Euler Time Step
%Rate
TRAC_omega_radps(t+1) = TRAC_omega_radps(t) + TRAC_alpha_radps2(t+1)*dt;
%Position
TRAC_theta_cg_rad(t+1) = TRAC_theta_cg_rad(t)+TRAC_omega_radps(t+1)*dt;
TRAC_theta_cp_rad(t+1) = TRAC_theta_cp_rad(t)+TRAC_omega_radps(t+1)*dt;





