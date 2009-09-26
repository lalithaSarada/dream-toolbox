function plotgelmanrubin(dreamPar,critGelRub)


set(gcf,'numbertitle','off','name',mfilename)

% r = size(critGelRub,1);
% yLimMin = 1.0;
% yLimMax = 1.02;%dreamPar.critGelRubConv;

nRows = find(isnan(critGelRub(:,1)), 1,'first')-1;
n = max([1,nRows-dreamPar.nGelRub+1]);

for p=2:size(critGelRub,2)
    
    subplot(dreamPar.nOptPars,1,p-1)
    
    yLimMin = min(critGelRub(n:nRows,p));
    yLimMax = max(critGelRub(n:nRows,p));
    
    
    plot(critGelRub(:,1),critGelRub(:,p),'-b.')
    hold on
    plot([0;dreamPar.nModelEvalsMax],ones(2,1)*dreamPar.critGelRubConvd,...
        'color',[0,0.5,0],'linestyle','--')
    hold off
    set(gca,'xlim',[0,critGelRub(nRows,1)])
    
    if yLimMin<yLimMax
        set(gca,'ylim',[yLimMin,yLimMax])
        set(gca,'ytick',[yLimMin,yLimMax])
    end
    
    if isfield(dreamPar,'parMapTex')&&...
            numel(dreamPar.parMapTex)>=(p-1)&&...
            ~isempty(dreamPar.parMapTex{p-1})
        title(dreamPar.parMapTex{p-1},'interpreter','tex')
    else
        title(dreamPar.parMap(p-1),'interpreter','none')
    end
    
end

