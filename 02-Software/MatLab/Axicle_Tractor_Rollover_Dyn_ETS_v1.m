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
total_run_time_s =15; % sec
time_s = linspace(0, total_run_time_s, sampling_freq_hz*total_run_time_s)';

%% Aero Calcs
%use allowable windspeed table as inputs for aero calculation?



%% Mass Properties
g_mps2 = 9.81;
slack_angle = 5; %angle in deg when tractor inertia is added on, and tractor plus trailer roll together at same rate.
%Tractor
TRAC_height_cg_m = 1.1;
TRAC_mass_kg = 6970;
TRAC_inertia_roll_kgm2 = 37500;
TRAC_trackwidth_m = 2.53;
TRAC_height_cp_m = 1.925;
TRAC_force_drag_N = 10000;
TRAC_force_weight_N = g_mps2*TRAC_mass_kg;

%Trailer
TRAIL_height_cg_m = 2.1;
TRAIL_mass_kg = 22142;
TRAIL_inertia_roll_kgm2 = 95000;
TRAIL_trackwidth_m = 2.53;
TRAIL_height_cp_m = 2.18;
TRAIL_force_drag_N = 90000;
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

TRAIL_tq_nm = zeros(length(time_s),1);
TRAIL_d_cg_x_m = zeros(length(time_s),1);
TRAIL_d_cp_y_m = zeros(length(time_s),1);
TRAIL_alpha_rps2 = zeros(length(time_s),1);
TRAIL_omega_rps = zeros(length(time_s),1);
TRAIL_theta_cg_rad = zeros(length(time_s),1);
TRAIL_theta_cp_rad = zeros(length(time_s),1);
TRAIL_theta_cg_rad(1) = TRAIL_theta_cg_rad_i; %first angle is static angle
TRAIL_theta_cp_rad(1) = TRAIL_theta_cp_rad_i; %first angle is static angle
TRAIL_roll_angle_rad = zeros(length(time_s),1);
TRAIL_roll_angle_rad(1) = 0; %first angle is static angle

% trailer_counter = zeros(length(time_s),1);
trailer_counter = 1;
TT_omega_rps = zeros(length(time_s),1);
TOTAL_tq_nm = zeros(length(time_s),1);
TOTAL_alpha_rps2 = zeros(length(time_s),1);
TOTAL_omega_rps = zeros(length(time_s),1);
TOTAL_roll_angle_rad = zeros(length(time_s),1);

% Assumes trailer ALWAYS initiates rollover
for t = 1:length(time_s)-1
    
    dt = time_s(t+1) - time_s(t);
    
    if (TRAIL_roll_angle_rad(t)*57.29) < slack_angle && trailer_counter == 1 %get the trailer up to speed first
        
        if t == 1
            TRAIL_tq_nm(t) = ((TRAIL_force_drag_N*TRAIL_d_cp_y_m_i)-(TRAIL_force_weight_N*TRAIL_d_cg_x_m_i));
            %TRAIL_tq_nm(t) = 0;
        else
            
            %TRAC_tq_nm(t) = ((TRAC_force_drag_N*TRAC_d_cp_y_m_i)-(TRAC_force_weight_N*TRAC_d_cg_x_m_i)); %fill array with tractor net torque
            
            TRAIL_d_cg_x_m(t) = sin(TRAIL_theta_cg_rad(t))*TRAIL_r_cg_m; %new moment arm for new cg torque
            TRAIL_d_cp_y_m(t) = cos(TRAIL_theta_cp_rad(t))*TRAIL_r_cp_m; %new moment arm for cp torque
            TRAIL_tq_nm(t) = (TRAIL_force_drag_N*TRAIL_d_cp_y_m(t))-(TRAIL_force_weight_N*TRAIL_d_cg_x_m(t));
        end
        
        %check if tq is negative, reset to zero tq for acceleration
        if TRAIL_tq_nm(t) < 0
            TRAIL_tq_nm(t) = 0;
        end
        
        %Angular Acceleration
        TRAIL_alpha_rps2(t+1) = TRAIL_tq_nm(t)/TRAIL_I_pat_kgm2;
        %Angular Rate
        TRAIL_omega_rps(t+1) = TRAIL_omega_rps(t)+TRAIL_alpha_rps2(t+1)*dt;
        %Angle Change
        
        %     TRAIL_theta_cg_rad(t+1) = TRAIL_theta_cg_rad(t)+TRAIL_omega_rps(t+1)*dt;
        %     TRAIL_theta_cp_rad(t+1) = TRAIL_theta_cp_rad(t)+TRAIL_omega_rps(t+1)*dt;
        
        %Resolved roll angle assuming start = 0deg
        TRAIL_roll_angle_rad(t+1) = TRAIL_roll_angle_rad(t)+TRAIL_omega_rps(t+1)*dt;
        %new angles?
        TRAIL_theta_cg_rad(t+1) = TRAIL_theta_cg_rad(1) - TRAIL_roll_angle_rad(t+1); %angles are decreasing..?
        TRAIL_theta_cp_rad(t+1) = TRAIL_theta_cp_rad(1) - TRAIL_roll_angle_rad(t+1); %angles are decreasing..?
        
        
        
    else %add in inertias from trailer
        
        if trailer_counter == 1
            %conservation of angular momentum, add trailer + tractor
            %inertias together to get initial total rate L = I*omega
            momentum_initial = TRAIL_I_pat_kgm2*TRAIL_omega_rps(t);
            %TT_omega_rps = TRAIL_omega_rps; %add in previous rate built up by trailer initially
            TOTAL_I_kgm2 = TRAIL_I_pat_kgm2+TRAC_I_pat_kgm2;
            %TOTAL_omega_rps(t) = momentum_initial/(TOTAL_I_kgm2); %assuming tractor "instantly" accelerates to the rate
            TRAC_omega_rps(t) = momentum_initial/(TOTAL_I_kgm2);
            TRAIL_omega_rps(t) = momentum_initial/(TOTAL_I_kgm2);
            %imposed based on conservation of angular momentum. Trailer is
            %also traveling at this speed now, hence "total omega".
            %TRAIL_omega_rps(t) = TOTAL_omega_rps(t);
            transition_instance = t;
            
            TRAC_theta_cg_rad(transition_instance) = TRAC_theta_cg_rad_i; %angle AT start of transition
            TRAC_theta_cg_rad(transition_instance) = TRAC_theta_cp_rad_i; %angle AT start of transition
        end
        
        %         %initial net torque on tractor
        %         TRAC_tq_nm(t) = ((TRAC_force_drag_N*TRAC_d_cp_y_m_i)-(TRAC_force_weight_N*TRAC_d_cg_x_m_i));
        %
        % conservation of momentum calculation? energy transfer calc to get
        % intial rate?
        
        
        
        %Calculate individual components of moment arms
        TRAIL_d_cg_x_m(t) = sin(TRAIL_theta_cg_rad(t))*TRAIL_r_cg_m; %new moment arm for new cg torque
        TRAIL_d_cp_y_m(t) = cos(TRAIL_theta_cp_rad(t))*TRAIL_r_cp_m; %new moment arm for cp torque
        TRAC_d_cg_x_m(t) = sin(TRAC_theta_cg_rad(t))*TRAC_r_cg_m; %new moment arm for new cg torque
        TRAC_d_cp_y_m(t) = cos(TRAC_theta_cp_rad(t))*TRAC_r_cp_m; %new moment arm for cp torque
        %TRAIL_tq_nm(t) = (TRAIL_force_drag_N*TRAIL_d_cp_y_m(t))-(TRAIL_force_weight_N*TRAIL_d_cg_x_m(t));
        %Calculate individual components of torque w/ updated moment arms.
        
        
        
        trailer_torque = (TRAIL_force_drag_N*TRAIL_d_cp_y_m(t))-(TRAIL_force_weight_N*TRAIL_d_cg_x_m(t));
        
        if TRAC_roll_angle_rad(t) >= 0
            tractor_torque = (TRAC_force_drag_N*TRAC_d_cp_y_m(t))-(TRAC_force_weight_N*TRAC_d_cg_x_m(t));
            %         else % if tractor roll angle falls back down to 0, then use the tractor static torque
            %             tractor_torque = (TRAC_force_drag_N*TRAC_d_cp_y_m(transition_instance))-(TRAC_force_weight_N*TRAC_d_cg_x_m(transition_instance));
        else % if tractor roll angle falls back down to 0, then assume NO tractor torque
            tractor_torque = 0;
        end
        
        TOTAL_tq_nm(t) = trailer_torque + tractor_torque;
        
        
        
        %Angular Acceleration
        if TRAC_roll_angle_rad(t) >= 0 % for instance where tractor + trailer moving up
            %TOTAL_alpha_rps2(t+1) = TOTAL_tq_nm(t)/TOTAL_I_kgm2;
            TRAC_alpha_rps2(t+1) = TOTAL_tq_nm(t)/TOTAL_I_kgm2;
            TRAIL_alpha_rps2(t+1) = TOTAL_tq_nm(t)/TOTAL_I_kgm2;
        else% if tractor roll angle fell back down to below zero,
            %TOTAL_alpha_rps2(t+1) = TOTAL_tq_nm(t)/TRAIL_I_pat_kgm2;
            TRAC_alpha_rps2(t+1) = 0;
            TRAIL_alpha_rps2(t+1) = TOTAL_tq_nm(t)/TRAIL_I_pat_kgm2;
        end
        
        %Angular Rate
        if TRAC_roll_angle_rad >= 0 % for instance where tractor + trailer moving up
            %             TOTAL_omega_rps(t+1) = TOTAL_omega_rps(t)+TOTAL_alpha_rps2(t+1)*dt;
            %             TRAIL_omega_rps(t+1) = TOTAL_omega_rps(t)+TOTAL_alpha_rps2(t+1)*dt;
            TRAC_omega_rps(t+1) = TRAC_omega_rps(t)+TRAC_alpha_rps2(t+1)*dt;
            TRAIL_omega_rps(t+1) = TRAIL_omega_rps(t)+TRAIL_alpha_rps2(t+1)*dt;
            
        else % if tractor roll angle fell back down to below zero
            %             TRAC_omega_rps(t+1) = TOTAL_omega_rps(t)+TOTAL_alpha_rps2(t+1)*dt;
           TRAC_omega_rps(t+1) = 0;
           TRAIL_omega_rps(t+1) = TRAIL_omega_rps(t)+TRAIL_alpha_rps2(t+1)*dt; 
        end
        
        %Angle
        if TRAC_roll_angle_rad(t) >= 0
            TRAC_roll_angle_rad(t+1) = TRAC_roll_angle_rad(t)+TRAC_omega_rps(t+1)*dt;
            TRAIL_roll_angle_rad(t+1) = TRAIL_roll_angle_rad(t) + TRAIL_omega_rps(t+1)*dt;
        else % if tractor roll angle fell back down to below zero
              TRAC_roll_angle_rad(t+1) = TRAC_roll_angle_rad(t); %just make it the previous angle that everything stopped at, slightly below zero
%             TRAIL_roll_angle_add_rad(t+1) = TRAC_roll_angle_rad(t)+TOTAL_omega_rps(t+1)*dt; 
%             TRAIL_roll_angle_rad(t+1) = TRAIL_roll_angle_rad(transition_instance) + TRAIL_roll_angle_add_rad(t+1);
              TRAIL_roll_angle_rad(t+1) = TRAIL_roll_angle_rad(t) + TRAIL_omega_rps(t+1)*dt;
        end
        
        
        %new angles; take previous angle value once this part of the loop started and subtract the new delta
        %angle created based on the total angle change with total inertia
        %and torque
        
        TRAIL_theta_cg_rad(t+1) = TRAIL_theta_cg_rad(transition_instance) - TRAC_roll_angle_rad(t+1);
        TRAIL_theta_cp_rad(t+1) = TRAIL_theta_cp_rad(transition_instance) - TRAC_roll_angle_rad(t+1);
        TRAC_theta_cg_rad(t+1) = TRAC_theta_cg_rad(transition_instance) - TRAC_roll_angle_rad(t+1);
        TRAC_theta_cp_rad(t+1) = TRAC_theta_cp_rad(transition_instance) - TRAC_roll_angle_rad(t+1);
        
        % If trailer rolls over completely, terminate simulation
        if (TRAIL_roll_angle_rad(t+1)*57.29) > 90 || TRAIL_roll_angle_rad(t+1)*57.29 < 0
            break
        end
        
        %if tractor goes back down to zero AFTER already being rolled up
        %slightly, terminate simulation. Tractor is stuck at zero roll
        %angle, and trailer is just rolled on onto outer wheels and
        %maintaining angle with zero rate
        if TRAC_roll_angle_rad(t+1)*57.29 < 0 
            TRAIL_alpha_rps2(t+1:end) = 0;
            TRAIL_omega_rps(t+1:end) = 0;
            TRAIL_roll_angle_rad(t+1:end) = TRAIL_roll_angle_rad(t);
            break
        end
        
        trailer_counter = trailer_counter+1;
        
    end
end




figure(1)
plot(time_s,TRAIL_roll_angle_rad*57.29, time_s, TRAC_roll_angle_rad*57.29)
legend({'Trailer Roll Angle','Tractor Roll Angle'})
ylabel('Angle [deg]')
xlabel('Time [s]')
Plotter(1)

figure(2)
plot(time_s,TRAIL_omega_rps*57.29,'LineWidth',10)
hold on
plot(time_s, TRAC_omega_rps*57.29,'LineWidth',3)
legend({'Trailer Roll Rate','Tractor Roll Rate'})
ylabel('Angular Rate [deg/s]')
xlabel('Time [s]')
Plotter(1)

figure(3)
plot(time_s,TRAIL_alpha_rps2*57.29,'LineWidth',10)
hold on
plot(time_s, TRAC_alpha_rps2*57.29,'LineWidth',3)
legend({'Trailer Angular Acceleration','Tractor Angular Acceleration'})
ylabel('Angular Acceleration [deg/s^2]')
xlabel('Time [s]')
Plotter(1)

% figure(1)
% subplot(3,1,3)
% plot(time_s,TRAIL_roll_angle_rad*57.29)
% legend({'Roll Angle'})
% ylabel('Angle [deg]')
% xlabel('Time [s]')
% Plotter(1)
% % figure(5)
% % plot(time_s,TRAIL_force_drag_N*TRAIL_d_cp_y_m, time_s, -TRAIL_force_weight_N*TRAIL_d_cg_x_m)
% % legend({'aero moment','weight moment'})
% subplot(3,1,2)
% plot(time_s,TRAIL_omega_rps*57.29)
% legend({'Roll Rate'})
% ylabel('Rate [deg/s]')
% xlabel('Time [s]')
% Plotter(1)
%
% subplot(3,1,1)
% plot(time_s,TRAIL_alpha_rps2*57.29)
% legend({'Roll Accel'})
% ylabel('Accel [deg/s^2]')
% xlabel('Time [s]')
% Plotter(1)


% figure(5)
% plot(time_s,TRAIL_d_cp_y_m, time_s, TRAIL_d_cg_x_m)
% legend({'cp vertical moment arm','cg lateral moment arm'})
%
% figure(2)
% plot(time_s, TRAIL_tq_nm)
% legend({'net torque'})
% Plotter(1)
%
% figure(6)
% plot(time_s,TRAIL_force_drag_N*TRAIL_d_cp_y_m-TRAIL_force_weight_N*TRAIL_d_cg_x_m)
% legend({'net torque, calc"d'})
% Plotter(1)
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

