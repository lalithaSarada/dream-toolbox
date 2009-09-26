function evalResults = updateEvalResults(dreamPar, evalResults, acceptedChild, iteration)

    evalResults(iteration*dreamPar.nSeq+1:(iteration+1)*dreamPar.nSeq) = acceptedChild;

end