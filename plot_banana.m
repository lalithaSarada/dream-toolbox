
scemPar=dreamPar

figure
M = sortrows(evalResults,scemPar.objCol);
n = 100;
X1 = M(1:end-n,scemPar.parCols(1));
Y1 = M(1:end-n,scemPar.parCols(2));
Z1 = M(1:end-n,scemPar.objCol);

X2 = M(end-n+1:end,scemPar.parCols(1));
Y2 = M(end-n+1:end,scemPar.parCols(2));
Z2 = M(end-n+1:end,scemPar.objCol);

plot3(X1,Y1,Z1,'linestyle','none','marker','s','markersize',3,'markerfacecolor','k','markeredgecolor','k')
hold on
plot3(X2,Y2,Z2,'linestyle','none','marker','s','markersize',3,'markerfacecolor','m','markeredgecolor','m')
box on
set(gca,'zdir','normal')
xlabel('theta1')
ylabel('theta2')
zlabel('objScore')

for az=90:-1:10
    view([az,35])
    axis tight
    pause(0.1)
    drawnow
end

figure
plot(X1,Y1,'marker','s','markersize',3,'markeredgecolor','k','markerfacecolor','k','linestyle','none')
hold on
plot(X2,Y2,'marker','s','markersize',3,'markeredgecolor','m','markerfacecolor','m','linestyle','none')
set(gca,'xlim',[-30,30],'ylim',[-60,20])