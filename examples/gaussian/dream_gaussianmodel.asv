
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


dreamPar.modelCallStr = 'modelResult = gaussianmodel(parVec);';
dreamPar.objCallStr = '[objScore,logObjScore] = objectivefun(modelResult);';
% dreamPar.nSeq = 100;
% dreamPar.nSamples = 100;
dreamPar.nModelEvalsMax = 100100;
dreamPar.optMethod = 'direct probability';
dreamPar.drawInterval = 4;
dreamPar.nDiffEvolPairs = 3;
dreamPar.outlierTest = 'IQR_test';
dreamPar.samplingMethod = 'uniform';
dreamPar.nCrossoverValues = 3;  
dreamPar.crossoverValuesTuning = true;
dreamPar.kurt = 0;
dreamPar.boundHandling = 'None';    
dreamPar.reducedSampleCollection = true;
dreamPar.reducedSampleFrequency = 10;
dreamPar.randomErgodicityError = 5e-2; 
dreamPar.optMethod = 4;


[evalResults,critGelRub,outliers,sequences,acceptanceRate, pCrossoverHistory, dreamPar] = dream(dreamPar);

