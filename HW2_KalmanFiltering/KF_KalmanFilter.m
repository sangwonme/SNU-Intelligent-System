function [estimated_state] = KF_KalmanFilter(givenModel, observation)
    % import givenModel (this code follow notation on lecture note)
    A = givenModel.F;
    C = givenModel.H;
    Q = givenModel.Q;
    R = givenModel.CoZ;

    % setting vars w/ init state
    interval = length(observation);
    estimated_state = zeros(size(A,1), interval);
    P = eye(length(A));
    
    % Kalman Filtering for all interval
    for i = 2 : 1 : length(observation)
       % dynamic update
       tmp = A * estimated_state(:, i - 1);
       P = A * P * A' + Q;
       % Kalman Gain
       K = (P * C') / (C * P * C' + R);
       % measurement update
       estimated_state(:, i) = tmp + K * (observation(:, i) - C * tmp);
       P = P - K * C * P;
    end
end

