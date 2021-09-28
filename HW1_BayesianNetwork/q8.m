% generate all the nodes and bayesianNetwork bn
nodeC = Node('C', [], 0.7);
nodeS = Node('S', 'C', [0.05, 0.65]);
nodeR = Node('R', 'C', [0.90, 0.30]);
nodeW = Node('W', ['S', 'R'], [0.99, 0.85, 0.80, 0.10]);
bn = [nodeC, nodeS, nodeR, nodeW];

% direct sampling
N = 15000;
header = {'W', 'S', 'R', 'samples'};
mat = [1 1 1 0; 1 1 0 0; 1 0 1 0; 1 0 0 0; 0 1 1 0; 0 1 0 0; 0 0 1 0; 0 0 0 0];
sampleDistribution = array2table(mat, 'VariableNames', header);
% make sampleDistribution w/ N samples
for i = 1 : 1 : N
    progress_debug = i
    sample = directSampling(bn);
    w = sample.stateTable.W;
    s = sample.stateTable.S;
    r = sample.stateTable.R;
    add = sampleDistribution(sampleDistribution.W == w & sampleDistribution.S == s & sampleDistribution.R == r, :).samples + 1;
    sampleDistribution(sampleDistribution.W == w & sampleDistribution.S == s & sampleDistribution.R == r, :).samples = add;
end
% get ProbabililtyDistribution
probTrueW = sampleDistribution(sampleDistribution.W == 1, :).samples / sum(sampleDistribution(sampleDistribution.W == 1, :).samples);
probFalseW = sampleDistribution(sampleDistribution.W == 0, :).samples / sum(sampleDistribution(sampleDistribution.W == 0, :).samples);
prob = [probTrueW ; probFalseW];
answer = [sampleDistribution, array2table(prob)];
answer.Properties.VariableNames{'prob'} = 'P(S,R|W)';
