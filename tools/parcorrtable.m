function varargout = parcorrtable(dreamPar,evalResults,varargin)

if nargin>2
    fName = varargin;
else
    fName = 'correlations.tex';
end

M = corrcoef(evalResults(end-dreamPar.nSamples+1:end,dreamPar.parCols));






tableStr1 = ['\documentclass{article}',char(10)...
    '\begin{document}',char(10),...
    '\begin{tabu',...
    'lar}{ l',repmat('r',[1,dreamPar.nOptPars]),' }',char(10)];

tableStr2 = '&';
for k=1:dreamPar.nOptPars

    if ~isempty(dreamPar.parMapTex{k})
        tableStr2 = [tableStr2,dreamPar.parMapTex{k}];
    else
        tableStr2 = [tableStr2,dreamPar.parMap{k}];    
    end
    
    if k==dreamPar.nOptPars
        tableStr2 = [tableStr2,'\\\\'];
    else
        tableStr2 = [tableStr2,'&'];        
    end
        
    
end
    

formatStr = [repmat('%5.2f&',[1,dreamPar.nOptPars-1]),'%5.2f\\\\',char(10)];
tableStr3 = ['\end{tabular}',char(10),'\end{document}'];

try
    
    fid = fopen(fName,'wt');
    fprintf(fid,'%s',tableStr1);
    fprintf(fid,'%s',tableStr2);
    for k=1:dreamPar.nOptPars
        if ~isempty(dreamPar.parMap{k})
            fprintf(fid,'%s&',dreamPar.parMapTex{k});
        else
            fprintf(fid,'%s&',dreamPar.parMap{k});
        end
        fprintf(fid,formatStr,M(k,:));
    end
    fprintf(fid,'%s',tableStr3);
    fclose(fid);
    
catch

end



if nargout==1
    varargout = M
end