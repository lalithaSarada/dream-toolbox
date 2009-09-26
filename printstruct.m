function str = printstruct(s)
%
% <a href="matlab:web(fullfile(scemroot,'html','printstruct.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

sNames = fieldnames(s);
str='';
for n1=1:numel(sNames)
    eval(['tmp = s.',sNames{n1},';'])
    for n2=1:numel(tmp)
        if strcmp(class(tmp(n2)),'double')
            str = [str,'% scemPar.',sNames{n1},'(',num2str(n2),') = ',num2str(tmp(n2),'% 25.12f'),char(10)];
        elseif ischar(tmp)
            str = [str,'% scemPar.',sNames{n1},' = ',char(39),tmp,char(39),char(10)];
            break
        elseif iscell(tmp(n2))
            if ischar(tmp{n2})
                str = [str,'% scemPar.',sNames{n1},'{',num2str(n2),'} = ',char(39),tmp{n2},char(39),char(10)];
            else 
                warning(mfilename,'variable skipped')
            end
        end
    end
end