function [ws, psd_xt, fc] = PSD_v0(time, xt, N)
%   Title: PSD_v0.m
%   Author: S. Krug
%   Date: 3/23/2017
%   Notes:
%
%   time: time vector 
%   xt: signal for time vector
%   N: Size of vector     

%% From Mathworks Doc, PWD Estimates using PSD
% Obtain the periodogram using fft. The signal is real-valued and has even length. 
% Because the signal is real-valued, you only need power estimates for the positive
% or negative frequencies. In order to conserve the total power, multiply all frequencies
% that occur in both sets -- the positive and negative frequencies -- by a factor of 2. 
% Zero frequency (DC) and the Nyquist frequency do not occur twice. Plot the result.

%% 
[Xfft, ws] = fft_easy(xt,time); %Descrete fourier transform, ws returned in rad/s
% Scale to make these Fourier Coefficients
fc = (2/N)*Xfft;
psd_xt = abs(fc);
psd_xt = (psd_xt).^2;
ws = ws/(2*pi); % ws to hz

end
