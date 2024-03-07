%schoolPlot.m
close all
clear
clc

load('C:\Users\slkru\OneDrive - Axicle\Public\15. GitHub Repo\Axicle\02-Software\MatLab\schoolData.mat')


hold on
figure(1 ...
    )
for i = 1:length(schoolData)

   h = scatter(schoolData(i,1),schoolData(i,2),'filled');


end


p = polyfit(schoolData(:,1), schoolData(:,2), 1);
px = [min(schoolData(:,1)) max(schoolData(:,1))];
py = polyval(p, px);
% scatter(schoolData(:,1), schoolData(:,2), 'filled')
hold on
plot(px, py,'k','LineWidth', 3);

hold on
legend('Minnetonka','Wayzata','Edina','Eden Prairie','Orono Senior High','Henry High','St. Louis Park','Southwest Senior High','South Senior High','Hopkins','Edison','North Mpls High', 'linear fit');

xlabel('GreatSchools Quality Rating [1-10]')
ylabel('Top 20% Average Home Cost in Zip Code [$ USD]')

ax = ancestor(h, 'axes');
ax.XAxis.Exponent = 0;
xtickformat('%.0f');
xlim([0 10])
ylim([0 5000000])
Plotter(1);
