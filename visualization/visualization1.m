

if evalResults(end,dreamPar.iterCol)==dreamPar.nSamples+dreamPar.nOffspring

    subplotscreen(1,2,1)
    subplotscreen(1,2,2)
    
end


figure(1)
plotgelmanrubin(dreamPar,critGelRub)
xlabel('iteration')
ylabel('Gelman-Rubin convergence')

figure(2)
marghist(dreamPar,evalResults)
xlabel('parameter value')
ylabel('count')

drawnow
