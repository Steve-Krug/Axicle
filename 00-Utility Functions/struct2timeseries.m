function tsout = struct2timeseries(structin,limitedStruct)
fn = fieldnames(structin);
lengthLimited = size(limitedStruct.Elements,1);
fl = {};
for i = 1:lengthLimited
    fl{i,1} = limitedStruct.Elements(i).Name; % Create cell array of bus element names
end
fl2 = cell2struct(fl,fl,1); % Create structure to be able to use isfield below
for f = 1:length(fl)
    if isfield(structin,fl(f)) % Check to make sure field exists
        tsout.(fl{f}) = timeseries(structin.(fl{f})(:,2),structin.(fl{f})(:,1),'Name',fl{f}); % timeseries(data,time,'Name',name)
    elseif strcmp(fl(f),'AY_A1_CH') % Use alternative if AY_A1_CH is missing from structin
        try
            tsout.(fl{f}) = timeseries(structin.A1_CH(:,2),structin.A1_CH(:,1),'Name',fl{f});
        catch
            tsout.(fl{f}) = timeseries(structin.RCM_lateralAcceleration(:,2),structin.RCM_lateralAcceleration(:,1),'Name',fl{f});
        end
        warning('Used alternative for AY_A1_CH. Check struct2timeseries.m if this is unexpected.')
    elseif strcmp(fl(f),'AX_A2_CH') % Use alternative if AX_A2_CH is missing from structin
        try
            tsout.(fl{f}) = timeseries(structin.A2_CH(:,2),structin.A2_CH(:,1),'Name',fl{f});
        catch
            tsout.(fl{f}) = timeseries(structin.RCM_longitudinalAcceleration(:,2),structin.RCM_longitudinalAcceleration(:,1),'Name',fl{f});
        end
        warning('Used alternative for AX_A2_CH. Check struct2timeseries.m if this is unexpected.')
    else
        tsout.(fl{f}) = timeseries([0],[0],'Name',fl{f});
    end
end