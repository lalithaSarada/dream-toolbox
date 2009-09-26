function varargout = plotseq(dreamPar,sequences,varargin)

nPars = numel(dreamPar.parCols);
plotHandlesSequences = repmat(NaN,dreamPar.nSeq,nPars);

defaultColors = [0,0,1;...
            0,0.5,0;
            1,0,0;...
            1,0.5,0;...
            1,1,0;...
            0.5882,0.7216,0.1804;...
            0,1,1;...
            1,0,1;...
            0.7529,0.7529,0.7529;...
            0.1490,0.5333,0.7176];
        
nColors = size(defaultColors,1);

C = [defaultColors(1:min([dreamPar.nSeq,nColors]),:);...
    rand(dreamPar.nSeq-nColors,3)];

if nargin>2 && ~isempty(varargin{1})
    plotMode = varargin{1};
else 
    plotMode = 'subaxes';
end

iGeneration = (size(sequences,1)-dreamPar.nSamplesPerSeq)/dreamPar.nOffspringPerSeq;
calcConvFromIter = (dreamPar.nSamplesPerSeq +...
                   floor(iGeneration*(1-dreamPar.convUseLastFraction))*...
                   dreamPar.nOffspringPerSeq)*dreamPar.nSeq;


for p=1:nPars
    
    switch plotMode
        case 'figures'
            figure('name',[mfilename,':',dreamPar.parMap{p}],'numbertitle','off')
        case 'subaxes'
            set(gcf,'name',mfilename,'numbertitle','off')
            subaxes(nPars,1,p,'borderBottom',0.02,...
                              'spacingRight',0.01,...
                              'spacingLeft',0.075)
        case 'subplots'
            set(gcf,'name',mfilename,'numbertitle','off')
            subplot(nPars,1,p)
    end

    nEvals = max(max(shiftdim(sequences(:,1,:),2)));
    yLims = [dreamPar.rangeMin(p),dreamPar.rangeMax(p)];
    x = [dreamPar.nSamples:dreamPar.nOffspring:nEvals]+0.5;
    plotHandlesGenerations = plot([x;x],yLims,'color',[0.9,0.9,0.9]);
    hold on
    plotHandlesGenerations = [plotHandlesGenerations;...
        plot([1;1]*calcConvFromIter+0.5,yLims,'color',[0.5,0.5,0.5])];
    
    for k=1:dreamPar.nSeq

        plotHandlesSequences(k,p) = plot(sequences(:,1,k),sequences(:,p+1,k),'s',...
                                      'markersize',3,...
                                 'markerfacecolor',C(k,:),...
                                 'markeredgecolor',C(k,:));

    end
    set(gca,'ylim',yLims,'xlim',[1,nEvals])
    
    if isfield(dreamPar,'parMapTex')&&...
            numel(dreamPar.parMapTex)>=(p)&&...
            ~isempty(dreamPar.parMapTex{p})
        ylabel(dreamPar.parMapTex{p},'interpreter','tex',...
            'rotation',0,'horizontalalignment','right')
    else
        ylabel(dreamPar.parMap{p},'interpreter','none',...
            'rotation',0,'horizontalalignment','right')
    end

    


    hold off
    
    if p~=nPars(end)
        set(gca,'xticklabel',[])
    end
end

xlabel('iteration')




if nargout==2
   varargout{1}=plotHandlesSequences;
   varargout{2}=plotHandlesGenerations;   
end