function [lastPointsFromEverySeq,historyLogp,outliers] = removeOutlierChains(lastPointsFromEverySeq, historyLogp,crtIteration,outliers,dreamPar)
% Finds outlier chains and replaces the current points in the repsective
% chains  with the best point in the other chains

% Determine the number of elements of L_density
% [endIdx] = size(historyLogp,1); 
endIdx=find(isnan(historyLogp(:,1)),1,'first')-1;
startIdx = floor(0.5*endIdx);

% Then determine the mean log density of the active chains
historyLogpMean = mean(historyLogp(startIdx:endIdx,dreamPar.parCols),1);

outliersIdx = []; 
outliersCount = 0;

% Check whether any of these active chains are outlier chains
if strcmp(dreamPar.outlierTest,'IQR_test')
    % Derive the upper and lower quantile of the data
    Q1 = prctile(historyLogpMean,75); Q3 = prctile(historyLogpMean,25);
    % Derive the Inter quartile range
    IQR = Q1 - Q3;
    % Compute the upper range -- to detect outliers
    upperRange = Q3 - 2 * IQR;

    % See whether there are any outlier chains
    outliersIdx = find(historyLogpMean < upperRange); 
    outliersCount = numel(outliersIdx);
end;

if strcmp(dreamPar.outlierTest,'Grubbs_test')
    % Test whether minimum log_density is outlier
    G = (mean(historyLogpMean) - min(historyLogpMean)) / std(historyLogpMean);
    % Determine t-value of one-sided interval
    t2 = tinv(1 - 0.01/dreamPar.nSeq,dreamPar.nSeq-2)^2; % 95% interval
    % Determine the critical value
    Gcrit = ((dreamPar.nSeq - 1)/sqrt(dreamPar.nSeq)) * sqrt(t2/(dreamPar.nSeq-2 + t2));
    if (G > Gcrit), % Reject null-hypothesis
        % Indeed, an outlier chain
        outliersIdx = find(historyLogpMean == min(historyLogpMean)); 
        outliersCount = 1;
    end;
end;

if strcmp(dreamPar.outlierTest,'Mahal_test')
    % Use the Mahalanobis distance to find outlier chains
    alpha = 0.01; 
    upperRange = ACR(dreamPar.n,dreamPar.nSeq-1,alpha);
    % Find which chain has minimum log_density
    [idx] = find(historyLogpMean==min(historyLogpMean)); 
    idx = idx(1);
    % Set the other chains to 1
    ii = [1:dreamPar.nSeq]; ii(idx) = 0; ii = find(ii>0);
    % Then check the Mahalanobis distance
    d1 = mahal(X(idx,1:dreamPar.n),X(ii,1:dreamPar.n));
    % Then see whether idx is an outlier in X
    if d1 > UpperRange,
        outliersIdx = idx; 
        outliersCount = 1;
    end;
end;
%TMP = nan(outliersCount,2);

if (outliersCount > 0)
     % Draw randomly other chain for which the mean log density is maximum.
     % Note that it cannot be the same as any outlier chain.
    maxIdx = find(historyLogpMean == max(historyLogpMean));
    maxIdx = maxIdx(1);
    for qq = 1:outliersCount,
        % Added -- update historyLogp -- chain will not be considered as an outlier chain then
        historyLogp(1:endIdx,outliersIdx(qq)+1) = historyLogp(1:endIdx,maxIdx+1);
        
        % Jump outlier chain to the chain with maxIxd
        updateCols = [dreamPar.parCols,dreamPar.objCol,dreamPar.logPCol,dreamPar.evalCol];
        lastPointsFromEverySeq(outliersIdx(qq),updateCols) = lastPointsFromEverySeq(maxIdx,updateCols);
        % Add to chainoutlier
        outliers = [outliers ; crtIteration outliersIdx(qq)]
    end;
end