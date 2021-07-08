function [f]=initialize_fig(figName, resetPlot, varargin)
global PlotWindowStyle
%
% initialize a docked figure by name; the figure will be 'hold on'
%
if isempty(PlotWindowStyle)
  PlotWindowStyle = 'Docked';
end

f = findobj('Name',figName);
if isempty(f)
    f = figure('WindowStyle',PlotWindowStyle,'Name',figName,'NumberTitle','off');
    dcm_obj = datacursormode(f);
    set(dcm_obj,'UpdateFcn',@data_cursor_update_monte);
    if nargin == 3
      set(gcf, 'Position', cell2mat(varargin)); 
    end
    if resetPlot
        clf;
    end
    hold on;
    grid on;
else
    figure(f);
    if resetPlot
        clf;
    end
    hold on;
    grid on;
end
