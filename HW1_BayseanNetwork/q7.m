% generate all the nodes and bayesianNetwork bn
nodeB = Node('B', [], 0.01);
nodeE = Node('E', [], 0.009);
nodeA = Node('A', ['B', 'E'], [0.98, 0.89, 0.14, 0.01]);
nodeJ = Node('J', 'A', [0.65, 0.08]);
nodeM = Node('M', 'A', [0.94, 0.03]);
bn = [nodeB, nodeE, nodeA, nodeJ, nodeM];

% query, evidence, hidden var setting
query = 'B';
evidence = containers.Map;
evidence('J') = 1;
evidence('M') = 1;
hidden = {'E', 'A'};

% 7-a
tmp = variableElimination(bn, evidence, hidden);
tmp = [[1;0], tmp];
header = {query, 'P(B|j,m)'};
answerA = array2table(tmp, 'VariableNames', header);

% 7-b
evidence('J') = 0; evidence('M') = 0;
tmp1 = [[0 0 1 ; 0 0 0], variableElimination(bn, evidence, hidden)];
evidence('J') = 0; evidence('M') = 1;
tmp2 = [[0 1 1 ; 0 1 0], variableElimination(bn, evidence, hidden)];
evidence('J') = 1; evidence('M') = 0;
tmp3 = [[1 0 1 ; 1 0 0], variableElimination(bn, evidence, hidden)];
evidence('J') = 1; evidence('M') = 1;
tmp4 = [[1 1 1 ; 1 1 0], variableElimination(bn, evidence, hidden)];
tmp = [tmp1 ; tmp2 ; tmp3 ; tmp4];
header = {'J', 'M', query, 'P(B|J,M)'};
answerB_1 = array2table(tmp, 'VariableNames', header);

query = 'E';
hidden = {'B', 'A'};
evidence('J') = 0; evidence('M') = 0;
tmp1 = [[0 0 1 ; 0 0 0], variableElimination(bn, evidence, hidden)];
evidence('J') = 0; evidence('M') = 1;
tmp2 = [[0 1 1 ; 0 1 0], variableElimination(bn, evidence, hidden)];
evidence('J') = 1; evidence('M') = 0;
tmp3 = [[1 0 1 ; 1 0 0], variableElimination(bn, evidence, hidden)];
evidence('J') = 1; evidence('M') = 1;
tmp4 = [[1 1 1 ; 1 1 0], variableElimination(bn, evidence, hidden)];
tmp = [tmp1 ; tmp2 ; tmp3 ; tmp4];
header = {'J', 'M', query, 'P(E|J,M)'};
answerB_2 = array2table(tmp, 'VariableNames', header);



