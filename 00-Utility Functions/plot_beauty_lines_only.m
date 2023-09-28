ax = findall(gcf,'type','axes');
currfig = gcf;

for ppp=1:length(ax)
    try
        set(get(ax(ppp),'Children'),'linewidth',1.5);
        set(ax(ppp),'Xgrid','on','YGrid','on');
        if ~strcmp(currfig.Name, 'Vehicle Phase Portrait') % Exclude some figures for XLim shift
            set(ax(ppp),'XLim',[evalin('base','runup_time') inf]);
        end
    catch
        disp('Error in plot beauty command(s)...')
    end
end

% Make y-axis limits the same as the subplot with the greatest range
% only if specific conditions are met
if length(ax) == 4 % This is probably a plot of 4 wheels
    if strcmp(ax(4).Title.String,'frL') % This is even more probably a plot of 4 wheels
        maxYLim = max([ax(1).YLim ax(2).YLim ax(3).YLim ax(4).YLim]);
        minYLim = min([ax(1).YLim ax(2).YLim ax(3).YLim ax(4).YLim]);
        for i = 1:4
            ax(i).YLim = [minYLim maxYLim];
        end
    end
end

% Same as above but for plotyy (2 y axes per plot)
% Axes limiting works but looks terrible because the grids get messed up.
% Use for now anyway since both y axes are the same.

if length(ax) == 8 % This is probably a plot of 4 wheels with 2 y axes each.
    if strcmp(ax(8).Title.String,'frL') % This is even more probably a plot of 4 wheels
        maxYLim = max([ax.YLim]);
        minYLim = min([ax.YLim]);
        for i = 1:length(ax)
            ax(i).YLim = [minYLim maxYLim];
        end
%         maxYLim = max([ax(1).YLim ax(3).YLim ax(5).YLim ax(7).YLim]);
%         minYLim = min([ax(1).YLim ax(3).YLim ax(5).YLim ax(7).YLim]);
%         for i = [1 3 5 7]
%             ax(i).YLim = [minYLim maxYLim];
%         end
%         maxYLim = max([ax(2).YLim ax(4).YLim ax(6).YLim ax(8).YLim]);
%         minYLim = min([ax(2).YLim ax(4).YLim ax(6).YLim ax(8).YLim]);
%         for i = [2 4 6 8]
%             ax(i).YLim = [minYLim maxYLim];
%         end
    end
end