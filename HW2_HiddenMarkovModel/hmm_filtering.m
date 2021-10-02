function [filtP,filtering_result] = hmm_filtering(hmm,observation)
    % decalre hmm vars for readability
    initial_state = hmm.Pi;
    transition_model = hmm.A;
    observation_model = hmm.B;
    
    % decalre and size formatting for returns
    filtering_result = zeros(length(initial_state), length(observation));
    filtP = zeros(size(observation));
    
    % calc for observation size
    % calc : f(i) = alpha O T' f(i-1)
    for i = 1 : 1 : length(observation)
        if i == 1
            tmp = transition_model' * initial_state;
        else
            tmp = transition_model' * filtering_result(:, i - 1);
        end
        tmp = observation_model(:, observation(i)) .* tmp;
        filtering_result(:, i) = hmm_normalize(tmp);
        filtP(:, i) = find(tmp == max(tmp));        
    end    
end

