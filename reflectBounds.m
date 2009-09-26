function [propChild] = reflectBounds(propChild,dreamPar)

pointCount = size(propChild,1);

rangeMin = repmat(dreamPar.rangeMin',pointCount,1); 
rangeMax = repmat(dreamPar.rangeMax',pointCount,1);


% Now check whether points are within the bounds and, if not, reflect
[outBoundIdx] = find(propChild<rangeMin); 
propChild(outBoundIdx)= 2 * rangeMin(outBoundIdx) - propChild(outBoundIdx); % reflect in rangeMin

[outBoundIdx] = find(propChild>rangeMax); 
propChild(outBoundIdx)= 2 * rangeMax(outBoundIdx) - propChild(outBoundIdx); % reflect in rangeMax

% Now double check if all elements are within bounds
[outBoundIdx] = find(propChild<rangeMin); 
propChild(outBoundIdx) = rangeMin(outBoundIdx) + rand*(rangeMax(outBoundIdx)-rangeMin(outBoundIdx));

[outBoundIdx] = find(propChild>rangeMax); 
propChild(outBoundIdx) = rangeMin(outBoundIdx) + rand*(rangeMax(outBoundIdx)-rangeMin(outBoundIdx));