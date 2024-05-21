
ds = ["Empty 1, Tractor", "sbg_empty_v1.txt", "#0072BD", 2, "-";
      "Empty 1, Front", "nano1_empty_v1", "#0072BD", 2, ":";
      "Empty 1, Back", "nano2_empty_v1", "#0072BD", 2, "--";
      "Empty 2, Tractor", "sbg_empty_v2.txt", "#0072BD", .5, "-";
      "Empty 2, Front", "nano1_empty_v2", "#0072BD", .5, ":";
      "Empty 2, Back", "nano2_empty_v2", "#0072BD", .5, "--";
      "Full, Low CG 1, Tractor", "sbg_lowcg_highweight_v1.txt", "#D95319", 2, "-";
      "Full, Low CG 1, Front", "nano1_lowcg_highweight_v1", "#D95319", 2, ":";
      "Full, Low CG 1, Back", "nano2_lowcg_highweight_v1", "#D95319", 2, "--";
      "Full, Low CG 2, Tractor", "sbg_lowcg_highweight_v2.txt", "#D95319", .5, "-";
      "Full, Low CG 2, Front", "nano1_lowcg_highweight_v2", "#D95319", .5, ":";
      "Full, Low CG 2, Back", "nano2_lowcg_highweight_v2", "#D95319", .5, "--";
      "Full, High CG 1, Tractor", "sbg_highcg_highweight_v1.txt", "#EDB120", 2, "-";
      "Full, High CG 1, Front", "nano1_highcg_highweight_v2", "#EDB120", 2, ":";
      "Full, High CG 1, Back", "nano2_highcg_highweight_v2", "#EDB120", 2, "--";
      "Full, High CG 2, Tractor", "sbg_highcg_highweight_v3.txt", "#EDB120", .5, "-";
      "Full, High CG 2, Front", "nano1_highcg_highweight_v3", "#EDB120", .5, ":";
      "Full, High CG 2, Back", "nano2_highcg_highweight_v3", "#EDB120", .5, "--"];

tlo = tiledlayout(2,2);
tlo.TileSpacing = 'compact';
tlo.Padding = 'compact';

nexttile(1)
title("Roll Rate Frequencies")
xlabel('f (hz)')
ylabel('abs(fft(wx))')
ylim([0 70])
xlim([0.5 8])
grid on

nexttile(2)
title("Peak Roll Rate Frequency betwen 0.5hz and 5hz")
xlabel('t (s)')
ylabel('peak frequency (hz)')
xlim([0 550])
grid on

nexttile(3)
title("Vertical Acceleration Frequencies")
xlabel('f (hz)')
ylabel('abs(fft(az))')
ylim([0 20])
xlim([0.5 8])
grid on

nexttile(4)
title("Peak Vertical Acceleration Frequency betwen 0.5hz and 5hz")
xlabel('t (s)')
ylabel('peak frequency (hz)')
xlim([0 550])
grid on

wsize_t = 10.0;      % Window size for sliding FFT in seconds
wstep_t = 0.25;      % Step size for sliding window in seconds

for i = 1:length(ds(:,1))
    
    ts = readtable(ds(i,2), MissingRule="omitrow");

    if contains(ds(i,1), "Tractor")
        ts.Properties.VariableNames = {'ax', 'ay', 'az', 'wx', 'wy', 'wz', 'roll', 'pitch', 'yaw', 't', 'A', 'B'};
        ts.ax = ts.ax/-9.8;
        ts.ay = ts.ay/-9.8;
        ts.az = ts.az/-5.8;
    else
        ts.Properties.VariableNames = {'t', 'ax', 'ay', 'az', 'wx', 'wy', 'wz'};
        ts.t = (ts.t - ts.t(1))/1000;
    end

    ts.az = ts.az - 1;

    Fs = 1/mean(diff(ts.t));
    wsize = int64(wsize_t*Fs);
    wstep = int64(wstep_t*Fs);
    freqs = (Fs/double(wsize))*(0:double(wsize)-1);
    prange = [find(freqs > 0.5, 1), find(freqs > 5, 1)];

    wnum = floor((length(ts.t)-wsize)/wstep)-1;  % Number of windows for this timeseries
    swfft_r = zeros(wsize, 1);
    swfft_a = zeros(wsize, 1);
    peaks_r = zeros(wnum, 1);
    peaks_a = zeros(wnum, 1);
    for j = 1:wnum
        
        wstart = (j-1)*wstep + 1;

        wfft_r = abs(fft(hann(wsize).*ts.wx(wstart:wstart+wsize-1)));
        swfft_r = swfft_r + wfft_r/double(wnum);
        [blah, pind] = max(wfft_r(prange(1):prange(2)));
        peaks_r(j) = freqs(pind);

        wfft_a = abs(fft(hann(wsize).*ts.az(wstart:wstart+wsize-1)));
        swfft_a = swfft_a + wfft_a/double(wnum);
        [blah, pind] = max(wfft_a(prange(1):prange(2)));
        peaks_a(j) = freqs(pind);

    end

    peaks_r = movmean(peaks_r, 1000);
    peaks_a = movmean(peaks_a, 1000);

    nexttile(1)
    hold on
    plot(freqs,swfft_r, "Color", ds(i,3), "LineWidth", str2num(ds(i,4)), "LineStyle", ds(i,5));
    hold off

    nexttile(3)
    hold on
    plot(freqs,swfft_a, "Color", ds(i,3), "LineWidth", str2num(ds(i,4)), "LineStyle", ds(i,5));
    hold off

    nexttile(2)
    hold on
    plot(wstep_t*(1:length(peaks_r)), peaks_r, "Color", ds(i,3), "LineWidth", str2num(ds(i,4)), "LineStyle", ds(i,5));
    hold off

    nexttile(4)
    hold on
    plot(wstep_t*(1:length(peaks_r)), peaks_a, "Color", ds(i,3), "LineWidth", str2num(ds(i,4)), "LineStyle", ds(i,5));
    hold off

end

nexttile(1)
legend(ds(:,1))

nexttile(3)
legend(ds(:,1))

