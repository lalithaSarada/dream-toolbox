function varargout=marghist(dreamPar,evalResults,varargin)
if nargin==2
    histMode='absolute';
else
    histMode = varargin{1};
end

% nBins = round(dreamPar.nSamples/5);
% M = evalResults(end+[-dreamPar.nSamples+1:0],:);

nBins = 50;
firstNan = find(isnan(evalResults(:,1)),1,'first');
x=min([firstNan-1,250]);

M = evalResults(firstNan-1+[-x+1:0],:);


for p=dreamPar.parCols-1
    
    subplot(dreamPar.nOptPars,1,p)
    
    a = dreamPar.rangeMin(p);
    b = dreamPar.rangeMax(p);
    binEdges = linspace(a,b,nBins+1);
    dx = binEdges(2)-binEdges(1);
    
    switch histMode
        case 'absolute'
            histcResult = histc(M(:,p+1),binEdges);
        case 'relative'
            nRecords = size(M,1);
            histcResult = histc(M(:,p+1),binEdges)/(nRecords*dx);
        otherwise
            error(['Unknown option in function', mfilename])
    end
    stairs(binEdges,histcResult)
    set(gca,'xlim',[a,b])
    if isfield(dreamPar,'parMapTex')&&...
            numel(dreamPar.parMapTex)>=p&&...
            ~isempty(dreamPar.parMapTex{p})
        title(dreamPar.parMapTex{p},'interpreter','tex')
    else
        title(dreamPar.parMap(p),'interpreter','none')
    end
end

set(gcf,'name',mfilename,'numbertitle','off')

if nargout==2
    varargout{1}=binEdges;
    varargout{2}=histcResult;
end
