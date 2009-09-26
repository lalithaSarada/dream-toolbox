function sequences = allocateSequences(dreamPar,sequences, iteration)
%
% <a href="matlab:web(fullfile(scemroot,'html','prepseqarray.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

if dreamPar.reducedSampleCollection
    TMP = repmat(NaN,[floor((mod(iteration,dreamPar.reducedSampleFrequency)+ dreamPar.nOffspringPerSeq)/dreamPar.reducedSampleFrequency),...
                           size(sequences,2),...
                           dreamPar.nSeq]);
    sequences = cat(1,sequences,TMP);
else
    TMP = repmat(NaN,[dreamPar.nOffspringPerSeq,...
                           size(sequences,2),...
                           dreamPar.nSeq]);
    sequences = cat(1,sequences,TMP);
end

