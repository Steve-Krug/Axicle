function Out=timeAveWeighted(varargin)
% timeAVeWEigthed(data, timeshistory), data and timehistory has to be the
    % same legnth
% timeAveWeighted(data, fs), fs is a scale
if nargin==2
    y=varargin{1}.^2;
    if isscalar(varargin{2})        
         fs = varargin{2};
         Out=trapz(y);
         duration=length(y)-1;
         Out=Out/(duration-1);
    else 
        time=(varargin(2));
        if length(time)==length(y)
            Out=trapz(time, y);  
            Out=Out/(time(end)-time(1));
        end
    end
elseif nargin==1
    try 
        time=varargin{1}.Time;
        y=(varargin{1}.Data.^2);
        Out=trapz(time, y); 
        Out=Out/(time(end)-time(1));
    end
end

Out=sqrt(Out);
