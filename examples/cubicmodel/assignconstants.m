



xMeas = [-4:0.1:10];

a = -1
b = 7
c = -0.5
d = 9


randn('seed',0)
randnTerm = 5*randn(size(xMeas));

yNoErr = a*xMeas.^3 + b*xMeas.^2 + c*xMeas + d;
yMeas = yNoErr + randnTerm;

clear a b c d


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

LIC = license('inuse');
for elem = numel(LIC):-1:1
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