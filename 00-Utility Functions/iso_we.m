function y = iso_we(x,fs) 
% by Steve Krug 8/30/17
% The code is used for triaxial rotations
% refer ISO 2631- yaw, pitch, roll acceleration discomfort filter.
% ISOFILWE    

    
% Filter , whole body, vertical direction 
%           y = iso_we(x,fs) 
%           y output signal, acceleration 
%           x input signal, acceleration 
%           fs  sampling frequency Hz 
%           bilinear transformation algorithm is used 
f1 = 0.4;
f2 = 100; 
f3 = 1.0;    
f4 = 1.0;       
Q4 = 0.63; 
% f5 = 1000; %inf in 2631       
% Q5 = 1; % - in 2631
% f6 = 1000; %inf in 2631      
% Q6 = 1; % - in 2631

% Note that in the function ?butter? the variables Q1 and Q2 are  
% effectively set to equal to 1/sqrt(2), therefore they don?t need 
% to be explicitly set here. 
w3 = 2*pi*f3;  w4 = 2*pi*f4; 
% w5 = 2*pi*f5; w6 = 2*pi*f6; 
nyq = fs/2;                            % Nyquist frequency 
% determine parameters for band limiting high pass and low pass 
[b1,a1] = butter(2,f1/nyq,'high');% High pass   
if fs>200
[b2,a2] = butter(2,f2/nyq);       % Low pass 
end
% determine parameters for a-v transition 
B3 = [1/w3 1]; A3 = [1/w4/w4 1/Q4/w4 1]; 
[b3,a3] = bilinear(B3,A3,fs); 

% determine parameters for upward step 
% B4 = [1/w5/w5 1/Q5/w5 1]*w5*w5/w6/w6; 
% A4 = [1/w6/w6 1/Q6/w6 1]; 
% [b4,a4] = bilinear(B4,A4,fs); 


%% 
try 
    if fs>200
    y = filter(b2,a2,x);   % Apply low-pass band limiting 
    else
        y=x;
    end
    y = filter(b1,a1,y);   % Apply high-pass band limiting 
    y = filter(b3,a3,y);   % Apply a-v transition
    % Eliminate upward step
    % y = filter(b4,a4,y);   % Apply upward step
catch ME
    switch ME.identifier
        case 'MATLAB:timeseries:filter:singletimeseriesobject'
            y1=x.Data;
            if fs>200
            y1 = filter(b2,a2,y1);   % Apply low-pass band limiting 
            end
            y1 = filter(b1,a1,y1);   % Apply high-pass band limiting 
            y1 = filter(b3,a3,y1);   % Apply a-v transition 
%             y1 = filter(b4,a4,y1);   % Apply upward step 
            y=timeseries(y1, x.Time);   
            
        otherwise
            rethrow(ME)
    end
  
end

%%

% Apply filter to input signal vector x (output to signal vector y) 
