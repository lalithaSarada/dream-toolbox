function sequences = partcomplexes(dreamPar,evalResults)
%
% <a href="matlab:web(fullfile(scemroot,'html','partcomplexes.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

nCols = size(evalResults,2);
nSeq  = dreamPar.nSeq;
nSamplesPerSeq = dreamPar.nSamplesPerSeq;
nSamples = dreamPar.nSamples;

% sort the entries in 'evalResults' by iteration number (row 1 is iter 1):
A = sortrows(evalResults,-dreamPar.iterCol);
% select the last 'nSamples' entries in 'A': 
B = A(1:nSamples,:);

% sort 'B' by objective score
% if strcmp(dreamPar.optType,'minimize')
%     
%     C = flipud(sortrows(B,dreamPar.objCol));
%     
% elseif strcmp(dreamPar.optType,'maximize')
    
%     C = sortrows(B,dreamPar.objCol);    
%     
% else
%     error('Ambiguous optimization type.')
% end


sequences = repmat(NaN,[nSamplesPerSeq,nCols,nSeq]);
for iSeq=1:nSeq
    sequences(:,:,iSeq) = evalResults(iSeq:nSeq:nSamples,:);
end


