% map variables from parVec to their model counterparts:
for elem = numel(dreamPar.parMap):-1:1  % reverse order for speed
    eval([dreamPar.parMap{elem},' = parVec(elem);'])
end
clear elem tmp modelPars
