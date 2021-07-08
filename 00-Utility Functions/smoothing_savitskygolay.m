%  This function implements a 2nd order Savitsky-Golay filter 
%
% INPUTS
% y = y-axis data to be filtered
% n = number of consecutive points to use for polynomial curve fit (span
% value)
%
% OUTPUTS:
% yfilt = filtered y vector


function [yfilt] = smoothing_savitskygolay(data,n)
    
    %Error Checking
    error = false;
    
    %Check if the right number of arguments were passed in (leaving 'n' blank
    %is acceptable)
    if(nargin<1)
        yfilt = 0;
        error = true;
        
    %Check if data is empty or only contains 1 value   
    elseif(isempty(data)|| length(data) ==1)
        yfilt = 1;
        error = true;
             
    %Set span value to default value of 1/10 the size of the raw data if not specified  
    elseif(nargin==1)
        n = floor(.1*length(data));
    
    %Ensure valid span value was passed in
    elseif(isempty(n)||n<=0||n>length(data))
        yfilt = 4;
        error = true;
    end
    
    if(~error)
        %Set span value to the nearest odd integer 
        n = floor(double(n));
        if (mod(n,2)==0)
            n=n-1;
        end
        halfrange = (n-1)/2;

        %Condition beginning and end of input data
        data =[flip(data(1:halfrange)),data,flip(data(end-halfrange+1:end))];
        yfilt = zeros(1,length(data));

        %Calculate polynomial smoothing convolution coefficients
        C = zeros(1,n);
        for i=1:n
            C(i) = (3*n^2-7-20*(i-1-halfrange)^2)/4/((n*(n^2-4))/3);
        end

        %Perform filtering
        for i=halfrange+1:length(data)-halfrange            
            yfilt(i)=sum(C.*data(i-halfrange:i+halfrange));    
        end

        %Resize yfilt to match original data
        yfilt = yfilt(halfrange+1:length(data)-halfrange);
    end
return;