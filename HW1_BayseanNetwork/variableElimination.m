function outputArg = variableElimination(bn, evidence, hidden)
    % make factors arr : gonna be used as stack
    factors = Factor.empty;
    for i = 1 : 1 : length(bn)
        factors(end+1) = Factor.node2factor(bn(i), evidence);
    end
    while length(factors) > 1
        % pointwise product
        f1 = factors(end);
        f2 = factors(end-1);
        factors = factors(1 : end-2);
        factors(end+1) = Factor.pointwiseProduct(f1, f2);
        % if hidden -> sumOut
        if length(factors) > 1
            hiddenInEnd = checkWantedVars(factors(end), hidden);
            hiddenInSecondend = checkWantedVars(factors(end-1), hidden);
            for i = 1 : 1 : length(hiddenInEnd)
                if ~ismember(hiddenInEnd(i), hiddenInSecondend) && ismember(hiddenInEnd(i), checkWantedVars(f1, hidden))
                    targetVar = hiddenInEnd(i);
                    factors(end) = sumOut(factors(end), targetVar);
                end
            end
        end
        if length(factors) == 1
            hiddenInFactor = checkWantedVars(factors(1), hidden);
            if length(hiddenInFactor) == 1
                factors(1) = sumOut(factors(1), hiddenInFactor(1));
            end
        end
    end
    outputArg = normalize(factors(1));
end

