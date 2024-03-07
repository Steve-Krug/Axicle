function [RMSE,peakErr] = timeSeriesRMSError(ts,tsref)
if ts.Time(end) < tsref.Time(end) % Pick resample direction depending on length
    tsref = resample(tsref,ts.Time);
else
    ts = resample(ts,tsref.Time);
end
RMSE = sqrt(sum((ts.Data-tsref.Data).^2/length(tsref.Data)));
peakErr = max(abs(ts.Data-tsref.Data));