function plot_beauty(useTex,plotStyle)
% Call this script to beautify your gca
% @csatkoski 6-2-2014

% plotStyle - 1 = single plot; 2 - 2x2 subplot

if nargin==0
    useTex=0; %default to not using an interpreter
    plotStyle=1; %default to single plot
elseif nargin==1
    plotStyle=1; %default to single plot    
end

if useTex
    interpreterName='tex';
else
    interpreterName='none';
end

switch(plotStyle)
    case(1)
        plotPosition = [2 2 8 6];
        plotPaperPosition = [2 2 8 6];
        plotFontSize = 14;
    case(2)
        plotPosition = [1 1 12 8];
        plotPaperPosition = [1 1 12 8];
        plotFontSize = 12;
end

set(gcf,'Units','inches')                       % Set units for preferred object size
set(gcf,'Position', plotPosition)                  % Preferred object size
set(gcf,'PaperPosition', plotPaperPosition)                  % Preferred object size
set(gcf,'color','w')                            % Background color to white makes it pretty
ax = findall(gcf,'type','axes');
% ax = get(gcf, 'children');
for ppp=1:length(ax)
    set(get(ax(ppp),'Title'),'fontweight','bold')       % Always make title fontweight bold
    set(get(ax(ppp),'Xlabel'),'fontweight','bold','interpreter',interpreterName,'fontsize',plotFontSize)      % Always make axes fontweight bold
    set(get(ax(ppp),'Ylabel'),'fontweight','bold','interpreter',interpreterName,'fontsize',plotFontSize)      % Always make axes fontweight bold
    set(get(ax(ppp),'Zlabel'),'fontweight','bold','interpreter',interpreterName,'fontsize',plotFontSize)      % Always make axes fontweight bold
    set(get(ax(ppp),'Title'),'fontsize',16,'interpreter',interpreterName)             % Always make title font 16
    if ~isempty(legend)
        %         legend(ax(ppp),'location','best')               % Make sure the legends are placed appropriately.
        set(legend,'interpreter',interpreterName) %'fontsize',14,
    end
    try
        set(get(ax(ppp),'Children'),'linewidth',2)          % Set linewidth to 2 point
    catch
        %         warning('Chris made an oops!')
    end
    
    try
        set(get(ax(ppp),'Children'),'markersize',18)          % Set marker size to 20 point to match linewidth
    catch
        %         warning('Kyle made an oops!')
    end
    
    grid on;
end

% figure(gcf);                                    % set figure to forefront

end