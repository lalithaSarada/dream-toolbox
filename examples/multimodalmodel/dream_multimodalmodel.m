

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



dreamPar.modelCallStr = 'modelResult = multimodalmodel(parVec);';
dreamPar.objCallStr = '[objScore,logObjScore] = objectivefun(modelResult);';
dreamPar.nSeq = 10;
dreamPar.nSamples = 10;
dreamPar.nModelEvalsMax = 10010;
dreamPar.optMethod = 'direct probability';
dreamPar.drawInterval = 4;
dreamPar.nDiffEvolPairs = 3;
dreamPar.outlierTest = 'IQR_test';
dreamPar.samplingMethod = 'covariance';
dreamPar.nCrossoverValues = 3;  
dreamPar.kurt = 0;
dreamPar.boundHandling = 'None';    
dreamPar.reducedSampleCollection = true;
dreamPar.reducedSampleFrequency = 10;
dreamPar.crossoverValuesTuning = true;
dreamPar.randomErgodicityError = 5e-2;  
dreamPar.nOffspringFraction = 10;
dreamPar.optMethod = 1;


[evalResults,critGelRub,outliers,sequences,acceptanceRate, pCrossoverHistory, dreamPar] = dream(dreamPar);
