function [ts,xt] = iPSD_v0(ws,psd_xt)
%   Title: iPSD_v0.m
%   Author: S. Krug
%   Date: 3/16/2017
%   Notes:

%   psd_xt is the psd amplitude vector. Units should be m^2/(cycles/m) (ride
%   road spec); or G^2/(Hz) (accelerometer data spec).

%   ws is the frequency vector. Units should [Hz]

%   N is length of psd

real_test = isreal(psd_xt); % if == 0, then array contains imaginary parts,
%   and therefore the orginal time history can be constructed (i.e. parsing
%   in "fc"). PSD_v0.m returns "fc" which contains the original pre-PSD
%   amplitude imaginary & real vector.
%   If there is no imaginary part, this script assumes it's a PSD with no
%   imaginary parts, then a randomized imaginary part is generated for the
%   artifical time history

if real_test == 0
    %% Rescale FFT coefficients
    N = length(psd_xt);
    Xfft = (N/2)*psd_xt; % psd_xt is "fc" in PSD_v0
    %% Call ifft_easy.m which calls MatLab's ifft.m
    [xt, ts] = ifft_easy(Xfft,ws.*(2*pi));
    ts = ts';
else
    %% Rescale FFT coefficients
    N = length(psd_xt);
    psd_xt = psd_xt.^(1/2); %sqrt of amplitude, to get amplitude to fft format
    fc = psd_xt*(N/2);
    %% Turn into complex signal to take inverse FFT
    for i = 1:length(fc)
                r(i) = -10 + (10+ 10)*rand(1,1);
%         r(i) = -100 + (100+100)*rand(1,1);
    end
    r = r';
    fc = complex(fc,r);
    %     fc = complex(fc);
    
    %% Call ifft_easy.m which calls MatLab's ifft.m
    [xt, ts] = ifft_easy(fc,ws.*(2*pi)); %Keep in Hz
    ts = ts';
end

end