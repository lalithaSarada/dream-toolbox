function objStat = objectivefun(scemPar,modelResult)

importmeasurements

Err = yMeas(:)-modelResult(:);

% calculate the sum of squared errors, and change its sign:
objStat = sum(Err.^2);

