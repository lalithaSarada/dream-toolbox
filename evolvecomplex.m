function [curCompl,acceptedChild] = evolvecomplex(scemPar,curCompl,curSeq,propChild)
%
% <a href="matlab:web(fullfile(scemroot,'html','evolvecomplex.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

% global DEBUG_VAR_Ratio 
% global DEBUG_REPLACE_BEST
% global DEBUG_REPLACE_WORST

iterCol = scemPar.iterCol;
objCol = scemPar.objCol;

% determine the last iteration in the current sequence:
maxIter = max(curSeq(:,iterCol));
lastEvalFromSeq = curSeq(:,iterCol)==maxIter;

% determine the density of the last iteration in the current sequence:
lastDensFromSeq = curSeq(lastEvalFromSeq,objCol);

% determine the best density in the current complex:
bestEvalRowNumber = randchoose(curCompl(:,scemPar.objCol)==max(curCompl(:,objCol)));
bestDensFromCompl = curCompl(bestEvalRowNumber,objCol);


% determine the worst density in the current complex:
worstEvalRowNumber = randchoose(curCompl(:,scemPar.objCol)==min(curCompl(:,objCol)));
worstDensFromCompl = curCompl(worstEvalRowNumber,objCol);


densRatio = propChild(1,objCol)/lastDensFromSeq;

randUniDraw = rand;

% metropolis annealing:
switch scemPar.optMethod
    case 'direct probability'
        
        % determine the ratio between the best and worst evaluations 
        % in the current complex (\Gamma^{\itk}):
        bestWorstRatio = bestDensFromCompl/worstDensFromCompl;
        
        if densRatio > randUniDraw

            % replace the best member of the complex with the proposed offspring
            curCompl(bestEvalRowNumber,:) = propChild;
            acceptedChild = propChild;

        elseif ((bestWorstRatio > scemPar.thresholdL) & (lastDensFromSeq > worstDensFromCompl))

            prevChild = [propChild(1,iterCol),curSeq(lastEvalFromSeq,2:end)];
            acceptedChild = prevChild;
            curCompl(worstEvalRowNumber,:) = prevChild;

        else

            prevChild = [propChild(1,iterCol),curSeq(lastEvalFromSeq,2:end)];
            acceptedChild = prevChild;

        end
        
    case 'likelihood'
        
    case 'error minimization'

        nMeasurements = scemPar.nMeasurements;
        
        % determine the ratio between the best and worst evaluations 
        % in the current complex (\Gamma^{\itk}):
        bestWorstRatio = (bestDensFromCompl/worstDensFromCompl)^(-nMeasurements*(1+scemPar.kurt)/2);

        if densRatio^(-nMeasurements*(1+scemPar.kurt)/2) > randUniDraw

            % replace the best member of the complex with the proposed offspring
            curCompl(bestEvalRowNumber,:) = propChild;
            acceptedChild = propChild;

        elseif ((bestWorstRatio > scemPar.thresholdL) & (lastDensFromSeq > worstDensFromCompl))

            prevChild = [propChild(1,iterCol),curSeq(lastEvalFromSeq,2:end)];
            acceptedChild = prevChild;

            curCompl(worstEvalRowNumber,:) = prevChild;

        else

            prevChild = [propChild(1,iterCol),curSeq(lastEvalFromSeq,2:end)];
            acceptedChild = prevChild;

        end
end



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % %        LOCAL FUNCTION     % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %



function rowNumber = randchoose(logiVec)

TMP = randperm(sum(logiVec));
randChoice = TMP(1);
clear TMP
for n=1:numel(logiVec)
    if logiVec(n)
        randChoice=randChoice-1;
    end
    if randChoice==0
        rowNumber = n;
        break
    end
end


