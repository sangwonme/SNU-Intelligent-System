% direct sampling algorithm
function sampleState = directSampling(bn)
    tmpState = State(table.empty);
    for i = 1 : 1 : length(bn)
        % get query, parents, probTable
        query = bn(i).query;
        parents = bn(i).parents;
        probTable = bn(i).probabilityTable;
        % get (conditional) probability of node event occur
        probTable = probTable(probTable.(query) == true, :);
        for j = 1 : 1 : length(parents)
            parentVar = string(parents(j));
            parentValue = tmpState.stateTable.(parentVar);
            probTable = probTable(probTable.(parentVar) == parentValue, :);
        end
        eventProb = probTable.prob;
        % sampling w/ eventProb -> update state
        tmpState = insertNewVar(tmpState, query, sampleWithProb(eventProb));
    end
    sampleState = tmpState;
end

