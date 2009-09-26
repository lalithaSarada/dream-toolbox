function ySim = hyperbanana(parVec)
% Also known as (1) Rosenbrock valley,
%               (2) Rosenbrock banana,
%               (3) Rosenbrock function,
%               (4) De Jong (1975) Function type 2

% modelConstantsNames = scemPar.constNames;
% modelParMap = scemPar.parMap;
% 
% 
% % First, import the model constants from the base workspace:
% for elem = 1:numel(modelConstantsNames)
%     tmp = evalin('base',modelConstantsNames{elem});
%     eval([modelConstantsNames{elem},' = tmp;'])
% end
% %clear elem tmp modelConstants
% 
% % map variables from parVec to their model counterparts:
% for elem = numel(modelParMap):-1:1  % reverse order for speed
%     eval([modelParMap{elem},' = parVec(elem);'])
% end
%clear elem tmp modelPars

N=numel(parVec);

f = 0;
for i=1:N-1
    f = f + (1-parVec(i))^2 + 100*(parVec(i+1)-parVec(i)^2)^2;
end

ySim = f;
