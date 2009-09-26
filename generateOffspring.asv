function propChild = generateOffspring(dreamPar,lastPointsFromEverySeq, jumpRateTable, allCrossoverValues)
%
% <a href="matlab:web(fullfile(scemroot,'html','generateOffspring.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%
%

% global DEBUG_VAR_jumpBase

iterCol = dreamPar.iterCol;
parCols = dreamPar.parCols;

% Generate ergodicity term
eps = 1e-6 * randn(dreamPar.nSeq,dreamPar.nOptPars);

% Determine for each sequence, the number of pairs to evolve with
[diffEvolStrategy] = getDiffEvolStrategy(dreamPar);

% Generate series of permutations of chains
[dummy,allOtherSeqPerm] = sort(rand(dreamPar.nSeq-1,dreamPar.nSeq));

% Generate uniform random numbers for each chain to determine which dimension to update
D = rand(dreamPar.nSeq,dreamPar.nOptPars);

% Ergodicity for each individual chain
noise = dreamPar.randomErgodicityError * (2 * rand(dreamPar.nSeq,dreamPar.nOptPars) - 1);

% Initialize the delta update to zero
deltaToOffspring = zeros(dreamPar.nSeq,dreamPar.nOptPars);

% Each chain evolves using information from other chains to create offspring
for currentSeq = 1:dreamPar.nSeq,

    % Determine the indexes of the other sequences
    ii = ones(dreamPar.nSeq,1);
    ii(currentSeq) = 0;
    allOtherSeqIdx = find(ii>0);

   
    % Determine a  subset of dimensions to update
    dimToUpdateIdx = find(D(currentSeq,:) > (1-allCrossoverValues(currentSeq,1)));

    % Pick up a random dimension to update
    if isempty(dimToUpdateIdx)
        dimToUpdateIdx = randperm(dreamPar.nOptPars);
        dimToUpdateIdx = dimToUpdateIdx(1); 
    end;
    % ----------------------------------------------------------------

    % Determine the number of dimensions that are going to be updated
    dimCount = size(dimToUpdateIdx,2);
    
    % Select a set of pairs among the other sequences
    pairCount = diffEvolStrategy(currentSeq,1);
    seqPairs = allOtherSeqIdx(allOtherSeqPerm(1:2*pairCount,currentSeq));

    % Determine the associated JumpRate and compute the jump
    if (rand < 4/5),
        % Lookup Table
        jumpRate = jumpRateTable(dimCount,pairCount);

        % Produce the difference of the pairs used for population evolution
        delta = sum(lastPointsFromEverySeq(seqPairs(1:pairCount),parCols) - ...
            lastPointsFromEverySeq(seqPairs(pairCount+1:2*pairCount),parCols),1);

        % Then fill update the dimension
        deltaToOffspring(currentSeq,dimToUpdateIdx) = (1 + noise(currentSeq,dimToUpdateIdx)) * jumpRate.*delta(1,dimToUpdateIdx);
    else

        % Set the JumpRate to 1 and overwrite allCrossoverValues and diffEvolStrategy
        jumpRate = 1; 
        allCrossoverValues(currentSeq,1) = -1; 

        % Compute delta from one pair
        delta = lastPointsFromEverySeq(seqPairs(1),parCols) - lastPointsFromEverySeq(seqPairs(2),parCols);

        % Now jumprate to facilitate jumping from one mode to the other in all dimensions
        deltaToOffspring(currentSeq,:) = jumpRate * delta;
    end;

    % Check this line to avoid that jump = 0 and xnew is similar to xold
    if (sum(deltaToOffspring(currentSeq,:).^2,2) == 0),
        % Compute the Cholesky Decomposition of lastPointsFromEverySeq
        R = (2.38/sqrt(dreamPar.nOptPars)) * chol(cov(lastPointsFromEverySeq(1:end,1:dreamPar.nOptPars)) + 1e-5*eye(dreamPar.nOptPars));           
        % Generate jump using multinormal distribution
        deltaToOffspring(currentSeq,1:dreamPar.nOptPars) = randn(1,dreamPar.nOptPars) * R;
    end;

end;


% Update lastPointFromSeq with deltaToOffspring and eps;
propChild = lastPointsFromEverySeq(:,dreamPar.parCols) + deltaToOffspring + eps;

% Do boundary handling -- what to do when points fall outside bound
if strcmp(dreamPar.boundHandling,'Reflect');
    [propChild] = reflectBounds(propChild,dreamPar);
end;
if strcmp(dreamPar.boundHandling,'Bound');
    [propChild] = setToBounds(propChild,dreamPar);
end;
if strcmp(dreamPar.boundHandling,'Fold');
    [propChild] = foldBounds(propChild,dreamPar);
end;

propChild = [nan(size(propChild,1),1), propChild, nan(size(propChild,1),2), repmat(false,size(propChild,1),1)];


