
clear
close all
clc

% define which parameters should be included in the optimization
% and generate a map of where each entry of 'parVec' fits in the 
% model structure under consideration.
[dreamPar.parMap,dreamPar.parMapTex,...
    dreamPar.rangeMin,dreamPar.rangeMax] = assignpars; 

% define which model parameters are not included in the optimization:
assignconstants
dreamPar.constNames = modelConstantsNames;

% % % % % % % % % % % % % 



dreamPar.modelCallStr = 'modelResult = interceptionmodel(parVec);';
dreamPar.objCallStr = '[objScore, logObjScore] = objectivefun(dreamPar,modelResult);';
dreamPar.nSeq = 4;
dreamPar.nSamples = 4;
dreamPar.nModelEvalsMax = 1e6+4;
dreamPar.drawInterval = 5;
dreamPar.nDiffEvolPairs = 1;
dreamPar.visualizationCall = 'visualization2';
dreamPar.optMethod = 2; %'error minimization';
dreamPar.measNames = {'storageMeasured'};
dreamPar.nMeasurements = numel(storageMeasured)
dreamPar.delayedRejection = false;

[evalResults,critGelRub,outliers,sequences,acceptanceRate, pCrossoverHistory, dreamPar] = dream(dreamPar);


%calculate bayesian intervals:
nBayes = dreamPar.nSamples;
M = [];
for k2=size(evalResults,1)-[0:nBayes]
    
    parVec = evalResults(k2,dreamPar.parCols);
    
    eval(dreamPar.modelCallStr)
    
    M = [M;modelResult'];
    
end

B = bayesprobint(M,[5,95],'vec');


% calculate best model result:
M = [];
bestIx = find(evalResults(:,dreamPar.objCol)==max(evalResults(:,dreamPar.objCol)));
bestUniParSets = unique(evalResults(bestIx,dreamPar.parCols),'rows');

for k3=1:size(bestUniParSets,1)
    
    parVec = bestUniParSets(k3,:);
    
    eval(dreamPar.modelCallStr)
    
    M = [M;modelResult];
    
end



% visualize the result:

figure('numbertitle','off','name','bayes')
h=plot(TimeTab,storageMeasured,'mo',...
       TimeTab,B(1,:),'k-',...
       TimeTab,B(2,:),'k-',...
       TimeTab,M,'-k');
set(h(1),'markersize',3,'markerfacecolor','m')
set(h([2,3]),'color',[0.6,0.6,0.6])
set(h,'linewidth',2)
legend(h([1,2,4]),'measured','5-95% bayesian interval',...
    'best simulation')

figure
matrixofimagesc(dreamPar,evalResults)