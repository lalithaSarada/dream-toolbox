function varargout = plotpaco(dreamPar,evalResults,varargin)

standardize = true;
invAxis = repmat(false,[1,dreamPar.nOptPars]);


% parse input from varargin here




parCols = dreamPar.parCols;

nRows = size(evalResults,1);
nSamples = dreamPar.nSamples;

muRecords = repmat(mean(evalResults(nRows+[-nSamples+1:0],parCols),1),[nSamples,1]);

flag = 0; % standard deviation calculated with n-1 in the divisor

sigmaRecords = repmat(std(evalResults(nRows+[-nSamples+1:0],parCols),flag,1),[nSamples,1]);


invArray = repmat((~invAxis)*1+invAxis*-1,[nSamples,1]);


if standardize
    M = invArray.*(evalResults(nRows+[-nSamples+1:0],parCols)-muRecords)./sigmaRecords;
else
    M = invArray.*evalResults(nRows+[-nSamples+1:0],parCols);
end

minLim = min(M(:));
maxLim = max(M(:));

hold on
for k=dreamPar.parCols
    if invAxis(1,k-1)
        s = '-1\cdot';
    else
        s = '';
    end
    if numel(dreamPar.parMapTex)>=(k-1) && ~isempty(dreamPar.parMapTex{k-1})
        arrayOfHandles(k-1,1) = text(k,minLim+(maxLim-minLim)*1.05,...
            [s,dreamPar.parMapTex{k-1}],...
            'interpreter','tex',...
            'horizontalalign','center',...
            'verticalalignment','middle');
    else
        arrayOfHandles(k-1,1) = text(k,minLim+(maxLim-minLim)*1.05,...
            [s,dreamPar.parMap{k-1}],...
            'interpreter','none',...
            'horizontalalign','center',...
            'verticalalignment','middle');
    end
end


arrayOfHandles(dreamPar.nOptPars+[1:dreamPar.nOptPars],1) =...
    plot([dreamPar.parCols;dreamPar.parCols],[minLim;maxLim],...
    'color',0.8*[1,1,1]);

arrayOfHandles(2*dreamPar.nOptPars+[1:nSamples],1) = plot(dreamPar.parCols,M,'-k');

set(gca,'xlim',[min(dreamPar.parCols),max(dreamPar.parCols)]+[-1,1]*0.5)
set(gca,'ylim',[minLim,maxLim])
set(gca,'xtick',dreamPar.parCols,'xticklabel',{})


if standardize
    arrayOfHandles(end+1,1) = ylabel('normalized parameter value');
else
    arrayOfHandles(end+1,1) = ylabel('normalized parameter value');
end








if nargout==1
    varargout = arrayOfHandles
end