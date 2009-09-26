function [parMap,parMapTex,rangeMin,rangeMax] = assign_pars
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Implicitly define the variables names, classes and sizes by
% assigning them dummy values:

parProperties=cell(0,0);



parProperties{end+1,1} = {'a','double',[1,1],-100,100,'a'};
parProperties{end+1,1} = {'b','double',[1,1],-100,100,'b'};
parProperties{end+1,1} = {'c','double',[1,1],-100,100,'c'};
parProperties{end+1,1} = {'d','double',[1,1],-100,100,'d'};
parProperties{end+1,1} = {'e','double',[1,1],-100,100,'e'};
parProperties{end+1,1} = {'f','double',[1,1],-100,100,'f'};
parProperties{end+1,1} = {'g','double',[1,1],-100,100,'g'};
parProperties{end+1,1} = {'h','double',[1,1],-100,100,'h'};
parProperties{end+1,1} = {'i','double',[1,1],-100,100,'i'};
parProperties{end+1,1} = {'j','double',[1,1],-100,100,'j'};


buildparametermap