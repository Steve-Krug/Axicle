clear all
close all
clc

datastring = fileread('AxicleDeskTest1.log');
datastring = strjoin(regexp(datastring, '.*0x07.*', 'match', 'dotexceptnewline'));
m = '[2024-01-10T(.{12}).{27}(.{2})(.{2})(.{2})(.{2})(.{2})(.{2}).{14}(.{2})(.{2})(.{2})(.{2})(.{2})(.{2})';
datastring = regexprep(datastring, m, '$1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13', 'dotexceptnewline');
int8data = textscan(datastring, '%T %x %x %x %x %x %x %x %x %x %x %x %x');

intdata = [];

dps = 2000;
xlm = 8;

for i = 2:7
    
    intdata{i} = int64((int8data{(i-1)*2}+int8data{(i-1)*2+1}*256));
    intdata{i} = intdata{i} - int64((intdata{i}>32768)*65536);

end

time = int8data{1};
gyros = double([intdata{2}, intdata{3}, intdata{4}])*dps/32678;
accels = double([intdata{5}, intdata{6}, intdata{7}])*xlm/32678;


title('ASM330 Rate vs. Time')
plot(time, gyros)
legend('Raw Time')
xlabel('Time [s]')
ylabel('Rate [dps]')
