function [seq_likelihood] = hmm_likelihood(hmm,observation)
    % decalre hmm vars for readability
    initial_state = hmm.Pi;
    transition_model = hmm.A;
    observation_model = hmm.B;
    
    % let tmp_l(t) = P(Xt = xt, e_1:t)
    % calc tmp_l for all observation
    tmp_l = zeros(length(initial_state), length(observation));
    for i = 1 : 1 : length(observation)
        if i == 1
            tmp = transition_model' * initial_state;
        else
            tmp = transition_model' * tmp_l(:, i - 1);
        end
        tmp_l(:, i) = observation_model(:, observation(i)) .* tmp;
    end
    
    % likelihood is sum of all states
    seq_likelihood = sum(tmp_l(:, length(observation)));
end

