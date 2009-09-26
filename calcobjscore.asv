function [evalResults,nModelEvals] = calcobjscore(dreamPar,evalResults,nModelEvals, iteration)
%
% <a href="matlab:web(fullfile(scemroot,'html','calcobjscore.html'),'-helpbrowser')">View HTML documentation for this function in the help browser</a>    
%

iterCol = dreamPar.iterCol;
parCols = dreamPar.parCols;
objCol = dreamPar.objCol;
logPCol = dreamPar.logPCol;
evalCol = dreamPar.evalCol;

idx = 0;

for r = 1:size(evalResults,1)
    if ~all(isnan(evalResults(r,:))) && ~evalResults(r,evalCol)
        % the model has not been evaluated with...
        % the parameters in the current row

        % Set the 'model iteration' number:
        nModelEvals = nModelEvals + 1;
        idx = idx +1;
        evalResults(r,iterCol) = iteration*10 + idx;

        % read a line from the matrix containing rows of parameter vectors
        parVec = evalResults(r,parCols);

        if dreamPar.verboseOutput        
            % update the progress indicator:
            dispprogress(dreamPar,nModelEvals)
        end

        try
            % let the model under consideration run with the selected
            % parameters:
            eval(dreamPar.modelCallStr);

        catch
            
            evalResults(r,objCol) = NaN;

            warning('DREAM:errorDuringModelEvaluation',...
                    ['An error occurred while evaluating the model.'])
            
        end

        
        try

            % compare the model result with the measurements and calculate the...
            % corresponding score according to an objective function:
            eval(dreamPar.objCallStr)

            evalResults(r,[objCol,logPCol]) = [objScore,logObjScore];
            
            if isnan(objScore)
                warning('DREAM:objectiveScoreEqualsNaN',...
                    'Objective score is NaN')
            end
            
        catch
            
            evalResults(r,objCol) = NaN;

            warning('DREAM:errorDuringCallToObjectiveFunction',...
                    ['An error occurred while calculati',...
                    'ng the objective score.'])
            
        end
        
        
       

        % Set the 'model evaluated' flag to true:
        evalResults(r,evalCol) = true;
        
        if dreamPar.verboseOutput
            numDecimals = max(0,ceil(log10(dreamPar.nModelEvalsMax/100)));
            fprintf(1,repmat('\b',[1,19+...
                numDecimals+5+3]))
        end

    end
end



function dispprogress(dreamPar,nModelEvals)

p = 100*nModelEvals/dreamPar.nModelEvalsMax;
numDecimals = max(0,ceil(log10(dreamPar.nModelEvalsMax/100)));
str = sprintf(['scem-ua progress : %% %d.%df %%%%',char(10)],numDecimals+5,numDecimals);
fprintf(1,str,p)

