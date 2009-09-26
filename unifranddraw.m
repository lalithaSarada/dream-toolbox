function uDraw = unifranddraw(scemControl)
%
% <a href="matlab:web(fullfile(scemroot,'html','latin.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

% This code has been revised by JHS2007

nOptPars = scemControl.nOptPars;
nSamples = scemControl.nSamples;

rangeWidth = repmat([scemControl.rangeMax(:)-...
                     scemControl.rangeMin(:)]',...
                              [nSamples,1]);
rangeMin = repmat(scemControl.rangeMin(:)',[nSamples,1]);
uDraw = rangeMin + rand(nSamples,nOptPars).*rangeWidth;

