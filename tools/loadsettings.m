function dreamPar = loadsettings(dreamPar,f)

[varName,varValue] = textread(f,'%s=%s');


for k=1:numel(varName)
    
    if ~isfield(dreamPar,varName{k})
        eval(['dreamPar.',varName{k},'=',varValue{k},';'])
    end
    
end
