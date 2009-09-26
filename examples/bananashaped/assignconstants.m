



xMeas = [-4:0.1:10];

amplitude = 40;

rand('seed',0)

randTerm = -0.5*amplitude+amplitude*rand(size(xMeas));
yNoErr = 1.23*xMeas + 4.56;
yMeas =  yNoErr + randTerm;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% start building the mapper:
buildconstantsmap