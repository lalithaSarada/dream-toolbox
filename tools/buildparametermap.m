% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% start building the mapper:

% Determine how to map these variables to a vector ('thetavec'):
parMap=cell([0,1]);
parMapTex=cell([0,1]);
rangeMin=[];
rangeMax=[];

for k=1:size(parProperties,1)    
    
    if any(strcmp(parProperties{k,1}{2},{'double','logical'}))
    
        for j=1:prod(parProperties{k,1}{3})
            n=size(parMap,1);
            parMap{n+1,1} = [parProperties{k,1}{1},'(',buildsubscriptstr(parProperties{k,1}{3},j),')'];
            rangeMin(n+1,1) = parProperties{k,1}{4}(j);
            rangeMax(n+1,1) = parProperties{k,1}{5}(j);
            if numel(parProperties{k,1})==6
                parMapTex{n+1,1} = parProperties{k,1}{6};
            end                
        end

    elseif strcmp(parProperties{k,1}{2},'struct') &&...
            any(strcmp(parProperties{k,1}{4},{'double','logical'}))
        
        [structRoot,structField] = strtok(parProperties{k,1}{1},'.'); 
        
        for m=1:prod(parProperties{k,1}{3})
            for j=1:prod(parProperties{k,1}{5})
                n = size(parMap,1);
                parMap{n+1,1} = [structRoot,'(',buildsubscriptstr(parProperties{k,1}{3},m),')',...
                    structField,'(',buildsubscriptstr(parProperties{k,1}{5},j),')'];
                rangeMin(n+1,1) = parProperties{k,1}{6}(j);
                rangeMax(n+1,1) = parProperties{k,1}{7}(j);
                if numel(parProperties{k,1})==8
                    parMapTex{n+1,1} = parProperties{k,1}{8};
                end                
                
            end
        end
    else
        
        error(['Unsupported type. Error occurred in m-file:' 39, mfilename,39,'.'])
    end    
end

clear n