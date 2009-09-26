function randomDraw = covRandomDraw(dreamPar)
 randomDraw = repmat(dreamPar.initialMean,dreamPar.nSeq,1) + randn(dreamPar.nSeq,dreamPar.nOptPars) * chol(dreamPar.covariance);
