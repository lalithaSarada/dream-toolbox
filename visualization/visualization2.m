

% test if this generation is the first after the initialization:
vTest1 = evalResults(end,dreamPar.iterCol)==dreamPar.nSamples+dreamPar.nOffspring;

% test if this generation id the first after a resume:
vTest2 = (exist('nRecords','var')==1 && nModelEvals == nRecords-nTrownAway);

% test if this script is called from the base workspace:
callStack = dbstack;
vTest3 = numel(callStack)==1;

if vTest1 || vTest2 || vTest3 
    
    % if any of these tests are true, organize the layout of the screen
    % according to:

    subplotscreen(2,4,1)
    subplotscreen(1,4,2)
    subplotscreen(2,4,5)
    
    subplotscreen(1,2,2)
    
end

clear vTest1
clear vTest2
clear vTest3


figure(1)
clf
marghist(dreamPar,evalResults)

figure(2)
clf
plotgelmanrubin(dreamPar,critGelRub)

figure(3)
clf
plotobj(dreamPar,evalResults)

figure(4)
clf
plotseq(dreamPar,sequences,'subplots')

drawnow