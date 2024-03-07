function tsout = times(ts1, ts2)
%TIMES  Overloaded element-by-element array multiply
%
%    TS1.*TS2: TS1 and TS2 must have the same length.  Their sample
%    sizes must be the same unless each sample in TS2 is a scalar.  
%    Note: the quality array of the output time series will be the
%    element-by-element minimum of the two quality arrays from TS1 and TS2.
%
%    TS1.*B: the sample size of time series TS1 and the size of B must be
%    the same unless B is a scalar. 
%
%    A.*TS1: the size of A and the sample size of time series TS1 must be
%    the same unless A is a scalar.  
%

%   Copyright 2004-2012 The MathWorks, Inc.

if isa(ts1,'timeseries')
    if numel(ts1)~=1
        error(message('MATLAB:timeseries:times:noarray'));
    end
    if isa(ts2,'timeseries')
        if numel(ts2)~=1
           error(message('MATLAB:timeseries:times:noarray'));
        end
        tsout = localtimes(ts1,ts2);
    elseif isnumeric(ts2) || islogical(ts2)
        % Use option 'false' for ts\N
        tsout = localtimes(ts1, ts2);
    else
        % Second input is not valid for operation
        error(message('MATLAB:timeseries:arith:typemix', class( ts2 )));
    end
else
    if isnumeric(ts1) || islogical(ts1)
        if numel(ts2)~=1
           error(message('MATLAB:timeseries:times:noarray'));
        end
        % Use option 'true' for N\ts
        tsout = localtimes(ts2,ts1);
    else
        error(message('MATLAB:timeseries:arith:typemix', class( ts1 )));
    end
end

function tsout = localtimes(ts1, ts2)


% TS1_OPR_TS2 case
if isa(ts2,'timeseries')
    % deal with time first
    [ts1 ts2] = synchronize(ts1,ts2,'Union');
    [commomTimeVector,outprops,warningFlag] = utArithCommonTime(ts1,ts2);
    % deal with empty object: return an empty ts which is consistent with
    % Matlab command 2+[], 2./[] etc.
    if isempty(commomTimeVector)
        tsout = timeseries;
        return
    end
    
    % If the IsTimeFirst properties of the two timeseries are different,
    % the output timeseries defaults to IsTimeFirst == true   
    if ts1.IsTimeFirst == ts2.IsTimeFirst
        tsout = ts1;
        if ts1.DataInfo.isstorage
            try
                tsout.DataInfo = times(ts1.DataInfo,ts2.DataInfo);
            catch %#ok<*CTCH>
                [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(ts1.DataInfo,ts2.DataInfo,ts1.Data,ts2.Data);
            end
        else
            [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(ts1.DataInfo,ts2.DataInfo,ts1.Data,ts2.Data);
        end
        %tsout.DataInfo = times(ts1.DataInfo,ts2.DataInfo);
    else
        % due to deprecation of IsTimeFirst,
        % transpose function cannot be used any more. will error out
        error(message('MATLAB:timeseries:arith:timeDimMismatch'));  
    end
    tsout.Name = 'unnamed';
    tsout.Quality = [];
    tsout.TimeInfo.StartDate = outprops.ref;
    tsout.TimeInfo.Units = outprops.outunits;
    tsout.TimeInfo.Format = outprops.outformat;
    
    % Build output time series. 
    tsout = timeseries.utarithcommonoutput(ts1,ts2,tsout,warningFlag);
% A_OPR_TS1 case or TS1_OPR_B case
elseif isnumeric(ts2) || islogical(ts2)
    commomTimeVector = ts1.Time;
    
    % deal with empty object: return an empty ts which is consistent with
    % Matlab command 2+[], 2./[] etc.
    if isempty(commomTimeVector)
        tsout = timeseries;
        return
    end
    tsout = ts1;
    
    % Duplicate non-scalar numeric inputs over each sample (see command
    % line help for TS1.*B or A.*TS1)
    if ~isscalar(ts2)
        if ts1.IsTimeFirst
            if ts1.DataInfo.isstorage
                try
                    tsout.DataInfo = times(ts1.DataInfo,reshape(repmat(ts2,ts1.Length,1),size(ts1.Data)));
                catch
                    [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(...
                        ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,ts1.Length,1),size(ts1.Data))); 
                end
            else
                [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(...
                    ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,ts1.Length,1),size(ts1.Data)));
            end
            %tsout.DataInfo = times(ts1.DataInfo,reshape(repmat(ts2,ts1.Length,1),size(ts1.Data)));
        else
            if ts1.DataInfo.isstorage
                try
                   tsout.DataInfo = times(ts1.DataInfo,reshape(repmat(ts2,1,ts1.Length),size(ts1.Data)));
                catch
                    [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(...
                        ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,1,ts1.Length),size(ts1.Data)));          
                end
            else
               [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(...
                   ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,1,ts1.Length),size(ts1.Data)));
            end
            %tsout.DataInfo = times(ts1.DataInfo,reshape(repmat(ts2,1,ts1.Length),size(ts1.Data)));
        end        
    else
        if ts1.DataInfo.isstorage
            try
              tsout.DataInfo = times(ts2,ts1.DataInfo);
            catch
                [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(...
                        [],ts1.DataInfo,ts2,ts1.Data);    
            end
        else
           [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaulttimes(...
                [],ts1.DataInfo,ts2,ts1.Data);
        end
        %tsout.DataInfo = times(ts2,ts1.DataInfo);
    end
end
tsout.Time = commomTimeVector;
