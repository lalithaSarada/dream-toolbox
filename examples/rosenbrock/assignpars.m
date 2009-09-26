function [parMap,parMapTex,rangeMin,rangeMax] = assign_pars
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Implicitly define the variables names, classes and sizes by
% assigning them dummy values:

parProperties = cell([0,0]);

parProperties{end+1,1} = {'theta1','double',[1,1],-100,100,'\theta_1'};
parProperties{end+1,1} = {'theta2','double',[1,1],-150,150,'\theta_2'};
% parProperties{end+1,1} = {'theta3','double',[1,1],-5,5,'\theta_3'};
% parProperties{end+1,1} = {'theta4','double',[1,1],-5,5,'\theta_4'};
% parProperties{end+1,1} = {'theta5','double',[1,1],-5,5,'\theta_5'};
% parProperties{end+1,1} = {'theta6','double',[1,1],-5,5,'\theta_6'};
% parProperties{end+1,1} = {'theta7','double',[1,1],-5,5,'\theta_7'};
% parProperties{end+1,1} = {'theta8','double',[1,1],-5,5,'\theta_8'};

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% start building the mapper:
buildparametermap