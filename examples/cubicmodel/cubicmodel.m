function ySim = cubicmodel(parVec)

importconstants
importparameters

ySim = a*xMeas.^3 + b*xMeas.^2 + c*xMeas + d;