function varargout=matrixofscatter(dreamPar,evalResults,varargin)

if nargin==2
    parListIncluded = logical(ones(size(dreamPar.parMap)));
else
    parListIncluded = varargin{1};
end

parCols = dreamPar.parCols;
nOptPars = dreamPar.nOptPars;
nOptParsIncluded = sum(double(parListIncluded));
H=[];

for iPar2 = 1:nOptPars
    for iPar1 = 1:iPar2
        
        if parListIncluded(iPar1) && parListIncluded(iPar2)

            panelIx = panelindex(iPar1,iPar2,parListIncluded);
            subplot(nOptParsIncluded,nOptParsIncluded,panelIx);

            if iPar1<iPar2

                x = evalResults(:,parCols(iPar2));
                y = evalResults(:,parCols(iPar1));

                c = [0,0.5,0];

                h = plot(x,y,'markersize',1,...
                                 'marker','o',...
                        'markeredgecolor',c,...
                        'markerfacecolor',c,...
                              'LineStyle','none');
                set(gca,'xlim',[dreamPar.rangeMin(iPar2),dreamPar.rangeMax(iPar2)],...
                        'ylim',[dreamPar.rangeMin(iPar1),dreamPar.rangeMax(iPar1)])
                axis square

            elseif iPar1==iPar2

                h = text(0.5,0.5,dreamPar.parMap{iPar1},...
                    'horizontalalignment','right',...
                    'fontname','lucida console',...
                    'interpreter','none');
                axis off

            end
            H = [H;h];
        end
    end    
end

if nargout==0
    varargout={};
elseif nargout==1
    varargout{1}=H;
end


function panelIx = panelindex(iPar1,iPar2,parListIncluded) 

L = sum(parListIncluded);
a = sum(double(parListIncluded(1:iPar1)));
b = sum(double(parListIncluded(1:iPar2)));
panelIx = (a-1)*L+b;
