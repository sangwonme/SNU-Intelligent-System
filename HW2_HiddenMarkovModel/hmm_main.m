clc;
clear all;
close all;

%% HMM consists of 5 elements.
hmm.N = 3;      % number of states. (weather - Sunny(1), Cloudy(2), Rainy(3))
hmm.M = 4;      % number of observations. (activity - Walking(1), Shopping(2), Cleaning(3), Movies(4)

hmm.Pi = [0.4; 0.2; 0.4];        % initial probability.
hmm.A = [0.5 0.4 0.1; 0.3 0.3 0.4; 0.2 0.4 0.4]; % transition model.   N*N matrix.
                            % A_ij = probability of transition from i-th
                            % state to j-th state.
hmm.B = [0.3 0.2 0.35 0.15; 0.5 0.2 0.1 0.2; 0.15 0.25 0.15 0.45];     % observation model. N*M matrix.
                                        % B_ij = probability of getting
                                        % j-th observation from i-th state.
 
O = [1 1 4 2 3 3 2 4 2 1];    

% TODO: implement the functions 'hmm_filtering', 'hmm_smoothing',
% 'hmm_likelihood', and'hmm_viterbi'.

%% Problem (a)
[filtP, filtering_result] = hmm_filtering(hmm, O);
filtering_result

%% Problem (b)
[smooP, smoothing_result] = hmm_smoothing(hmm, O, length(O));
smoothing_result

%% Problem (c)
hmm_visualize_bar(filtering_result, smoothing_result);

%% Problem (d)
[seq_likelihood] = hmm_likelihood(hmm, O);
seq_likelihood

%% Problem (e)
[optimal_seq] = hmm_viterbi(hmm, O);
optimal_seq
