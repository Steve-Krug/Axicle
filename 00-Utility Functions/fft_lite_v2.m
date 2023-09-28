function [freq,mag,phase] = fft_lite_v2(fs,x )
%   Computes the fft of signal, x 
%   Michael Kinstle, July 02, 2015 
%   v2 - November 19, 2015
%   Added phase angle calculations

%   Inputs:
%   fs= sampling frequency, hz
%   x=signal

%   Outputs:
%   freq=output frequency (0~0.5fs), hz
%   mag = fft of the input signal
%   phase = phase angle, deg

nfft=length(x);             %   # of pts for fft, must be at least quantity of signal
mag=fft(x,nfft);      %   fft of signal, abs finds the magnitude
freq=[0:nfft-1]'/nfft*fs;          %   frequency range, without multiplying by fs, the scale is normalized by fs

%   fft data is mirrored about 0.5fs (Nyquist Frequency)
%   Remove 2nd half of data as it is redundant

freq=freq(1:round(nfft/2));
mag=mag(1:round(nfft/2));
phase=unwrap(angle(mag))*180/pi;
mag=abs(mag);                       % abs after the phase angle calculations

end
