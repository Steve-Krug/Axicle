function g = grms(f,ASD)
%   Title: grms.m
%   Author: S. Krug
%   Date: 10/10/17
%   Notes:
%   f is frequency in [Hz]
%   ASD is ASD (PSD) in [G^2/Hz]
%
%   - Initial start of : S.K. 10/10/17

no_octaves = zeros(length(f) -1, 1);
dB = zeros(length(f) -1, 1);
m = zeros(length(f) -1, 1);
A = zeros(length(f) -1, 1);
rms = zeros(length(f) -1, 1);

for i = 1:length(f) - 1
    % Octaves
    no_octaves(i) = log10(f(i+1)/f(i))/(log10(2));
    % dB level
    dB(i) = 10*log10(ASD(i+1)/ASD(i));
    % m = dB/Octaves
    m(i) = dB(i)/no_octaves(i);
    % Area under curves between F_l and F_h
    if m(i) <= -10*log10(2)
        A(i) = ASD(i)*f(i)*log(f(i+1)/f(i));
    else
        A(i) = (10*log10(2))*(ASD(i+1)/(10*log10(2)+ m(i))) * (f(i+1) - f(i)*((f(i)/f(i+1))^(m(i)/(10*log10(2)))) );
    end
    
end

A_sum = cumsum(A);

for i = 1:length(A_sum)
% grms at each increment
    rms(i) = sqrt(A_sum(i));
end
    
g.values = rms;
g.max = max(g.values);
g.m = m; %
g.A = A;
g.dB = dB; %
g.o = no_octaves; %

end