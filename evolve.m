function [acceptedChild,alpha,acceptedSequences] = evolve(dreamPar,lastPointsFromEverySeq,propChild)

iterCol = dreamPar.iterCol;
parCols = dreamPar.parCols;
objCol = dreamPar.objCol;
logPCol = dreamPar.logPCol;
evalCol = dreamPar.evalCol;

nSequences = size(propChild, 1);

% First set acceptedChild to the old positions in X
acceptedChild = lastPointsFromEverySeq;

acceptedChild(:,iterCol) = propChild(:,iterCol);

% And initialize accept with zeros
acceptedSequences = zeros(dreamPar.nSeq,1);

switch dreamPar.optMethod
    case 1
        alpha = min(propChild(:,objCol)./lastPointsFromEverySeq(:,objCol),1);
    case {2,4}
        alpha = min(exp(propChild(:,objCol) - lastPointsFromEverySeq(:,objCol)),1);
    case  3 % SSE probability evaluation
        alpha = min((propChild(:,objCol)./lastPointsFromEverySeq(:,objCol)).^(-dreamPar.nMeasurements.*(1+dreamPar.kurt)./2),1);
    case 5 % Similar as 3 but  weighted with the measurement error sigma
        alpha = min(exp(-0.5*(-propChild(:,objCol) + lastPointsFromEverySeq(:,objCol))./dreamPar.sigma^2),1); % signs are different because we write -SSR
end;
% -------------------------------------------------------------------------

% Generate random numbers
Z = rand(nSequences,1);

% Find which alpha's are greater than Z
idx = find(alpha > Z);

% And update these chains
acceptedChild(idx,:) = propChild(idx,:);

% And indicate that these chains have been accepted
acceptedSequences(idx,1) = 1;