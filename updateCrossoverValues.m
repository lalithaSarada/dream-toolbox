function [pCrossover,crossoverCount] = updateCrossoverValues(dreamPar,allCrossoverValues,deltaTot,crossoverCount)
% Updates the probabilities of the various crossover values

% flatten allCrossoverValues
allCrossoverValues = allCrossoverValues(:);

% Determine crossoverCount = how many times a particular crossover value
% is used
for val = 1:dreamPar.nCrossoverValues, 
    idx = find(allCrossoverValues == val/dreamPar.nCrossoverValues);
    crossoverCount(1,val) = crossoverCount(1,val) + size(idx,1);    
end;

% Adapt pCrossover using information from averaged normalized jumping distance
pCrossover = dreamPar.nSeq * (deltaTot./crossoverCount) / sum(deltaTot);

% Normalize pCrossover
pCrossover = pCrossover./sum(pCrossover);