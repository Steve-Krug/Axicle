function Plotter(plotNumber)
% warning('off','all');
% load('Colors.mat');
AxisFontSize       = 12;
AxisLabelFontSize  = 14;
AxisFontName       = 'Arial';
AxisLineWidth      = 1.5;

%% Standard Graph Size
if plotNumber == 1
    FigureWidth        = 5.85;
    FigureHeight       = 4;
end
%% RSM Fit Graphs
if plotNumber == 2 
    FigureWidth        = 5.85;
    FigureHeight       = 2.6;
end

if plotNumber == 3
    FigureWidth        = 8;
    FigureHeight       = 6;
end

if plotNumber == 4
    FigureWidth        = 5.85*10;
    FigureHeight       = 2.6*10;
end


box on

allAxesInFigure = findall(gcf,'type','axes');

set(allAxesInFigure,'FontSize',AxisFontSize)
set(allAxesInFigure,'FontName',AxisFontName)
set(allAxesInFigure,'XMinorTick','on')
set(allAxesInFigure,'YMinorTick','on')
set(allAxesInFigure,'TickLength',[0.02 0.05])
set(allAxesInFigure,'LineWidth',AxisLineWidth)

% set(gca,'FontSize',AxisFontSize)
% set(gca,'FontName',AxisFontName)
% set(gca,'XMinorTick','on')
% set(gca,'YMinorTick','on')
% set(gca,'TickLength',[0.02 0.05])
% set(gca,'LineWidth',AxisLineWidth)
% fs = 44100;
% sound(y, fs);

for i = 1:length(allAxesInFigure)
    xlhand = get(allAxesInFigure(i),'xlabel');
    set(xlhand,'fontsize',AxisLabelFontSize)
    ylhand = get(allAxesInFigure(i),'ylabel');
    set(ylhand,'fontsize',AxisLabelFontSize)
    set(allAxesInFigure(i),'ActivePositionProperty','OuterPosition');
end

grid on;

%% Graph Sizing
% set(gcf,'ActivePositionProperty','OuterPosition');
set(gcf,'units','inches');
position = get(gcf,'Position');
if plotNumber == 0 
    FigureWidth = position(3);
    FigureHeight = position(4);
end
if plotNumber == 3
    position(1) = 2;
    position(2) = 2;
end
set(gcf,'units','inches', 'Position', [position(1) position(2) FigureWidth FigureHeight]);

