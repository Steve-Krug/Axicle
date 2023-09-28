function [outputData] = timeAlignData(inputData, timeStep, timeRangeSignal)

% FIXME create master time based on rate and length of trace

sigList = fieldnames(inputData);
masterTimeSeries = min(inputData.(timeRangeSignal)(:,1)):timeStep:max(inputData.(timeRangeSignal)(:,1));
maximum_time_error_snap = 1; % FIXME this should be replaced by asymmetric snap
%% Process Signals to match time steps and combine into single file     
for signum = 1:1:length(sigList)
    
    % FIXME this should time align only in negative time, should not snap
    % to future times
                a = masterTimeSeries; % input master time from this particular trace
                a = a(1,:); % take only time column
                b_full = inputData.(cell2mat(sigList(signum))); % input signal
                b_full = transpose(b_full);
                b = b_full(1,:); % take time column from signal

                m = size(a,2); n = size(b,2);
                [c,p] = sort([a,b]);
                q = 1:m+n; q(p) = q;
                t = cumsum(p>m);
                r = 1:n; r(t(q(m+1:m+n))) = r;
                s = t(q(1:m));
                id = r(max(s,1));
                iu = r(min(s+1,n));
                [d,it] = min([abs(a-b(id));abs(b(iu)-a)]);
                ib = id+(it-1).*(iu-id);
                % apply values from sigtoprocess->b->combined_signal_output
                signal_output_untransposed = (b_full(2,ib));
 
                % apply time to first column
                signal_output(:,1) = a(1,:);
                
                % for time deltas greater than threshold, NaN the values
                signal_output_untransposed(:,d>maximum_time_error_snap) = NaN;
                signal_output(:,2) = transpose(signal_output_untransposed);%untransposed_output);


 
                % for locations without specific time steps, assume value of last time step
                sig_output_time_sorted = 1:1:length(signal_output);
                sig_output_time_sorted = transpose(sig_output_time_sorted);
                sig_output_time_sorted(:,2:3) = signal_output(:,(1:2)); % apply time and signal value
                sig_output_time_sorted = sortrows(sig_output_time_sorted,1);

                % apply previous value for times with no signal
                for n = 2:length(sig_output_time_sorted)
                    if isnan(sig_output_time_sorted(n,3)) == 1
                        sig_output_time_sorted(n,3) = sig_output_time_sorted(n-1,3);
                    end 
                end    
 

           

            sig_output_time_sorted(:,1) = [];
        outputData.(cell2mat(sigList(signum))) = sig_output_time_sorted;
end