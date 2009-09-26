function [parMap,parMapTex,rangeMin,rangeMax] = assign_pars
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Implicitly define the variables names, classes and sizes by
% assigning them dummy values:

parProperties = cell([0,0]);
parProperties{end+1,1} = {'a','double',[1,1],-2,7,'a'};
parProperties{end+1,1} = {'b','double',[1,1],0,10,'b'};
parProperties{end+1,1} = {'c','double',[1,1],-10,0,'c'};
parProperties{end+1,1} = {'d','double',[1,1],0,10,'d'};


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% start building the mapper:
buildparametermap
