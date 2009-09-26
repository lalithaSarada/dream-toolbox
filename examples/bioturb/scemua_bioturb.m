   
clear
close all
clc


% define which parameters should be included in the optimization
% and generate a map of where each entry of 'parVec' fits in the 
% model structure under consideration.
[scemPar.parMap,scemPar.parMapTex,scemPar.rangeMin,scemPar.rangeMax] = assignpars;

 xlsread Cfract_dat_G7.xls;
 xMeas = (ans(:,1)/100);
 yMeas = (ans(:,2)/100);

scemPar.nCompl = 10;
scemPar.nSamples = 1000;
scemPar.nModelEvalsMax = 50000;
%scemPar.constNames = modelConstantsNames;
scemPar.modelCallStr = 'modelResult = Bioturb_Velthuis_104_SCEM(parVec);';
scemPar.objCallStr = 'objScore = -objectivefun(scemPar,modelResult);';
scemPar.measNames = {'yMeas'};
scemPar.useIniFile = 'scemua-default-settings.ini';
scemPar.visualizationCall = 'visualization2';
scemPar.optMethod = 'error minimization';
scemPar.nMeasurements = numel(yMeas);
scemPar.drawInterval = 1;


[evalResults,critGelRub,sequences,scemPar] = scemua(scemPar);

%calculate bayesian intervals:
nBayes = scemPar.nSamples;
M = [];
for k=size(evalResults,1)-[0:nBayes]
    
    parVec = evalResults(k,scemPar.parCols);
    
    eval(scemPar.modelCallStr)
    
    M = [M;modelResult];
    
end

B = bayesprobint(M,[5,95],'vec');


% calculate best model result:
M = [];
bestIx = find(evalResults(:,scemPar.objCol)==max(evalResults(:,scemPar.objCol)));
bestUniParSets = unique(evalResults(bestIx,scemPar.parCols),'rows');

for k=1:size(bestUniParSets,1)
    
    parVec = bestUniParSets(k,:);
    
    eval(scemPar.modelCallStr);
    
    figure
    plot(modelResult,-xMeas,'-.r*')
    hold on
    plot(yMeas,-xMeas,'-.b*')
    
    M = [M;modelResult];
    
end



% visualize the result:
figure('numbertitle','off','name','bayes')
h=plot(xMeas,yMeas,'mo',...
       xMeas,B(1,:),'k-',...
       xMeas,B(2,:),'k-',...
       xMeas,M,'-k');
set(h(1),'markersize',3,'markerfacecolor','m')
set(h([2,3]),'color',[0.6,0.6,0.6])
set(h,'linewidth',2)
legend(h([1,2,4,5]),'measured','5-95% bayesian interval',...
    'without error','best simulation')

figure
matrixofimagesc(scemPar,evalResults)



