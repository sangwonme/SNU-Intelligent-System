clc;
clear;
close all;

%% Setting
load KF_data_a.mat
givenModel.F = [1 1 0 0 ; 0 0.98 0 0 ; 0 0 1 1 ; 0 0 0 0.98];
givenModel.H = [1 0 0 0 ; 0 0 1 0];
givenModel.Q = eye(4);
givenModel.CoX_0 = eye(2);
givenModel.CoZ = [2500 0 ; 0 2500];

%% Problem (a)
plot(x(1, :), x(3, :), '-', 'color', 'blue');
xlabel('x1');
ylabel('x2');
hold on;

%% Probelm (b)
plot(y(1, :), y(2, :), ':');

%% Probelm (c)
estimated_state = KF_KalmanFilter(givenModel, y);
plot(estimated_state(1, :), estimated_state(3, :), '-', 'color', 'magenta');
legend('true position', 'noisy observation', 'estimated position');