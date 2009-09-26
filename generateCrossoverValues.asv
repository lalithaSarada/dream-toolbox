function allCrossoverValues = generateCrossoverValues(dreamPar,pCrossover)
% Associates to each point in a generation (in all the sequences)  a
% crossover probability (which is one of 1/nCrossoverValues,
% 2/nCrossoverValues, ... ,1 ). The distribution of the probability values
% is based on a mutinomial distribution.

randomDeviates = multrnd(dreamPar.nSeq * dreamPar.nOffspringPerSeq,pCrossover);
cumRandomDeviates = [0 cumsum(randomDeviates)];

% Then select which candidate points are selected with what allCrossoverValues
randomPerm = randperm(dreamPar.nSeq * dreamPar.nOffspringPerSeq);

allCrossoverValues = nan(dreamPar.nSeq  * dreamPar.nOffspringPerSeq,1);

% Then generate allCrossoverValues values for each chain
for val = 1:dreamPar.nCrossoverValues,
    
    % Define the start and end indices of the 
    idxStart = cumRandomDeviates(1,val) + 1; 
    idxEnd = cumRandomDeviates(1,val+1);
    
    % Define the indices in the allCrossoverValues to be assigned with the
    % current probability
    idx = randomPerm(idxStart:idxEnd);
    
    % Assign the probabilities
    allCrossoverValues(idx,1) = val/dreamPar.nCrossoverValues;
    
end;

allCrossoverValues = reshape(allCrossoverValues,dreamPar.nSeq,dreamPar.nOffspringPerSeq);