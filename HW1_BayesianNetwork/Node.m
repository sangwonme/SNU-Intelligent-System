% Generate each node in bn.
classdef Node
    % all node has own conditional probability table as Figure in HW.
    properties
        probabilityTable
        query
        parents
    end
    
    methods
        % constructor
        function obj = Node(var,parentVar, probability)
            tmpMatrix = [];
            varNum = 1 + length(parentVar);
            entry = 2^(varNum);
            for i = entry - 1 : -1 : 0
                j = entry - i;
                if j <= length(probability)
                    row = [logical(num2str(dec2bin(i, varNum)) - '0'), probability(j)];
                else
                    row = [logical(num2str(dec2bin(i, varNum)) - '0'), 1 - probability(j - entry/2)];
                end
                tmpMatrix = [tmpMatrix ; row];
            end
            header = cat(2, num2cell(var), num2cell(parentVar), {'prob'});
            obj.probabilityTable = array2table(tmpMatrix, 'VariableNames', header);
            obj.query = var;
            obj.parents = parentVar;
        end
    end
end

