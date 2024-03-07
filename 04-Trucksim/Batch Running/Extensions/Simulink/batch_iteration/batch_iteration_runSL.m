%% Batch Iteration Testm
% 5/26/23
% S. Krug
% Notes:
%
%
%\
clc
clear
close all


kilogram = 15000; %kg
cgheight = 1500; %mm


for k = 1:4
    

% Extensions\Simulink\batch_iteration\batch_iteration_SWD_SL.mdl

    kilogram = kilogram + 500;

    cgheight = cgheight + 250;


    block1 = getfullname(Simulink.findBlocks('batch_iteration_SL'));
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'j');
    % objParam1 = get_param(foundBlock{1}, 'ObjectParameters');
    % objParam2 = get_param(foundBlock{2}, 'ObjectParameters');
    
    
    set_param(block1{1,1}, 'Value', 'kilogram');
    set_param(block1{2,1}, 'Value', 'cgheight');
   
    
    sim('batch_iteration_SL');


    
end
