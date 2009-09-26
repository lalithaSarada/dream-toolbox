function [objStat, logObjStat] = objectivefun(dreamPar,modelResult)

importmeasurements

Err = yMeas(:)-modelResult(:);

% calculate the sum of squared errors, and change its sign:
objStat = -sum(Err.^2);
logObjStat = -0.5*objStat;

