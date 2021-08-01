
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
total_run_time_s =15; % sec
time_s = linspace(0, total_run_time_s, sampling_freq_hz*total_run_time_s)';
%% Inputs
% Aero Calcs
%use allowable windspeed table as inputs for aero calculation?
sim_rollover_angle_deg = 90;
start_roll_rate_dps = 0;
start_roll_angle_deg = 0;

v_mph = 140;
v_mps = v_mph*0.44704;
rho_kgpm3 = 1.225;
TRAC_Cd = 1.5;
TRAC_A_m2 = 15;

TRAC_Fd_N = 0.5*rho_kgpm3*(v_mps^2)*TRAC_Cd*TRAC_A_m2;

%% Mass Properties
g_mps2 = 9.81;
%Tractor
TRAC_height_cg_m = 1.1;
TRAC_mass_kg = 6970;
TRAC_inertia_roll_kgm2 = 37500;
TRAC_trackwidth_m = 2.53;
TRAC_height_cp_m = 1.925;
TRAC_force_drag_N = TRAC_Fd_N;
TRAC_force_weight_N = g_mps2*TRAC_mass_kg;

%% Variables & Inputs
%Tractor
TRAC_d_cg_y_m_i = TRAC_height_cg_m;
TRAC_d_cg_x_m_i = TRAC_trackwidth_m/2;
TRAC_theta_cg_rad_i = atan(TRAC_d_cg_x_m_i/TRAC_d_cg_y_m_i);

TRAC_d_cp_y_m_i = TRAC_height_cp_m;
TRAC_d_cp_x_m_i = TRAC_trackwidth_m/2;
TRAC_theta_cp_rad_i = atan(TRAC_d_cp_x_m_i/TRAC_d_cp_y_m_i);
%Inertias
TRAC_r_cg_m = TRAC_d_cg_x_m_i/(sin(TRAC_theta_cg_rad_i));
TRAC_I_pat_kgm2 = TRAC_inertia_roll_kgm2 + TRAC_mass_kg*TRAC_r_cg_m^2; %use this inertia

%Radii to calculate d_cg_x_m and d_cp_y_m during dynamic motion
TRAC_r_cp_m = TRAC_d_cp_x_m_i/(sin(TRAC_theta_cp_rad_i));
%% Initialize vars
TRAC_tq_nm = zeros(length(time_s),1);
TRAC_d_cg_x_m = zeros(length(time_s),1);
TRAC_d_cp_y_m = zeros(length(time_s),1);
TRAC_alpha_rps2 = zeros(length(time_s),1);

TRAC_theta_cg_rad = zeros(length(time_s),1);
TRAC_theta_cp_rad = zeros(length(time_s),1);
TRAC_theta_cg_rad(1) = TRAC_theta_cg_rad_i; %first angle is static angle
TRAC_theta_cp_rad(1) = TRAC_theta_cp_rad_i; %first angle is static angle

tractor_torque = zeros(length(time_s),1);


TRAC_d_cg_y_m = zeros(length(time_s),1);
deltaH = zeros(length(time_s),1);
deltaTheta = zeros(length(time_s),1);
deltaOmega_rps = zeros(length(time_s),1);
omega_E_rps = zeros(length(time_s),1);
PE_added_kgm2ps2 = zeros(length(time_s),1);
kinetic_energy_kgm2ps2 = zeros(length(time_s),1);
deltaKE_kgm2ps2 = zeros(length(time_s),1);
omega_energy_rps = zeros(length(time_s),1);
KE_total_kgm2ps2 = zeros(length(time_s),1);
PE_total_kgm2ps2 = zeros(length(time_s),1);
tractor_torque_energy = zeros(length(time_s),1);

%% Main Loop Start at Initial Rate
TRAC_omega_rps = zeros(length(time_s),1);
TRAC_omega_rps(1) = start_roll_rate_dps/57.29;
TRAC_roll_angle_rad = zeros(length(time_s),1);
TRAC_roll_angle_rad(1) = start_roll_angle_deg/57.29; %first angle is static angle

for t = 1:length(time_s) - 1
    
    dt = time_s(t+1) - time_s(t);
    TRAC_d_cg_x_m(t) = sin(TRAC_theta_cg_rad(t))*TRAC_r_cg_m; %new moment arm for new cg torque
    TRAC_d_cp_y_m(t) = cos(TRAC_theta_cp_rad(t))*TRAC_r_cp_m; %new moment arm for cp torque
    tractor_torque(t) = (TRAC_force_drag_N*TRAC_d_cp_y_m(t))-(TRAC_force_weight_N*TRAC_d_cg_x_m(t));
    tractor_torque_energy(t) = (TRAC_force_drag_N*TRAC_d_cp_y_m(t));

    if TRAC_roll_angle_rad(t)*57.29 < 0 % if angle of truck is below ground, stop
        break
    end
    %% Euler Time Step Calc
    TRAC_alpha_rps2(t+1) = tractor_torque(t)/TRAC_I_pat_kgm2;
    TRAC_omega_rps(t+1) = TRAC_omega_rps(t)+TRAC_alpha_rps2(t+1)*dt;
    TRAC_roll_angle_rad(t+1) = TRAC_roll_angle_rad(t)+TRAC_omega_rps(t+1)*dt;
    %% Energy Calc Check 
    TRAC_d_cg_y_m(t) = cos(TRAC_theta_cg_rad(t))*TRAC_r_cg_m; %cg height
    deltaH(1) = 0;
    if t > 1
        
        deltaTheta(t) = TRAC_roll_angle_rad(t) - TRAC_roll_angle_rad(t-1);
        deltaH(t) = TRAC_d_cg_y_m(t) - TRAC_d_cg_y_m(t-1); %cg goes up, potential energy goes up. cg goes down, energy goes down
        
        %total energy added in this torque time step. work is being done ON
        %lifting the cg, so it's negative
        PE_added_kgm2ps2(t) = -TRAC_mass_kg*g_mps2*deltaH(t) + tractor_torque_energy(t)*deltaTheta(t); 
        PE_total_kgm2ps2(t) = PE_total_kgm2ps2(t-1) + PE_added_kgm2ps2(t); %new total PE. previous plus new increment

%         kinetic_energy_kgm2ps2(t) = potential_energy_kgm2ps2(t);
%         kinetic_energy_kgm2ps2(t) = .5*TRAC_I_pat_kgm2*TRAC_omega_rps(t);
        deltaKE_kgm2ps2(t) =  PE_total_kgm2ps2(t) - PE_total_kgm2ps2(t-1); %new total PE, minus previous total PE

        KE_total_kgm2ps2(t) = deltaKE_kgm2ps2(t) + KE_total_kgm2ps2(t-1); %old total energy plus new delta in energy

        omega_energy_rps(t) = sqrt(2*KE_total_kgm2ps2(t)/TRAC_I_pat_kgm2); %calculate new omega based on total energy input into system
        
%         omega_energy_rps(t) = omega_rps(t) + omega_rps(t-1); %previous omega plus new omega
        
%  - .5*TRAC_I_pat_kgm2*TRAC_omega_rps(t-1);
%         delta_omega
        
%       deltaTheta(t) = abs(TRAC_theta_cg_rad(t)-TRAC_theta_cg_rad(t-1));
        
%         deltaOmega_rps(t) =sqrt( 2*( (TRAC_mass_kg*g_mps2*deltaH(t)) + (tractor_torque(t)*deltaTheta(t)) )/...
%             (TRAC_I_pat_kgm2) );
        
        %new energy delta, back calculate delta omega
%         omega_E_rps(t+1) = omega_E_rps(t) + deltaOmega_rps(t);
        
        
    end
    
    %% Iterate to new angles
    TRAC_theta_cg_rad(t+1) = TRAC_theta_cg_rad(1) - TRAC_roll_angle_rad(t+1);
    TRAC_theta_cp_rad(t+1) = TRAC_theta_cp_rad(1) - TRAC_roll_angle_rad(t+1);
    
    if TRAC_roll_angle_rad(t+1)*57.29 > sim_rollover_angle_deg
        TRAC_roll_angle_rad(t+1:end) =TRAC_roll_angle_rad(t+1);
        break
    end
end
% deltaH = abs(max(TRAC_d_cg_y_m) -TRAC_d_cg_y_m(1));
% deltaTheta = abs(TRAC_theta_cg_rad(t)-(TRAC_theta_cg_rad(1)));
% tractor_tq_avg = mean(tractor_torque(1):tractor_torque(t));
% deltaOmega_rps =sqrt( 2*( (TRAC_mass_kg*g_mps2*deltaH) + (tractor_tq_avg*deltaTheta) )/...
%     (TRAC_I_pat_kgm2) );
% deltaOmega_dps = deltaOmega_rps*57.29;

hold on
figure(1)
plot(time_s, TRAC_roll_angle_rad*57.29,'LineWidth',1);
xlabel('Time [s]')
ylabel('Roll Angle [deg]')
title('Tractor Roll Angle')
Plotter(1);
hold on


hold on
figure(2)
plot(time_s, TRAC_omega_rps*57.29,'LineWidth',1);
xlabel('Time [s]')
ylabel('Roll Rate [deg/s]')
title('Tractor Roll Rate')
Plotter(1);
hold on

hold on
figure(3)
plot(time_s, omega_energy_rps*57.29,'LineWidth',1);
xlabel('Time [s]')
ylabel('Roll Rate, Energy [deg/s]')
title('Tractor Roll Rate')
Plotter(1);
hold on

hold on
figure(4)
plot(time_s, omega_energy_rps*57.29, time_s, TRAC_omega_rps*57.29)
xlabel('Time [s]')
ylabel('Roll Rate, Energy [deg/s]')
legend({'Energy Based Rate',' Euler Time Step Rate'})
title('Tractor Roll Rate')
xlim([0 4])
Plotter(1);
hold on




