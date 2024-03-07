function tsout = mtimes(ts1,ts2)
%MTIMES  Overloaded 2-D matrix multiply.
%
%    TS1*TS2: TS1 and TS2 must have the same length. The number of columns
%    of TS1.Data and the number of rows of TS2.Data must be the same unless
%    each sample in TS2 is a scalar.   
%    Note: the quality array of the output time series will be the
%    element-by-element minimum of the two quality arrays from TS1 and TS2.
%
%    TS1*B: the number of columns of TS1.Data and the number of rows of B
%    must be the same unless B is scalar.  
%
%    A*TS1: the number of columns of A and the number of rows of TS1.Data
%    must be the same unless A is scalar.   
%

%   Copyright 2004-2012 The MathWorks, Inc.

if isa(ts1,'timeseries')
    if numel(ts1)~=1
        error(message('MATLAB:timeseries:mtimes:noarray'));
    end
    if isa(ts2,'timeseries')
        if numel(ts2)~=1
           error(message('MATLAB:timeseries:mtimes:noarray'));
        end
        tsout = localmtimes(ts1,ts2);
    elseif isnumeric(ts2) || islogical(ts2)
        % Use option 'false' for ts\N
        tsout = localmtimes(ts1, ts2, false);
    else
        % Second input is not valid for operation
        error(message('MATLAB:timeseries:arith:typemix', class( ts2 )));
    end
else
    if isnumeric(ts1) || islogical(ts1)
        if numel(ts2)~=1
           error(message('MATLAB:timeseries:mtimes:noarray'));
        end
        % Use option 'true' for N\ts
        tsout = localmtimes(ts2,ts1,true);
    else
        error(message('MATLAB:timeseries:arith:typemix', class( ts1 )));
    end
end

function tsout = localmtimes(ts1,ts2,varargin)

% A_OPR_TS1 case or TS1_OPR_B case
if nargin==3
    isArrayFirst = varargin{1};
% TS1_OPR_TS2 case
else
    isArrayFirst = false;
end
% TS1_OPR_TS2 case
if isa(ts2,'timeseries')
    % Deal with time first
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
                tsout.DataInfo = mtimes(ts1.DataInfo,ts2.DataInfo);
            catch %#ok<*CTCH>
                [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(ts1.DataInfo,ts2.DataInfo,ts1.Data,ts2.Data);
            end
        else
            [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(ts1.DataInfo,ts2.DataInfo,ts1.Data,ts2.Data);
        end
        %tsout.DataInfo = mtimes(ts1.DataInfo,ts2.DataInfo);
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
    % line help for TS1*B or A*TS1)
    if isscalar(ts2)
        if ~isArrayFirst
            if ts1.DataInfo.isstorage
               try
                   tsout.DataInfo = mtimes(ts1.DataInfo,ts2,...
                      ts1.IsTimeFirst);
               catch
                    [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                        ts1.DataInfo,[],ts1.Data,ts2,ts1.IsTimeFirst);
               end
            else              
               [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                   ts1.DataInfo,[],ts1.Data,ts2,ts1.IsTimeFirst);
            end
%             tsout.DataInfo = mtimes(ts1.DataInfo,ts2,...
%                 ts1.IsTimeFirst);
        else
            if ts1.DataInfo.isstorage
               try
                    tsout.DataInfo = mtimes(ts2,ts1.DataInfo,...
                       ts1.IsTimeFirst);
               catch
                     [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                        [],ts1.DataInfo,ts2,ts1.Data,ts1.IsTimeFirst);  
               end
            else
                [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                    [],ts1.DataInfo,ts2,ts1.Data,ts1.IsTimeFirst);
            end
%             tsout.DataInfo = mtimes(ts2,ts1.DataInfo,...
%                 ts1.IsTimeFirst);
        end
    else
        if ~isArrayFirst
            if ts1.IsTimeFirst
                if ts1.DataInfo.isstorage
                    try
                        tsout.DataInfo = mtimes(ts1.DataInfo,reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),...
                           ts1.IsTimeFirst  ); 
                    catch
                        [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                            ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),...
                            ts1.IsTimeFirst);                        
                    end
                else
                   [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                    ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),...
                    ts1.IsTimeFirst);
                end
%                 tsout.DataInfo = mtimes(ts1.DataInfo,reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),...
%                     ts1.IsTimeFirst  );
            else
                if ts1.DataInfo.isstorage
                    try
                        tsout.DataInfo = mtimes(ts1.DataInfo,reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),...
                          ts1.IsTimeFirst  ); 
                    catch
                        [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                            ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),...
                            ts1.IsTimeFirst); 
                    end
                else                   
                    [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                        ts1.DataInfo,[],ts1.Data,reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),...
                        ts1.IsTimeFirst);
                end
%                 tsout.DataInfo = mtimes(ts1.DataInfo,reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),...
%                     ts1.IsTimeFirst  );
            end        
        else        
            if ts1.IsTimeFirst
                if ts1.DataInfo.isstorage
                    try
                        tsout.DataInfo = mtimes(reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),ts1.DataInfo,...
                           ts1.IsTimeFirst  );
                    catch
                        [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                            [],ts1.DataInfo,reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),ts1.Data,...
                            ts1.IsTimeFirst); 
                    end
                else                   
                    [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                        [],ts1.DataInfo,reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),ts1.Data,...
                        ts1.IsTimeFirst); 
                end
%                 tsout.DataInfo = mtimes(reshape(repmat(ts2,ts1.length,1),size(ts1.Data)),ts1.DataInfo,...
%                     ts1.IsTimeFirst  );
            else
                if ts1.DataInfo.isstorage
                    try
                        tsout.DataInfo = mtimes(reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),ts1.DataInfo,...
                            ts1.IsTimeFirst  ); 
                    catch
                          [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                            [],ts1.DataInfo,reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),ts1.Data,...
                            ts1.IsTimeFirst); 
                    end
                else                 
                 [tsout.DataInfo,tsout.Data] = tsdata.datametadata.defaultmtimes(...
                    [],ts1.DataInfo,reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),ts1.Data,...
                    ts1.IsTimeFirst);
                end
%                 tsout.DataInfo = mtimes(reshape(repmat(ts2,1,ts1.length),size(ts1.Data)),ts1.DataInfo,...
%                     ts1.IsTimeFirst  );
            end    
        end   
    end
end
tsout.Time = commomTimeVector;
