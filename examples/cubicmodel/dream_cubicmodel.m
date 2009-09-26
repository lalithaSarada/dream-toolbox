
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

dreamPar.nCompl = 4;
dreamPar.nSamples = 4;
dreamPar.nModelEvalsMax = 50004;
dreamPar.constNames = modelConstantsNames;
dreamPar.modelCallStr = 'modelResult = cubicmodel(parVec);';
dreamPar.objCallStr = '[objScore, logObjScore] = objectivefun(dreamPar,modelResult);';
dreamPar.drawInterval = 1;
dreamPar.optMethod = 2;
dreamPar.measNames = {'yMeas'}
dreamPar.nMeasurements = 1; 
dreamPar.samplingMethod = 'covariance'
dreamPar.nDiffEvolPairs = 1;
dreamPar.reducedSampleCollection = false;
% dreamPar.boundHandling = 'Reflect';



[evalResults,critGelRub, outliers, sequences,dreamPar] = dream(dreamPar);


%calculate bayesian intervals:
nBayes = dreamPar.nSamples;
M = [];
for k=size(evalResults,1)-[0:nBayes]
    
    parVec = evalResults(k,dreamPar.parCols);
    
    eval(dreamPar.modelCallStr)
    
    M = [M;modelResult];
    
end

B = bayesprobint(M,[5,95],'vec');


% calculate best model result:
M = [];
bestIx = find(evalResults(:,dreamPar.objCol)==max(evalResults(:,dreamPar.objCol)));
bestUniParSets = unique(evalResults(bestIx,dreamPar.parCols),'rows');

for k=1:size(bestUniParSets,1)
    
    parVec = bestUniParSets(k,:);
    
    eval(dreamPar.modelCallStr)
    
    M = [M;modelResult];
    
end



% visualize the result:
figure('numbertitle','off','name','bayes')
h=plot(xMeas,yMeas,'mo',...
       xMeas,B(1,:),'k-',...
       xMeas,B(2,:),'k-',...
       xMeas,yNoErr,'-g',...
       xMeas,M,'-k');
set(h(1),'markersize',3,'markerfacecolor','m')
set(h([2,3]),'color',[0.6,0.6,0.6])
set(h,'linewidth',2)
legend(h([1,2,4,5]),'measured','5-95% bayesian interval',...
    'without error','best simulation')


figure
matrixofimagesc(dreamPar,evalResults)

