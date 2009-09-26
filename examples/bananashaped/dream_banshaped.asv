


clear
close all
clc

k = 0;

% while now<datenum([2009,9,6,09,00,0])
%     
%     k = k + 1;

    
    
    % define which parameters should be included in the optimization
    % and generate a map of where each entry of 'parVec' fits in the
    % model structure under consideration.
    [dreamPar.parMap,dreamPar.parMapTex,...
        dreamPar.rangeMin,dreamPar.rangeMax] = assignpars;
    
    % define which model parameters are not included in the optimization:
    assignconstants
    dreamPar.constNames = modelConstantsNames;
    
    % % % % % % % % % % % % %
    
    dreamPar.nSeq = 10;
    dreamPar.nSamples = 10;
    dreamPar.nModelEvalsMax = 2e5+dreamPar.nSeq ;
    dreamPar.modelCallStr = 'modelResult = bananashaped(parVec);';
    dreamPar.objCallStr = '[objScore, logObjScore] = objectivefun(dreamPar,modelResult);';
    dreamPar.drawInterval = 1;
    dreamPar.optMethod = 2;
    dreamPar.measNames = {'yMeas'}
    dreamPar.nMeasurements = 1;
    dreamPar.samplingMethod = 'covariance';
    dreamPar.plotYN = false;
    dreamPar.convMaxDiff=1e-3;
    
    dreamPar.randSeed = k
    
    
    [evalResults,critGelRub,outliers,sequences,acceptanceRate, pCrossoverHistory, dreamPar] = dream(dreamPar);
    
%     clear dreamPar
    
%     M(k)=size(outliers,1)
%     if ~isempty(outliers)
%         M2(k)=size(unique(outliers(:,2)),1)
%     else
%         M2(k)=0
%     end
    
% end


figure(3)
clf
matrixofscatter(dreamPar,evalResults)




figure(4)
clf
plot3(evalResults(:,2),evalResults(:,3),evalResults(:,dreamPar.objCol),'.')
