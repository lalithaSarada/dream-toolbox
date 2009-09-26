function H = bayesprobint(M,arg2,modeStr)
%
% <a href="matlab:web(fullfile(dreamroot,'html','bayesprobint.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

n = numel(arg2);

if strcmp(modeStr,'mat')

    yBinBounds = arg2

    yBinBounds(1:n,1)=yBinBounds;

    C=repmat(NaN,[n-1,size(M,2)]);

    for t=1:size(M,2)
        c = histc(M(:,t),yBinBounds);
        C(1:n-1,t)=c(1:n-1,1);
    end


    H = C/size(M,1);


    % figure
    % imagesc(H)
    % set(gca,'ydir','normal')
    % 
    % logrgb=flipud(repmat(logspace(-0.5,0,64)',[1,3]))
    % colormap(logrgb)
    % colorbar
    % 


elseif strcmp(modeStr,'vec')
    
    if ~all(0<=arg2 & arg2<=100)
        error(['Please enter percentages for calculation ',...
            'of the bayesian ',char(10),...
            'probability intervals.'])
    end
    percVec(1:n,1) = arg2;
    H = repmat(NaN,[n,size(M,2)]);

    for t=1:size(M,2)
        %         c = sort(M(:,t));
        %         H(1:n,t)=c(round(percVec*(size(M,1)+1)));
        H(1:n,t)=prctile(M(:,t),percVec);
    end
    %     all(max(M,[],1)==H(5,:))
    %     all(min(M,[],1)==H(1,:))
    
else
    
end
