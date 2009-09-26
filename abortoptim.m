function converged = abortoptim(critGelRub,dreamPar)
%
% <a href="matlab:web(fullfile(dreamroot,'html','abortoptim.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

Ix = find(isnan(critGelRub(:,1)),1,'first')-1;

if Ix>=dreamPar.nGelRub
    
    A = critGelRub(Ix-dreamPar.nGelRub+1:Ix,dreamPar.parCols);
        
    D = max(A,[],1) - min(A,[],1);
    
    
    if all(D < dreamPar.convMaxDiff) &&...
       all(critGelRub(Ix,dreamPar.parCols)<dreamPar.critGelRubConvd)
        converged = true;
    else
        converged = false;
    end    
else
    converged = false;
end


