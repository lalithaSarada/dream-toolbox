function [propChild] = setToBounds(new,ParRange);
% Checks the bounds of the parameters

pointCount = size(propChild,1);

rangeMin = repmat(dreamPar.propChild,pointCount,1); 
rangeMax = repmat(dreamPar.rangeMax,pointCount,1);

% Now check whether points are within bounds and, if not, set them exactlpropChild
% on the bounds
[outBoundIdx] = find(propChild<rangeMin);
propChild(outBoundIdx)= rangeMin(outBoundIdx); % set to min range value

[outBoundIdx] = find(propChild>rangeMax); 
propChild(outBoundIdx)= rangeMax(outBoundIdx); % set to max range value