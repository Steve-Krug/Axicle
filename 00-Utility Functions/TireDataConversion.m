close all;
clear all;

fid=fopen('d:\MichelinPrimacyMXM4_62.tir');
input=textscan(fid,'%s %s %s %s %s %*[^\n]','MultipleDelimsAsOne', 1); 
fclose(fid);
clear fid;

names=input{1,1};
extra=input{1,2};
values=input{1,3};

renameMatrix={
    'R0','UNLOADED_RADIUS';    
    'FNOMIN','FNOMIN';
    'CZ','VERTICAL_STIFFNESS';
    'KZ','VERTICAL_DAMPING';
    'BREFF','BREFF';
    'DREFF','DREFF';
    'FREFF','FREFF';
    'LCX','LCX';
    'LMUX','LMUX';
    'LEX','LEX';
    'LKX','LKX';
    'LHX','LHX';
    'LVX','LVX';
    'LCY','LCY';
    'LMUY','LMUY';
    'LEY','LEY';
    'LKY','LKY';
    'LHY','LHY';
    'LVY','LVY';
    'LTR','LTR';
    'LRES','LRES';
    'LXAL','LXAL';
    'LYKA','LYKA';
    'LVYKA','LVYKA';
    'LS','LS';
    'LMX','LMX';
    'LVMX','LVMX';
    'LMY','LMY';
    'PCX1','PCX1';
    'PDX1','PDX1';
    'PDX2','PDX2';
    'PDX3','PDX3';
    'PEX1','PEX1';
    'PEX2','PEX2';
    'PEX3','PEX3';
    'PEX4','PEX4';
    'PKX1','PKX1';
    'PKX2','PKX2';
    'PKX3','PKX3';
    'PHX1','PHX1';
    'PHX2','PHX2';
    'PVX1','PVX1';
    'PVX2','PVX2';
    'RBX1','RBX1';
    'RBX2','RBX2';
    'RBX3','RBX3';
    'RCX1','RCX1';
    'REX1','REX1';
    'REX2','REX2';
    'RHX1','RHX1';
    'PCY1','PCY1';
    'PDY1','PDY1';
    'PDY2','PDY2';
    'PDY3','PDY3';
    'PEY1','PEY1';
    'PEY2','PEY2';
    'PEY3','PEY3';
    'PEY4','PEY4';
    'PEY5','PEY5';
    'PKY1','PKY1';
    'PKY2','PKY2';
    'PKY3','PKY3';
    'PKY4','PKY4';
    'PKY5','PKY5';
    'PKY6','PKY6';
    'PKY7','PKY7';
    'PHY1','PHY1';
    'PHY2','PHY2';
    'PVY1','PVY1';
    'PVY2','PVY2';
    'PVY3','PVY3';
    'PVY4','PVY4';
    'RBY1','RBY1';
    'RBY2','RBY2';
    'RBY3','RBY3';
    'RCY1','RCY1';
    'REY1','REY1';
    'REY2','REY2';
    'RHY1','RHY1';
    'RHY2','RHY2';
    'RVY1','RVY1';
    'RVY2','RVY2';
    'RVY3','RVY3';
    'RVY4','RVY4';
    'RVY5','RVY5';
    'RVY6','RVY6';
    'QBZ1','QBZ1';
    'QBZ2','QBZ2';
    'QBZ3','QBZ3';
    'QBZ4','QBZ4';
    'QBZ5','QBZ5';
    'QBZ9','QBZ9';
    'QBZ10','QBZ10';
    'QCZ1','QCZ1';
    'QDZ1','QDZ1';
    'QDZ2','QDZ2';
    'QDZ3','QDZ3';
    'QDZ4','QDZ4';
    'QDZ6','QDZ6';
    'QDZ7','QDZ7';
    'QDZ8','QDZ8';
    'QDZ9','QDZ9';
    'QEZ1','QEZ1';
    'QEZ2','QEZ2';
    'QEZ3','QEZ3';
    'QEZ4','QEZ4';
    'QEZ5','QEZ5';
    'QHZ1','QHZ1';
    'QHZ2','QHZ2';
    'QHZ3','QHZ3';
    'QHZ4','QHZ4';
    'SSZ1','SSZ1';
    'SSZ2','SSZ2';
    'SSZ3','SSZ3';
    'SSZ4','SSZ4';
    'QSX1','QSX1';
    'QSX2','QSX2';
    'QSX3','QSX3';
    'QSY1','QSY1';
    'QSY2','QSY2';
    'QSY3','QSY3';
    'QSY4','QSY4'};


for i=1:size(renameMatrix,1)
    newMatrix{i,:}=[renameMatrix{i,1},'=',values{strmatch(renameMatrix{i,2},names,'exact')},','];
end

% side=extra{strmatch('TYRESIDE',names,'exact')};
% if strmatch(side,'=''Right''')
    newMatrix{i+1,:}=['left_wheel=false,'];
% else
%     newMatrix{i+1,:}=['left_wheel=true,'];
% end

% tire=input{1,5}{9};    %tyre_dimension={245,70,15},
% newMatrix{i+2,:}=['tyre_dimension={',tire(1:3),',',tire(5:6),',',tire(8:9),'},'];

for i=1:size(newMatrix,1)
    disp(newMatrix{i,:})
end


