function [objStat,logObjStat] = objectivefun(modelResult)

% No need for importing anything, since the model
% result is in fact the desired objective score:
objStat = 1/modelResult;
logObjStat = objStat;

