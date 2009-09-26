function propChild = generateOffspringDelayedStep(dreamPar,lastPointsFromEverySeq)

iterCol = dreamPar.iterCol;
parCols = dreamPar.parCols;

% Generate ergodicity term
eps = 1e-6 * randn(dreamPar.nSeq,dreamPar.nOptPars);

% Compute the Cholesky Decomposition of the covariance matrix of lastPointsFromEverySeq
cholDecomp = (2.38/sqrt(dreamPar.nOptPars)) * chol(cov(lastPointsFromEverySeq(1:end,parCols)) + 1e-5*eye(dreamPar.nOptPars));

% Scale the adjusted proposal distribution for the delayed rejection
scaledCholDecomp = cholDecomp./dreamPar.delayedRejectionScale;
 
delta_x = zeros(dreamPar.nSeq,dreamPar.nOptPars);
 
% Loop over all chains -- all dimensions are updated
for currentSeq = 1:dreamPar.nSeq,
    % Generate a new proposal distance using standard procedure
    delta_x(currentSeq,1:dreamPar.nOptPars) = randn(1,dreamPar.nOptPars) * scaledCholDecomp;
end;


% Update lastPointFromSeq with delta_x and eps;
propChild = lastPointsFromEverySeq(:,dreamPar.parCols) + delta_x + eps;

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


