function [parMap,parMapTex,rangeMin,rangeMax] = assignpars
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Implicitly define the variables names, classes and sizes by
% assigning them dummy values:

parProperties=cell(0,0);

for i = 1:100
    parProperties{end+1,1} = {strcat('a',int2str(i)),'double',[1,1],-5,15,strcat('a',int2str(i))};
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% start building the mapper:
buildparametermap