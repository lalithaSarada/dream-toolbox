function thisMachineSeed = seedsample(seedFileName)
%
% <a href="matlab:web(fullfile(scemroot,'html','seedsample.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

try
    
    fid = fopen(seedFileName,'r');

    while true
        tline = fgetl(fid);
        if strcmpi(tline,'use clock')
            c=clock;
            thisMachineSeed = c(3)+prod(c(4:5))+c(6)^2*1e6;
            break
        else
            [thisMachineName,thisMachineSeed] = strread(tline,'%[^,]%*1c%d','delimiter','\n\r');
            if strcmp(getenv('COMPUTERNAME'),thisMachineName)
                break
            end
        end
    end

    fclose(fid);

catch

    c=clock;
    thisMachineSeed = c(3)+prod(c(4:5))+c(6)^2*1e6;
    warning(['Reading of seed file: ', char(39),seedFileName, char(39),' failed.'])
    
end