% Generate Factor
classdef Factor
    % all factor has own matrix, 
    % but with undecided vars it is represented as table
    properties
        factorTable
    end
    
    methods
        % constructor : table type to Factor type
        function obj = Factor(table)
            obj.factorTable = table;
        end
        
        % check if there is same var given by param
        function outputArg = checkWantedVars(obj, varList)
            tmp = string.empty;
            for i = 1 : 1 : length(varList)
                targetVar = string(varList(i));
                if find(string(obj.factorTable.Properties.VariableNames) == targetVar)
                    tmp(end+1) = targetVar;
                end
            end
            outputArg = tmp;
        end
        
        % sumOut function
        function outputArg = sumOut(obj, sumoutVar)
            T = obj.factorTable;
            trueSet = removevars(T(T.(sumoutVar) == 1, :), sumoutVar);
            falseSet = removevars(T(T.(sumoutVar) == 0, :), sumoutVar);
            trueSet.prob = trueSet.prob + falseSet.prob;
            outputArg = trueSet;
        end
        
        % normalize
        function outputArg = normalize(obj)
            probs = obj.factorTable.prob;
            inversedAlpha = sum(probs);
            outputArg = probs/inversedAlpha;
        end
    end
    methods (Static)
        % type casting : node -> factor
        function outputArg = node2factor(node, evidence)
            T = node.probabilityTable;
            evidenceVar = evidence.keys;
            for i = 1 : 1 : length(evidenceVar)
                var = string(evidenceVar(i));
                if find(string(T.Properties.VariableNames) == var)
                    tmpTable = removevars(T(T.(var) == evidence(var), :), var);
                    outputArg = Factor(tmpTable);
                    return;
                end
            end
            outputArg = Factor(T);
        end
        
       % pointwise product factors (2 operands)
        function outputArg = pointwiseProduct(f1, f2)
            if length(f1.factorTable.Properties.VariableNames) == 2
                shortT = f1.factorTable;
                longT = f2.factorTable;
            else
                shortT = f2.factorTable;
                longT = f1.factorTable;
            end
            targetVar = string(shortT.Properties.VariableNames(1));
            updated4True = longT(longT.(targetVar) == 1, :).prob * shortT(shortT.(targetVar) == 1, :).prob;
            longT(longT.(targetVar) == 1, :).prob = updated4True;
            updated4False = longT(longT.(targetVar) == 0, :).prob * shortT(shortT.(targetVar) == 0, :).prob;
            longT(longT.(targetVar) == 0, :).prob = updated4False;
            outputArg = Factor(longT);         
        end
    end
end

