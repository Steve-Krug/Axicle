function [n_max, n_eff, Delta_n,N,Road] = ISO_profile_generator_v0(B,L,nL,nU,k,Plot)
%% Title: ISO/IRI Road Profile Generator
% Last modified by: S. Krug
% Date: 170623

% Notes: Referencing:
% Investigation_Band_Limited_Fluid_Damper_Hong_ISO8608Kmethod.pdf

% close all
% clear all
% clc

% Inputs 
% B - Sampling Interval, m
% L - Length of profile, m
% nL = Lower boundary of spatial frequency, m^-1
% nU = Upper boundary of spatial frequency, m^-1
% k = ISO 8608
% Plot - Plot options: plot = 0 for not plot, plot = 1 for plot
% Examples:
% [n_max, n_eff, Delta_n, N, Road] = ISO_profile_generator_v0(0.005, 250, 1/250, 1/0.005, 9, 1);
% [n_max, n_eff, Delta_n, N, Road] = ISO_profile_generator_v0(0.025, 1000, 1/1000, 1/0.025, 4, 1);

% Road Profile Definition:
% Road Class ISO 8608 A-B: k = 3
% Road Class ISO 8608 B-C: k = 4
% Road Class ISO 8608 C-D: k = 5
% Road Class ISO 8608 D-E: k = 6
% Road Class ISO 8608 E-F: k = 7
% Road Class ISO 8608 F-G: k = 8
% Road Class ISO 8608 G-H: k = 9

% Outputs n_max - maximum theoretical sampling spatial frequency, m^-1
% n_eff - maximum effective sampling spatial frequency, m^-1 delta_n -
% discretized spatial frequency spacing, m^-1 N - maximum number of
% possible sampling size Road - road signal

% B = 0.025;                              % Sampling interval, m
% L = 1000;                               % Length of profile, m
% k = 4;                                  % ISO 8608 road profile classification, 3-9
% Gd_n0=16e-6;                            % ISO A Profile


%% Generate Elevation (mm) versus Distance (m) Plot

%Maximum theoretical sampling spatial frequency (m) plot
n_max = 1/B;
%Maximum effective sampling spatial frequency spacing
n_eff = n_max/2;
%Discretized spatial frequency spacing
Delta_n = 1/L;
%Number of iterations
N = L/B;
%Spatial frequency band
ni = nL:Delta_n:nU;
%Amplitude (from 0 to Ampi)
n_0 = 0.1;
Ampi = 1e-3*(2^k)*sqrt(Delta_n)*(n_0./ni);
%Random phase angle
phi = 2*pi*rand(size(ni));
%Abscissa variable x
x = 0:B:L;
%Road profile (from -Ampi/2 to Ampi/2)
h = zeros(size(x));

for j = 1:length(x)
    h(j) = sum(Ampi/2.*cos(2*pi*x(j).*ni + phi));
end

Road = [x; h;];

[ws, psd_xt, fc] = psd_v0(x, h);
% [pxx, f] = pwelch(h,window,[],n_max,n_max);

%Plot road profile and PSDs

if Plot == 1
    figure(1)
    hold on
    subplot(2,1,1)
    plot(x, h*1000);
    xlabel('Distance [m]')
    ylabel('Elevation [mm]')
    title('ISO 8606 Road Profile Classification')
    hold on
    subplot(2,1,2)
    loglog(ws, psd_xt);
    xlim([0 10])
    xlabel('Wavenumber [Cycle/m]')
    ylabel('Power Spectral Density Amplitude m^2/[cycle/m]')
    title('ISO 8606 Road Profile Classification')
    
end


if Plot == 0
    disp('Set Plot = 1 for road profile plot')
end


end