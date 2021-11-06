function [optimal_seq] = hmm_viterbi(hmm,observation)
    % decalre hmm vars for readability
    initial_state = hmm.Pi;
    transition_model = hmm.A;
    observation_model = hmm.B;
    
    % max probability for each states
    max_prob = zeros(length(initial_state), length(observation));
    % arg_max for backtracking
    arg_max = zeros(length(initial_state), length(observation));
    
    % update all max_prob and arg_max
    for i = 1 : 1 : length(observation)
        if i == 1
            % calc P(X1 | e1)
            tmp = transition_model' * initial_state;
        else
            % calc transition prob for all case and get max idx
            tmp = transition_model' .* max_prob(:, i - 1)';
            [tmp, arg_max(:, i)] = max(tmp, [], 2);
        end
        tmp = observation_model(:, observation(i)) .* tmp;
        max_prob(:, i) = hmm_normalize(tmp);
    end
    
    % backtracking to find state sequence
    optimal_seq_num = zeros(size(observation));
    optimal_seq = strings(size(observation));
    weather_list = ["Sunny", "Cloudy", "Rainy"];
    for i = length(observation) : -1 : 1
        if i == length(observation)
            [~, current_state] = max(max_prob(:, i));
        else
            current_state = arg_max(optimal_seq_num(i + 1), i + 1);
        end
        optimal_seq_num(i) = current_state;
        optimal_seq(i) = weather_list(current_state);
    end
end

