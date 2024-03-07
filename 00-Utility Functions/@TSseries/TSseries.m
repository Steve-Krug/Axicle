classdef TSseries < timeseries
    %TSSERIES Inherits the timeseries class
    
    %% Class Properties
    
    properties (Dependent = true)
        noise;
    end
    
    
    %% Class Methods
    
    methods
        
        function noise = get.noise(this)
            %Compute the variance in a signal between the offset indices.
            tempSeries = gettsbetweenevents(this,'DataOffsetStart','DataOffsetEnd');
            %Detrend to flatten increasing signals and compute variance
            noise = tempSeries.detrend('linear').var;
        end
        
        function obj = TSseries(varargin)
            %Method to handle class creation and allow for type conversion
            %from timeseries.
            obj = obj@timeseries(varargin{:});
        end
        
        function this = range(this)
            %Find the range of the data
            this = max(this.Data) - min(this.Data);
        end
        
        function this = valChange(this)
            %Find the difference between the first and last values
            this = this.Data(end)-this.Data(1);
        end
        
        function this = timeshift(this,tShift)
            %Method for shifting a channel's time base.
            warning('off','MATLAB:linearinter:noextrap')
            this = resample(this,this.Time+tShift);
            this.Data(isnan(this.Data)) = 0;
            this.Time = this.Time-tShift;
            warning('on','MATLAB:linearinter:noextrap')
        end
        
        function this = derivative(this, varargin)
            %Method for computing derivative, W.R.T. time by default.
            if nargin == 1
                %Compute w.r.t. time base by default
                this.Data = [0; diff(this.Data)./diff(this.Time)];
            else
                %Otherwise it's slightly more complex
                ts2 = resample(varargin{1},this.Time);
                this.Data = [0; diff(this.Data)./diff(ts2.Data)];
            end
        end
        
        function this = integral(this, varargin)
            %Method for computing integral, W.R.T. time by default.
            %Argument 3 specifies only positive values be integrated with a
            %value of 2, and only negative values with a value of 1.
            if nargin == 3
                if varargin{2} == 1
                    this.Data(this.Data>0) = 0;
                elseif varargin{2} == 2
                    this.Data(this.Data<0) = 0;
                end
            end
            if nargin == 1
                %Compute w.r.t. time by default
                this.Data = cumtrapz(this.Time,this.Data);
            elseif ~isempty(varargin{1}) && nargin ~= 1
                %Otherwise it's slightly more complex
                ts2 = resample(varargin{1},this.Time);
                this.Data = cumtrapz(ts2.Data,this.Data);
            elseif isempty(varargin{1}) && nargin ~= 1
                this.Data = cumtrapz(this.Time,this.Data);
            end
        end
        
        function this = integralEnd(this, varargin)
            %End value of integral, W.R.T. time by default.
            if nargin == 1
                %Compute w.r.t. time by default
                this = this.integral;
            elseif nargin == 2
                %Otherwise it's slightly more complex
                this = this.integral(varargin{1});
            elseif nargin == 3
                %Otherwise it's slightly more complex
                this = this.integral(varargin{1},varargin{2});
            end
            this = this.Data(end);
        end
        
        function this = integralRange(this, ts,te)
            %End value of integral, W.R.T. time by default.
            tempSeries = getsampleusingtime(this,ts,te);
            %Compute w.r.t. time by default
            this = tempSeries.integral;
        end
        
        function this = filtButter(this,cutoff,order,type)
            %Method for implementing a simple butterworth filter.
            %Note: order doubles due to filtfilt.
            nyquist = (0.5/(this.Time(2)-this.Time(1)));
            this.Data(isnan(this.Data)) = 0;
            Wn = cutoff/nyquist;
            [b,a] = butter(order,Wn,type);
            %Use filtfilt to remove phase lag
            this.Data = filtfilt(b,a,this.Data);
        end
        
        function this = dataZero(this,varargin)
            %'Zero' data to a value at the mean between the offset indices.
            %Zeros to 0 by default.
            if nargin == 1
                zeroVal = 0;
            else
                zeroVal = varargin{1};
            end
            tempSeries = gettsbetweenevents(this,'DataOffsetStart','DataOffsetEnd');
            offset = tempSeries.mean;
            this.Data = this.Data+zeroVal-offset;
        end
        
        function this = dataOperator(this,operator)
            %Evaluate individual elements using standard function.
            this.Data = eval([operator '(this.Data);']);
        end
        
        function this = rmspike(this,order,varargin)
            %Removes big data spikes.  Repeats 'order' times.
            %Specify argument 3 as 'interp' to use interpolated value
            %Uses Chauvenet's criterion.
            if nargin == 2
                for i = 1:order
                    this.Data(this.pointProb.Data.*length(this.Data)<0.5) = 0;
                end
            elseif nargin == 3 && strcmp(varargin{1}, 'interp')
                for i = 1:order
                    this.Data(this.pointProb.Data.*length(this.Data)<0.5) = NaN;
                    this.Data(isnan(this.Data)) = interp1(find(~isnan(this.Data)), this.Data(~isnan(this.Data)), find(isnan(this.Data)));
                end
            end
        end
        
        function this = pointProb(this)
            %Calculates the probability of a given occurrence.
            prob = (1/(this.std*sqrt(2*pi)))*exp(-((this.Data-this.mean).^2)./(2*(this.std^2)));
            this.Data = prob;
            this.DataInfo.Units = 'none';
        end
        
        function this = eventsZero(this)
            %Zeros data at lap beacon crossings
            for i = 1:length(this.Events)
                if length(this.Events(i).Name)>=3
                    if strcmp(this.Events(i).Name(1:3), 'Lap')
                        timeInd = dsearchn(this.Time,this.Events(i).Time);
                        this.Data(timeInd:end) = this.Data(timeInd:end)-this.Data(timeInd);
                    end
                end
            end
        end
        
        function this = detrendPoly(this)
            %Fits a second order polynomial to 5s filtered values @beacon
            %and adds the offset to the signal.  Useful for integration
            %bias. Use with caution.
            
            j=1;
            %Build an array of offset values
            for i = 2:length(this.Events)-1
                if length(this.Events(i).Name)>=3
                    if strcmp(this.Events(i).Name(1:3), 'Lap')
                        offset(j) = interp1(this.Time,this.filtButter(0.2,3,'low').Data,this.Events(i).Time);
                        time(j) = this.Events(i).Time;
                        j=j+1;
                    end
                end
            end
            
            if j>2
                %Fit to a polynomial
                offsetPoly = polyfit(time,offset,2);
                offsetSeries = offsetPoly(1).*this.Time.^2 + offsetPoly(2).*this.Time + offsetPoly(3);
                
                %Apply to the data
                this.Data = this.Data-offsetSeries;
            else
                this = this.detrend('linear');
                disp('WARNING: Insufficient data to perform poly detrend.')
            end
            
        end
        
        function this = setRate(this,rate)
            % Set a sampling rate to the data.  Units in Hz.
            
            timeStart = this.Time(1);
            numbSamp  = floor((this.Time(end)-this.Time(1))*rate);
            timeEnd   = (numbSamp/rate)-((1-this.Time(1))/rate);
            
            this = resample(this,linspace(timeStart,timeEnd,numbSamp));
            
        end
        
        function this = rms(this,varargin)
            % Calculate the RMS value of a time-based signal
            if(nargin > 1)
                ts = varargin{1};
                te = varargin{2};
                this = getsampleusingtime(this,ts,te);
                this.Data = this.Data.^2;
            else
                this.Data = this.Data.^2;
            end
            
            % Square root of the integral of the squared signal divided by
            % the interval
            this = sqrt(((this.Time(end)-this.Time(1))^-1)*this.integralEnd);
            
        end
        
        function this = absMax(this,ts,te)
            % Calculate the absolute value of a time-based signal
            dat = getsampleusingtime(this,ts,te);
            this = max(abs(dat.Data));
        end
        
        function this = dataSamples(this,ts,te)
            %Compute the variance in a signal between the offset indices.
            tempSeries = getsampleusingtime(this,ts,te);
            %Detrend to flatten increasing signals and compute variance
            this = tempSeries.Data;
        end
        
        function this = plotXY(this,xData)
            xData =  resample(xData,this.Time);
            plot(xData.Data,this.Data);
            hold on
            for i = 1:length(this.Events)
                temp = getsampleusingtime(xData,this.Events(i).Time,this.Events(i).Time+1);
                x(i) = temp.Data(1);
                temp = getsampleusingtime(this,this.Events(i).Time,this.Events(i).Time+1);
                y(i) = temp.Data(1);
            end
            plot(x,y,'o');
        end
        
        function this = scatterXY(this,xData)
            xData =  resample(xData,this.Time);
            plot(xData.Data,this.Data,'*');
            hold on
            for i = 1:length(this.Events)
                temp = getsampleusingtime(xData,this.Events(i).Time,this.Events(i).Time+1);
                x(i) = temp.Data(1);
                temp = getsampleusingtime(this,this.Events(i).Time,this.Events(i).Time+1);
                y(i) = temp.Data(1);
            end
            plot(x,y,'o');
        end
        
    end
    
end