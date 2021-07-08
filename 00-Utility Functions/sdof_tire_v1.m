function [road] = sdof_tire_v1(mu,kt,ct,zu,t)
%   Title: sdof_tire_v1.m
%   Author: S. Krug
%   Date: 11/6/17
%   Notes:

%   Variables
%   mu = unsprung mass [kg]
%   kt = tire spring rate [N/m]
%   ct = tire damping coefficient [Ns/m]
%   zu = unsprung mass position [m]

%   zr = road position [m]
%   t = time [s]

%% FFT of hub displacement
[zu_f, ws_f] = fft_easy(zu,t); % Output, zu

%% 1DOF Transfer Function from derivation
H = (kt+ct*ws_f*1i)./(-(ws_f.^2)*mu+ct*ws_f*1i+kt); %Output/Input, zu/zr

%% Apply transfer function from hub (output) to road (input)
zr_f = inv(diag(H))*zu_f;
%% Inverse FFT of road displacement
[zr, ~] = ifft_easy(zr_f, ws_f);

road.xf = abs(H);
road.zu_f = abs(zu_f);
road.zr_f = abs(zr_f);
road.zr = zr;
road.zu = zu;
road.freq = ws_f/2/pi;

end