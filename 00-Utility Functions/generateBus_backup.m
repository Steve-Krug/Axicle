% The original file is version controlled in GIT at C:\TeslaGit\firmware\components\driveInverter\DI\DM\sil\matlab
% This is an alternative copy for those who may not have checked out the above.

function generateBus(filepath, filename) 

wholeFile = fileread(fullfile(filepath, filename));

C = textscan(wholeFile, '%s', 'Delimiter','');
C = C{1};
k=0;
Cells=C;
%%remove cells with comments 
 for i=1:length(Cells)
    A=regexp(Cells{i}, '[ ;]', 'split');

    if strncmpi(A{1},'/',1) || strncmpi(A{1},'*',1) 
      
        C(k+i)=[];
        k=k-1;
    end
    
 end
 
%Find structure start
struct_start =find(ismember(C, 'typedef struct')) +1;

%Find structure end and name
k=1;
for i=1:length(C)
    A=regexp(C{i}, '[ ;]', 'split');
    if (A{1}=='}')
        if (length(A)==3)
        struct_end(k)=i;
        struct_name(k)={A{2}};
        k=k+1;
        end
    end
end
struct_lengths=struct_end'-struct_start;

%Parse variable data type and name
for i=1:length(struct_start)
    k=1;
    for j=1:struct_lengths(i)-1
        
        A=regexp(C{struct_start(i)+j}, '[ ;]', 'split');
        
        k=k+1;
        Type(i,j)={A{1}};
        Name(i,j)={A{2}};
        
    end
end

%Create Bus
for i=1:length(struct_start)
    for j=1:struct_lengths(i)-1
        elems(j) = Simulink.BusElement;
        elems(j).Name = Name{i,j};
        elems(j).Dimensions = 1;
        elems(j).DimensionsMode = 'Fixed';
        elems(j).DataType = Type{i,j};
        elems(j).SampleTime = -1;
        elems(j).Complexity = 'real';
        elems(j).SamplingMode = 'Sample based';
        elems(j).Min = [];
        elems(j).Max = [];
        elems(j).DocUnits = '';
        elems(j).Description = '';   
    end
    
    h = Simulink.Bus;
    h.HeaderFile = filename;
    h.Description = sprintf('Firmware input or output data structure');
    h.DataScope = 'Auto';
    h.Alignment = -1;
    h.Elements = elems;
    assignin('base',struct_name{i}, h)
    clear elems
end