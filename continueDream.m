function runCondition = continueDream(dreamPar,nModelEvals)
%
% <a href="matlab:web(fullfile(dreamroot,'html','continuedream.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

if isinf(dreamPar.optEndTime)
    runCondition = nModelEvals < dreamPar.nModelEvalsMax && ~dreamPar.converged;
else
    runCondition = nModelEvals < dreamPar.nModelEvalsMax &&...
                   ~dreamPar.converged &&...
                   now<dreamPar.optEndTime;
end