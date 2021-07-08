function [data] = montecarlo_processing_v1(x, fs, winh, noverlap, nfft, col)
%montecarlo_processing_v1.m


sim_data = load('L:\SEIT Departmental\Systems Engineering\Separation Analysis\Stage Separation\Outputs\13_Aug_2018_17_24_StageSep_Qual\13_Aug_2018_17_24_StageSep_Qual_DATA.mat');


for i = 1:length(Seat_Vibration_Data)
    sdev_dtsky_comfort(i) = std([Seat_Vibration_Data(i,2) Seat_Vibration_Data(i,4) Seat_Vibration_Data(i,6) Seat_Vibration_Data(i,8) Seat_Vibration_Data(i,10) Seat_Vibration_Data(i,12)]);
    avg_dtsky_comfort(i) = mean([Seat_Vibration_Data(i,2) Seat_Vibration_Data(i,4) Seat_Vibration_Data(i,6) Seat_Vibration_Data(i,8) Seat_Vibration_Data(i,10) Seat_Vibration_Data(i,12)]);
end

% plot(Seat_Vibration_Data(:,1),avg_dtsky_comfort, 'g', 'LineWidth', 2)
lower = (avg_dtsky_comfort-sdev_dtsky_comfort);
upper = (avg_dtsky_comfort+sdev_dtsky_comfort);
avg_dtsky_comfort = (avg_dtsky_comfort);
loglog(Seat_Vibration_Data(:,1), avg_dtsky_comfort, 'r');

X = [(Seat_Vibration_Data(:,1))'; (Seat_Vibration_Data(:,1))']; %2 rows, by length of signal, (x-axis values)
Y = [upper; lower;]; %2 rows, upper and lower standard deviation bounds
h_area = fill(X,Y,'r');
set(h_area, 'edgealpha', 0.1, 'edgecolor', 'r');
data = Y; %jk
end