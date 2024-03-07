function [road_profile] = profile_generator_v0(road_type, Vx)
%% Title: Road Profile Generator, Based on Polaris/Damian Harty
% Last modified by: S. Krug
% Date: 170623


SurfName{1}='High Quality Paved Road';
RoughnessCoef = 1.4e-8;
WNSSlope = -2.5;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=0.;
% Kurtosis produces a small number of large events.
kurtosis=0.;

charcount=size(SurfName);
Surf(1,1:charcount(2))=SurfName;
kr(1) = RoughnessCoef;
mWNS(1) = WNSSlope;
lambda(1)=skewness;
gamma(1)=kurtosis;

SurfName{2}='Secondary Pavement (Two Lane Paved Road)';
RoughnessCoef =1.9e-7;
WNSSlope = -2.5;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=0.;
% Kurtosis produces a small number of large events.
kurtosis=0.;

charcount=size(SurfName);
Surf(2,1:charcount(2))=SurfName;
kr(2) = RoughnessCoef;
mWNS(2) = WNSSlope;
lambda(2)=skewness;
gamma(2)=kurtosis;


SurfName{3}='Rough Pavement (Degraded Paved Road)';
RoughnessCoef =8.0e-7;
WNSSlope = -2.5;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=-50.;
% Kurtosis produces a small number of large events.
kurtosis=100.;

charcount=size(SurfName);
Surf(3,1:charcount(2))=SurfName;
kr(3) = RoughnessCoef;
mWNS(3) = WNSSlope;
lambda(3)=skewness;
gamma(3)=kurtosis;


SurfName{4}='Loose Surface';
RoughnessCoef =3.0e-5;
WNSSlope = -2.0;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=0.;
% Kurtosis produces a small number of large events.
kurtosis=10.;

charcount=size(SurfName);
Surf(4,1:charcount(2))=SurfName;
kr(4) = RoughnessCoef;
mWNS(4) = WNSSlope;
lambda(4)=skewness;
gamma(4)=kurtosis;


SurfName{5}='Loose Surface with Washboard and Potholes';
RoughnessCoef = 4.0e-6;
WNSSlope = -2.4;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=-2.;
% Kurtosis produces a small number of large events.
kurtosis=20.;


charcount=size(SurfName);
Surf(5,1:charcount(2))=SurfName;
kr(5) = RoughnessCoef;
mWNS(5) = WNSSlope;
lambda(5)=skewness;
gamma(5)=kurtosis;


SurfName{6}='Belgian Block';
% RoughnessCoef = 4.0e-1;
% Data provided - but doesn't seem very likely because 100,000 times more
% than surface 5. Document "ROad Profile Info.doc" also gives 9E-3
% ft^2/cycle/ft at 0.1 cycle/ft for surface 5 and 8E-2 ft^2/cycle/ft at the
% ridiculously precise 0.083 cycle/ft - let's call it 0.1 and declare
% Belgian Block a factor of 10 bigger than Surface 5 and go with relative
% scaling from there.
% Scaling by 0.2 following absorbed power calculation with MXT model
RoughnessCoef = 5.0e-6*0.2;
WNSSlope = -1.4;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=0.;
% Kurtosis produces a small number of large events.
kurtosis=-30.;

charcount=size(SurfName);
Surf(6,1:charcount(2))=SurfName;
kr(6) = RoughnessCoef;
mWNS(6) = WNSSlope;
lambda(6)=skewness;
gamma(6)=kurtosis;


SurfName{7}='Trails';
% RoughnessCoef = 4.6e-1;
% Data provided but seems unlikely, see above
RoughnessCoef = 4.6e-5;
WNSSlope = -1.9;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=0.;
% Kurtosis produces a small number of large events.
kurtosis=0.;

charcount=size(SurfName);
Surf(7,1:charcount(2))=SurfName;
kr(7) = RoughnessCoef;
mWNS(7) = WNSSlope;
lambda(7)=skewness;
gamma(7)=kurtosis;


SurfName{8}='Cross-Country';
% RoughnessCoef = 9.2e-1;
% Data provided but seems unlikely, see above
RoughnessCoef = 9.2e-5;
WNSSlope = -2.1;
% Skewness produces obstacles on a flat base if positive and depressions
% from a flat base if negative. 1 is a touch and 10 is a lot.
skewness=0.;
% Kurtosis produces a small number of large events.
kurtosis=0.;

charcount=size(SurfName);
Surf(8,1:charcount(2))=SurfName;
kr(8) = RoughnessCoef;
mWNS(8) = WNSSlope;
lambda(8)=skewness;
gamma(8)=kurtosis;



numlines=8192;
WaveStart=0.05;
WaveIncrement=0.001;
WaveEnd=WaveStart+(numlines-1)*WaveIncrement;
WaveNumber = WaveStart:WaveIncrement:WaveEnd;
distance=0:1/WaveEnd:(numlines-1)/WaveEnd;

window=ones(1,8192);
numtaper=512
t=1:numtaper;
w1=0.5*(1-cos(t/numtaper*pi));
w2=0.5*(1+cos(t/numtaper*pi));
window(1:numtaper)=w1;
window(8192-numtaper+1:8192)=w2;

colour=['r'
    'g'
    'b'
    'k'
    'c'
    'm'
    'y'
    'r'];

hold on
index = road_type;
figure(1)
absWNS = kr(index)*WaveNumber.^mWNS(index);
hold on
subplot(3,1,1);
loglog(WaveNumber,absWNS,colour(index));
% plotnum=index+(nearest((index-3)/4));
% subplot(4,4,index+(nearest((index-3)/4))*4);loglog(WaveNumber,absWNS,colour(index))
% loglog(WaveNumber,WNS,colour(index))
xlabel('Wave Number (1/ft)')
ylabel('WNS ft^2/(1/ft)')
legend(SurfName{index})
%     title(Surf(index,:))
title('Dymola Road Profile 6-Post Input Options, 170623')
phase=zeros(1,numlines);
for k=1:numlines
    phase(k)=(rand-0.5)*2*pi;
    WNS(k)=(absWNS(k)^0.5)*exp(i*phase(k));
end
% Note scaling
profile1=imag(ifft(WNS))*numlines;
% Non-Linear Transformation after Steinwolf & Connon
a=lambda(index)/(4+2*(1+1.5*(gamma(index)-3))^0.5);
b=((1+1.5*(gamma(index)-3))^0.5-1)/18;
h=1/(1+2*a^2+6*b^2)^0.5;
profile2=h*(profile1 + a*(profile1.^2-1) + b * (profile1.^3 - 3*profile1));
profile2=(profile2-mean(profile2)).*window;
RMS(index)=mean(profile1.*profile1)^0.5
% subplot(4,4,index+(nearest((index-3)/4)*4+4));plot(distance,profile2,colour(index))
hold on
subplot(3,1,2);plot(distance,profile2,colour(index))

ylabel('Amplitude [ft]')
xlabel('Distance [ft]')
%% Convert to SI Units
distance_SI = distance*(0.3048); %Convert from ft to m
road_input_SI = profile2*(0.3048); %Convert from ft to m

%% Convert to Time Domain profile, from distance domain, based on vehicle speed
road_profile.road_input_SI = road_input_SI;
road_profile.time = distance_SI/Vx; % Velocity = 30m/s (67mph)

subplot(3,1,3);
plot(road_profile.time, road_profile.road_input_SI, colour(index))
ylabel('Amplitude [m]')
xlabel('Time [s]')
title('Pad Input Time History')
hold off



%     SgOmega0(index)=kr(index)*(1/(2*pi))^mWNS(index)*1E6
%     if SgOmega0(index) < 8
%             ISO(index,1:13)='A - Very Good';
%     elseif SgOmega0(index) >= 8 & SgOmega0 < 32
%             ISO(index,1:13)='B - Good     ';
%     elseif SgOmega0(index) >= 32 & SgOmega0 < 128
%             ISO(index,1:13)='C - Average  ';
%     elseif SgOmega0(index) >= 128 & SgOmega0 < 512
%             ISO(index,1:13)='D - Poor     ';
%     elseif SgOmega0(index) >= 512 & SgOmega0 < 2048
%             ISO(index,1:13)='E - Very Poor';
%     elseif SgOmega0(index) >= 2048 & SgOmega0 < 8192
%             ISO(index,1:13)='F            ';
%     elseif SgOmega0(index) >= 8192 & SgOmega0 < 32768
%             ISO(index,1:13)='G            ';
%     elseif SgOmega0(index) >= 32768
%             ISO(index,1:13)='H            ';
%     end
%
%     disp(Surf(index,:))
%     disp(ISO(index,:))

%     % Take spectra above and sum sin waves with randomised phase
%     % - poor man's iFFT!
%     profile2=zeros(1,4096);
%     for k=1:numlines
%         profile2=cos((distance+rand*2*pi)*WaveNumber(k)*2*pi)*absWNS(k)+profile2;
%     end
% %     figure(2)
%     subplot(3,1,3);plot(distance,profile2/4096,colour(index))
%     ylabel('Summed Cosines')

Plotter(1)
hold off
