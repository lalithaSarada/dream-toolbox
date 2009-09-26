
dreamPar = evalin('base','dreamPar');

% First, import the variables containing the measurements...
% from the base workspace:
for elem = 1:numel(dreamPar.measNames)
    tmp = evalin('base',dreamPar.measNames{elem});
    eval([dreamPar.measNames{elem},' = tmp;'])
end


clear elem tmp