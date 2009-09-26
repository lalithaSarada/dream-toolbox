function [propChild] = foldBounds(propChild,dreamPar);

% ------- New approach that maintains detailed balance ----------


pointCount = size(propChild,1);

rangeMin = repmat(dreamPar.propChild,pointCount,1); 
rangeMax = repmat(dreamPar.rangeMax,pointCount,1);


% Now check whether points are within bound and if not, "fold" the
% respective bound
[outBoundIdx] = find(propChild < rangeMin); 
propChild(outBoundIdx) = rangeMax(outBoundIdx) - (rangeMin(outBoundIdx) - propChild(outBoundIdx));

[outBoundIdx] = find(propChild > rangeMax); 
propChild(outBoundIdx) = rangeMin(outBoundIdx) + (propChild(outBoundIdx) - rangeMax(outBoundIdx));

% ----- End New approach that maintains detailed balance --------

% Just in case if still outside bound (should not happen)
[outBoundIdx] = find(propChild < rangeMin); 
propChild(outBoundIdx) = rangeMin(outBoundIdx) + rand * (rangeMax(outBoundIdx) - rangeMin(outBoundIdx));

[outBoundIdx] = find(propChild > rangeMax); 
propChild(outBoundIdx) = rangeMin(outBoundIdx) + rand * (rangeMax(outBoundIdx) - rangeMin(outBoundIdx));
