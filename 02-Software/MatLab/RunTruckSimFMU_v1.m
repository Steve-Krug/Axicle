%% RunTruckSimFMU_v1.m
% 5/17/23
% S. Krug
% Notes:
%
%
%\
clear
clc
close

for i=0:2000:10000
    % foundBlock = find_system(gcb, 'BlockType', 'Constant', 'Name', 'Constant');
    model = 'batch_iteration_SL';
    load_system(model)

    blockPath = [model '/Constant'];

    % objParam = get_param(foundBlock{1}, 'ObjectParameters')

    set_param(blockPath, 'Constant', 'i');
    sim('batch_iteration_SL');
end


% N = 25;
% simOut = repmat(Simulink.SimulationOutput, N, 1);
% for i = 1:N
%     simOut(i) = sim('RolloverFMU1', 'timeout', 1000);
% end
% model = 'RolloverFMU1';
% load_system(model)

% blockPath = [model '/Constant'];
% parameterName = 'Constant value';
% parameterValue = 5000;
% 
% set_param(blockPath, parameterName, num2str(parameterValue));
% save(system(model))

% hws = get_param(bdroot, 'ModelWorkspace');
% imp_m_pl = 5000;
% set_param('RolloverFMU1/FMU', 'imp_m_pl','5000')

% simOut = sim('RolloverFMU1','SimulationMode','normal',...
%             'SaveState','on','StateSaveName','xout',...
%             'SaveOutput','on','OutputSaveName','yout',...
%             'SaveFormat', 'Dataset');
% outputs = simOut.yout;



