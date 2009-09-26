% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

LIC = license('inuse');
for elem = 1:numel(LIC)
    envStr = lower(LIC(elem).feature);
    if any(strcmp(envStr,{'matlab','octave'}))
        switch envStr
            case 'matlab'
                clear LIC elem
                modelConstantsNames = who;
            case 'octave'
                clear LIC elem
                modelConstantsNames = who -variables;
                toBeCleared=[];
                for j=1:numel(modelConstantsNames)
                    if length(modelConstantsNames(j).name)>=2 &&...
                            strcmp(modelConstantsNames(j).name(1:2),'__')
                        toBeCleared = [toBeCleared;j];                       
                    end
                end
                clear j
                modelConstantsNames(toBeCleared,1)=[];
                clear toBeCleared
        end
        break
    end
end
