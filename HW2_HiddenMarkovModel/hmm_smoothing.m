function [smooP,smoothing_result] = hmm_smoothing(hmm, observation, interval)
    % decalre hmm vars for readability
    initial_state = hmm.Pi;
    transition_model = hmm.A;
    observation_model = hmm.B;
    
    % decalre and size formatting for returns
    smoothing_result = zeros(length(initial_state), interval);
    smooP = zeros(1, interval);
    
    % get forward vectors i.e. filtering_result
    % initialize backward vectors
    [~, forward] = hmm_filtering(hmm, observation);
    backward = ones(length(initial_state), interval);
    
    % multiple forward, backward. then normalize
    for i = interval : -1 : 1
        % push f(i)*b(i) to sv
        tmp = forward(:, i) .* backward(:, i);
        smoothing_result(:, i) = hmm_normalize(tmp);
        smooP(:, i) = find(tmp == max(tmp));
        % calc : T O(i) b(i)
        if i > 1
            tmp = diag(observation_model(:, observation(i))) * backward(:, i);
            tmp = transition_model * tmp;
            backward(:, i - 1) = tmp;
        end
    end    
end
