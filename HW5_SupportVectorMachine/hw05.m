%% setting & load data
clc;
clear;

% load train data
train_data = table2array(readtable('Sat_train.csv'));
train_feature = zscore(train_data(:, 1:36));
train_label = train_data(:, 37);

% load test data
test_data = table2array(readtable('Sat_test.csv'));
test_feature = zscore(test_data(:, 1:36));
test_label = test_data(:, 37);

%% (a) linear kernel
opts = '-s 0 -t 0';
model_lin = svmtrain(train_label, train_feature, opts);
[predicted_label_lin, accuracy_lin, decision_value_lin] = svmpredict(test_label, test_feature, model_lin);

%% (b) gaussian kernel
opts = '-s 0 -t 2';
model_gaus = svmtrain(train_label, train_feature, opts);
[predicted_label_gaus, accuracy_gaus, decision_value_gaus] = svmpredict(test_label, test_feature, model_gaus);

%% (c) varified w/ gamma
accuracy = 0;
target_gamma = 0;
history = 
for log_gamma = -3 : 0.1 : 0
    opts = ['-s 0 -t 2 -v 5 -g ', num2str(2^log_gamma)];
    cv_accuracy = svmtrain(train_label, train_feature, opts);
    if(cv_accuracy > accuracy)
        target_gamma = 2^log_gamma;
        accuracy = cv_accuracy;
    end
end
disp(target_gamma);
