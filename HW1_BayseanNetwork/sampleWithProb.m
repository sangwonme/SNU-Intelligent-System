% with given probability return random value
function randomValue = sampleWithProb(prob)
    if rand <= prob
        randomValue = true;
    else
        randomValue = false;
    end
end

