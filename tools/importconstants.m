dreamPar = evalin('base','dreamPar');

% First, import the model constants from the base workspace:
for elem = 1:numel(dreamPar.constNames)
    tmp = evalin('base',dreamPar.constNames{elem});
    eval([dreamPar.constNames{elem},' = tmp;'])
end
clear elem tmp modelConstants
