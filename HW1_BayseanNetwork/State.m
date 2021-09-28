% State is set of variable value represented as table type.
% ex) C = 1, S = 1, R = 0, W = 1
classdef State
    properties
        stateTable
    end
    
    methods
        function obj = State(givenTable)
            obj.stateTable = givenTable;
        end
        
        % update stateTable with new r.v.
        function updatedState = insertNewVar(obj, var, value)
            tmpState = obj;
            tmpState.stateTable.(var) = value;
            updatedState = tmpState;
        end
    end
end

