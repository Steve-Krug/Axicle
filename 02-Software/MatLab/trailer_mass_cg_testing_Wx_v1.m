% trailer_mass_cg_testing_v1.m
% Notes: for Wx


clear all
close all
clc

sg_order = 2;
sg_framelength = 401;

 
%Full weight high cg
config1_sbg = {'sbg_highcg_highweight_v1.txt'; 'sbg_highcg_highweight_v2.txt'; 'sbg_highcg_highweight_v3.txt';};
config1_n1 = {'nano1_highcg_highweight_v1';'nano1_highcg_highweight_v2';'nano1_highcg_highweight_v3';};
config1_n2 = {'nano2_highcg_highweight_v1';'nano2_highcg_highweight_v2';'nano2_highcg_highweight_v3';};
%Front only high cg
config2_sbg = {'sbg_frontOnly_v1.txt'; 'sbg_frontOnly_v2.txt';};
config2_n1  = {'nano1_frontOnly_v1';'nano1_frontOnly_v2';};
config2_n2 = {'nano2_frontOnly_v1';'nano2_frontOnly_v1';};
%Empty
config3_sbg = {'sbg_empty_v1.txt'; 'sbg_empty_v2.txt';};
config3_n1 = {'nano1_empty_v1';'nano1_empty_v2';};
config3_n2 = {'nano2_empty_v1';'nano2_empty_v1';};
%Front only low cg
config4_sbg = {'sbg_frontOnly_Low_v1.txt';};
config4_n1 = {'nano1_FrontOnlyLow_v1';};
config4_n2 = {'nano2_FrontOnlyLow_v1';};
%Full weight low cg
config5_sbg = {'sbg_lowcg_highweight_v1.txt'; 'sbg_lowcg_highweight_v2.txt';};
config5_n1 = {'nano1_lowcg_highweight_v1';'nano1_lowcg_highweight_v2';};
config5_n2 = {'nano2_lowcg_highweight_v1';'nano2_lowcg_highweight_v2';};

%All runs config1
for i_1 = 1:length(config1_sbg)
    sbg_1{i_1} = readtable(string(config1_sbg(i_1)));
    n1_1{i_1} = readtable(string(config1_n1(i_1)));
    n2_1{i_1} = readtable(string(config1_n2(i_1)));
end

%All runs config2
for i_1 = 1:length(config2_sbg)
    sbg_2{i_1} = readtable(string(config2_sbg(i_1)));
    n1_2{i_1} = readtable(string(config2_n1(i_1)));
    n2_2{i_1} = readtable(string(config2_n2(i_1)));
end

%All runs config3
for i_1 = 1:length(config3_sbg)
    sbg_3{i_1} = readtable(string(config3_sbg(i_1)));
    n1_3{i_1} = readtable(string(config3_n1(i_1)));
    n2_3{i_1} = readtable(string(config3_n2(i_1)));
end

%All runs config4
for i_1 = 1:length(config4_sbg)
    sbg_4{i_1} = readtable(string(config4_sbg(i_1)));
    n1_4{i_1} = readtable(string(config4_n1(i_1)));
    n2_4{i_1} = readtable(string(config4_n2(i_1)));
end

%All runs config5
for i_1 = 1:length(config5_sbg)
    sbg_5{i_1} = readtable(string(config5_sbg(i_1)));
    n1_5{i_1} = readtable(string(config5_n1(i_1)));
    n2_5{i_1} = readtable(string(config5_n2(i_1)));
end

ts = .009;
fs = 1/ts;
figure(1)

for j = 1:length(n1_1)
    n1_1{1,j}.Var5(isnan(n1_1{1,j}.Var5)) = 0;
    [freq{j}, mag{j}, phase] = fft_lite_v2(fs, n1_1{1,j}.Var5);
    
    mag_iso_1(j) = timeAveWeighted( iso_wk(n1_1{1,j}.Var5, fs),fs);
    
    sgf_1{j} = sgolayfilt(mag{1,j}, sg_order, sg_framelength );

    indices = find(freq{j} > 0.5);
    sg1(:,j) = sgf_1{j}(indices(1):indices(1)+10000);
    fs1(:,j) = freq{j}(indices(1):indices(1)+10000);

    figure(1)
    % plot(freq{j}, mag{j}, 'k');
    plot(freq{j}, sgf_1{j}, 'r')
    hold on
    ylabel('amplitude')
    xlabel('freq [hz]')
    ylim([0 300])
    xlim([0 20])
    Plotter(1);
end



for j = 1:length(n1_2)
    n1_2{1,j}.Var5(isnan(n1_2{1,j}.Var5)) = 0;
    [freq{j}, mag{j}, phase] = fft_lite_v2(fs, n1_2{1,j}.Var5);
    mag_iso_2(j) = timeAveWeighted( iso_wk(n1_2{1,j}.Var5, fs),fs);

    sgf_2{j} = sgolayfilt(mag{1,j}, sg_order, sg_framelength );

    indices = find(freq{j} > 0.5);
    sg2(:,j) = sgf_2{j}(indices(1):indices(1)+10000);
    fs2(:,j) = freq{j}(indices(1):indices(1)+10000);

    figure(1)
    plot(freq{j}, sgf_2{j}, 'k');
    hold on
    ylabel('amplitude')
    xlabel('freq [hz]')
    ylim([0 300])
    xlim([0 20])
    Plotter(1);
end

for j = 1:length(n1_3)
    n1_3{1,j}.Var5(isnan(n1_3{1,j}.Var5)) = 0;
    [freq{j}, mag{j}, phase] = fft_lite_v2(fs, n1_3{1,j}.Var5);
    mag_iso_3(j) = timeAveWeighted( iso_wk(n1_3{1,j}.Var5, fs),fs);

    sgf_3{j} = sgolayfilt(mag{1,j}, sg_order, sg_framelength );

    indices = find(freq{j} > 0.5);
    sg3(:,j) = sgf_3{j}(indices(1):indices(1)+10000);
    fs3(:,j) = freq{j}(indices(1):indices(1)+10000);

    figure(1)
    plot(freq{j}, sgf_3{j}, 'g');
    hold on
    ylabel('Amplitude Prevalence')
    xlabel('Freq [Hz]')
    ylim([0 300])
    xlim([.1 20])
    Plotter(1);
end

for j = 1:length(n1_4)
    n1_4{1,j}.Var5(isnan(n1_4{1,j}.Var5)) = 0;
    [freq{j}, mag{j}, phase] = fft_lite_v2(fs, n1_4{1,j}.Var5);
    mag_iso_4(j) = timeAveWeighted( iso_wk(n1_4{1,j}.Var5, fs),fs);

    sgf_4{j} = sgolayfilt(mag{1,j}, sg_order, sg_framelength );

    indices = find(freq{j} > 0.5);
    sg4(:,j) = sgf_4{j}(indices(1):indices(1)+10000);
    fs4(:,j) = freq{j}(indices(1):indices(1)+10000);

    figure(1)
    plot(freq{j}, sgf_4{j}, 'm');
    hold on
    ylabel('Amplitude Prevalence')
    xlabel('Freq [Hz]')
    ylim([0 300])
    xlim([.1 20])
    Plotter(1);
end

for j = 1:length(n1_5)
    n1_5{1,j}.Var5(isnan(n1_5{1,j}.Var5)) = 0;
    [freq{j}, mag{j}, phase] = fft_lite_v2(fs, n1_5{1,j}.Var5);
    mag_iso_5(j) = timeAveWeighted( iso_wk(n1_5{1,j}.Var5, fs),fs);

    sgf_5{j} = sgolayfilt(mag{1,j}, sg_order, sg_framelength );

    indices = find(freq{j} > 0.5);
    sg5(:,j) = sgf_5{j}(indices(1):indices(1)+10000);
    fs5(:,j) = freq{j}(indices(1):indices(1)+10000);

    figure(1)
    plot(freq{j}, sgf_5{j}, 'b');
    hold on
    title('Nano1 Wx: All Runs, SGolay Filter')
    ylabel('Amplitude Prevalence')
    xlabel('Freq [Hz]')
    ylim([0 600])
    xlim([.3 20])
    Plotter(1);
end

mean_sg1 = mean(sg1,2);
mean_fs1 = mean(fs1,2);
mean_sg2 = mean(sg2,2);
mean_fs2 = mean(fs2,2);
mean_sg3 = mean(sg3,2);
mean_fs3 = mean(fs3,2);
mean_sg4 = mean(sg4,2);
mean_fs4 = mean(fs4,2);
mean_sg5 = mean(sg5,2);
mean_fs5 = mean(fs5,2);


figure(2)
hold on
title('Nano1 Wx: All Runs, SG Filter, Runs Averaged')
plot(mean_fs1, mean_sg1, 'r')
plot(mean_fs2, mean_sg2, 'k')
plot(mean_fs3, mean_sg3, 'g')
plot(mean_fs4, mean_sg4, 'm')
plot(mean_fs5, mean_sg5, 'b')
ylim([0 600])
legend('Full, High','Front, High','Empty','Front, Low','Full, Low')
 ylabel('Amplitude Prevalence')
    xlabel('Freq [Hz]')
Plotter(1);

% [Xfft,ws] = fft_easy(xt,ts,varargin);






