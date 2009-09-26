

if evalResults(end,dreamPar.iterCol)==dreamPar.nSamples+dreamPar.nOffspring
%     RECT=[1,38,1280,800];
% 
%     subplotscreen(1,4,1,'rect',RECT)
%     subplotscreen(1,4,2,'rect',RECT)
%     subplotscreen(1,2,2,'rect',RECT)

    subplotscreen(1,4,1)
    subplotscreen(1,4,2)
    subplotscreen(1,2,2)
    
end


figure(1)
clf
marghist(dreamPar,evalResults)

figure(2)
clf
plotobj(dreamPar,evalResults)

figure(3)
clf
plotseq(dreamPar,sequences,'subplots')

drawnow