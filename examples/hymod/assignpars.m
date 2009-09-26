function [parMap,parMapTex,rangeMin,rangeMax] = assignpars
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Implicitly define the variables names, classes and sizes by
% assigning them dummy values:

parProperties=cell(0,0);


parProperties{end+1,1} = {'cmax',      'double',[1,1],1   ,500 ,'c_{max}'};
parProperties{end+1,1} = {'bexp',      'double',[1,1],0.10,2   ,'b_{exp}'};
parProperties{end+1,1} = {'fQuickFlow','double',[1,1],0.10,0.99,'\alpha'};
parProperties{end+1,1} = {'Rs',        'double',[1,1],0   ,0.10,'R_s'};
parProperties{end+1,1} = {'Rq',        'double',[1,1],0.10,0.99,'R_q'};

buildparametermap
