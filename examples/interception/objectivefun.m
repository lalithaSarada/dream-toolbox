function [objStat, logObjStat] = objectivefun(dreamPar,modelResult)

importmeasurements

Err = storageMeasured(:)-modelResult(:);

% calculate the sum of squared errors, and change its sign:
objStat = -sum(Err.^2);
logObjStat = objStat;

