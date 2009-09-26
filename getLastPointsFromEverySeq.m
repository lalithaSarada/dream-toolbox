function  lastPointsFromEverySeq = getLastPointsFromEverySeq(dreamPar,sequences)

lastPointsFromEverySeq = nan(dreamPar.nSeq, size(sequences,2));
for iSeq=1:dreamPar.nSeq
    curSeq = sequences(:,:,iSeq);
    maxIter = max(curSeq(:,dreamPar.iterCol));
    lastEvalRow = curSeq(:,dreamPar.iterCol)==maxIter;
    lastPointFromSeq = curSeq(lastEvalRow,:);
    lastPointsFromEverySeq(iSeq,:) = lastPointFromSeq;
end
