

clear
close all
clc



% define which parameters should be included in the optimization
% and generate a map of where each entry of 'parVec' fits in the 
% model structure under consideration.
[dreamPar.parMap,dreamPar.parMapTex,dreamPar.rangeMin,...
    dreamPar.rangeMax] = assignpars; 


% define which model parameters are not included in the optimization:
assignconstants
dreamPar.constNames = modelConstantsNames;

% % % % % % % % % % % % % 



dreamPar.modelCallStr = 'modelResult = hyperbanana(parVec);';
dreamPar.objCallStr = '[objScore,logObjScore] = objectivefun(modelResult);';
dreamPar.nSeq= 5;
dreamPar.nSamples = 1000;
dreamPar.nModelEvalsMax = 1e6;
dreamPar.drawInterval = 25;
dreamPar.visualizationCall = 'visualization2';
dreamPar.optMethod = 'direct probability';
dreamPar.nModelEvalsMax = 1001000;


[evalResults,critGelRub,outliers,sequences,acceptanceRate, pCrossoverHistory, dreamPar] = dream(dreamPar);

figure
M = sortrows(evalResults,dreamPar.objCol);
n = 10000;
X1 = M(1:end-n,dreamPar.parCols(1));
Y1 = M(1:end-n,dreamPar.parCols(2));
Z1 = M(1:end-n,dreamPar.objCol);

X2 = M(end-n+1:end,dreamPar.parCols(1));
Y2 = M(end-n+1:end,dreamPar.parCols(2));
Z2 = M(end-n+1:end,dreamPar.objCol);

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