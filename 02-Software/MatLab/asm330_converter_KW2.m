datastring = fileread('AxicleDeskTest1_short.log');
datastring = strjoin(regexp(datastring, '.*0x07.*', 'match', 'dotexceptnewline'));
m = '[2024-01-10T(.{12}).{27}(.{4})(.{4})(.{4}).{14}(.{4})(.{4})(.{4})';
datastring = regexprep(datastring, m, '$1 $2 $3 $4 $5 $6 $7', 'dotexceptnewline')
intdata = textscan(datastring, '%T %xu16 %xu16 %xu16 %xu16 %xu16 %xu16');

dps = 2000;
xlm = 8;

gyros = double([intdata{2}, intdata{3}, intdata{4}])*dps/32678;
accels = double([intdata{5}, intdata{6}, intdata{7}])*xlm/32678;

%load('AxicleDeskTest1_processed.mat')

%test = gyros_kw ./ gyros_dps;

%title('ASM330 Rate vs. Time')
%plot(time_s, gyros_dps)
%legend('Raw Time')
%xlabel('Time [s]')
%ylabel('Rate [dps]')