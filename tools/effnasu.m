function E = effnasu(varargin)
%
% <a href="matlab:web(fullfile(dreamroot,'html','effnasu.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%
% nash-sutcliffe efficiency
% E = effnasu(yObs,ySim)

if nargin==0
    try
        
        s = ['% % Usage: ',char(10)...
        '% %    effnasu(yObs,ySim) if both are defined at the same x',char(10)...
        '% %    effnasu(xObs,yObs,xSim,ySim) if xObs ~= xSim'];
 
        disp(s)
        return
    catch
    end
    
elseif nargin==2
    
   
    yObs = varargin{1}(:);
    ySim = varargin{2}(:);

    A = sum((yObs-ySim).^2);
    B = sum((yObs-mean(yObs)).^2);

    E = 1-A/B;

    
elseif nargin==4
    
    xObs = varargin{1}(:);
    yObs = varargin{2}(:);
    
    xSim = varargin{3}(:);   
    ySim = varargin{4}(:);
    
    ySimInterp = interp1(xSim,ySim,xObs,'linear');
    
    A = sum((yObs-ySimInterp).^2);
    B = sum((yObs-mean(yObs)).^2);

    E = 1-A/B;
    
else
    
    error(['Function ',mfilename,' must have either 2 or 4 input arguments.'])
    
end

