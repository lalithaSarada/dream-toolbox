function varargout = plotobj(dreamPar,evalResults)

H = plot(evalResults(:,1),evalResults(:,dreamPar.objCol),'s',...
                                               'markersize',2,...
                                          'markeredgecolor','b',...
                                          'markerfacecolor','b');
set(gca,'yscale','log')
set(gca,'xlim',[min(evalResults(:,dreamPar.iterCol)),max(evalResults(:,dreamPar.iterCol))])
xlabel('iteration')
ylabel('objective score')
set(gcf,'name',mfilename,'numbertitle','off')



if nargout==1
    varargout=H;
end