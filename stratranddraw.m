function sDraw = stratranddraw(scemPar)
%
% <a href="matlab:web(fullfile(scemroot,'html','stratrand.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

nOptPars = scemPar.nOptPars;
nSamples = scemPar.nSamples;

nSamplesPerAxis = floor(nSamples^(1/nOptPars));
nStratRandSamples=nSamplesPerAxis^nOptPars;
nUniRandSamples = nSamples-nStratRandSamples;

pStr='';


res(1,:) = (scemPar.rangeMax-scemPar.rangeMin)/(nSamplesPerAxis);

for k=1:numel(scemPar.rangeMax)
    eval(['p',num2str(k),' = linspace(scemPar.rangeMin(k),',...
                'scemPar.rangeMax(k)-res(k),',...
                'nSamplesPerAxis);'])

    if k<=1
        pStr = [pStr,'p',num2str(k)];
    else
        pStr = [pStr,',p',num2str(k)];
    end
        
end

eval(['parCombs = allcomb(',pStr,')+',...
    'repmat(res,[nStratRandSamples,1]).*',...
    'rand(nStratRandSamples,nOptPars);'])

% eval(['parCombs = allcomb(',pStr,')'])%.*',...
% %     'repmat(res,[nStratRandSamples,1]).*',...
% %     'rand(nStratRandSamples,nOptPars)'])


TMP=scemPar;
TMP.nSamples=nUniRandSamples;

uDraw = unifranddraw(TMP);

sDraw=[parCombs;uDraw];

