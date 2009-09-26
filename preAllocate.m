function [sequences,evalResults] = preAllocate(dreamPar,sequences, evalResults) 
if dreamPar.reducedSampleCollection
    TMP = repmat(NaN,[ceil((dreamPar.nModelEvalsMax-dreamPar.nSamples)/(dreamPar.nSeq*dreamPar.reducedSampleFrequency)),...
                  size(sequences,2),...
                  dreamPar.nSeq]);
else
    TMP = repmat(NaN,[ceil((dreamPar.nModelEvalsMax-dreamPar.nSamples)/dreamPar.nSeq),...
                  size(sequences,2),...
                  dreamPar.nSeq]);
end
sequences = cat(1,sequences,TMP);

TMP = nan(dreamPar.nModelEvalsMax-dreamPar.nSamples, size(evalResults,2));
evalResults = cat(1,evalResults,TMP);
end