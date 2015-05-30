%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Semi-Supervised Recursive Autoencoders for Predicting Sentiment Distributions
% Implementation based on Socher's paper
% http://www.socher.org/index.php/Main/Semi-SupervisedRecursiveAutoencodersForPredictingSentimentDistributions
% UCSD Neural Networks project CSE 291(aka CSE 253)
% Authors : Vincent Kuri, Sanjeev Shenoy, Madhavi Yenugal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear all variables and start training afresh
clearvars;clc;clear;

% Make sure you add ./tools folder to your path because it contains important functions used in the code
% Using genpath to include all subfolders
addpath(genpath('./tools'));

%%%%%%%%%%%%%%%%%%%%%%%%
% Setting parameters for training
%%%%%%%%%%%%%%%%%%%%%%%%
% Empty parameter structure
parameters = struct;

% Dimensionality of the word size, change according to the word size required
parameters.word_size = 50;

% Regularization parameters, adapted from the paper
% Regularization for W(1), W(2), W(Label), L
parameters.regularization = [1e-05, 1e-04, 1e07, 1e-02];

% Weightage for errors
parameters.error_weightage = 0.2;

% Normalization function
parameters.norm_func = @norm1tanh;

%%%%%%%%%%%%%%%%%%%%%%%%
% Minfunc parameters
%%%%%%%%%%%%%%%%%%%%%%%%
% Empty options structure
options = struct;

% Maximum number of iterations
options.maxIter = 70;

% Display mode
options.display = 'iter';

% Optimization method, can try different methods for minfunc as well
options.Method = 'lbfgs';

%%%%%%%%%%%%%%%%%%%%%%%%
% Read the dataset
%%%%%%%%%%%%%%%%%%%%%%%%
params_dataset = struct;

% Setting the path for the dataset
params_dataset.path = '..\Dataset\';

% Setting filenames for the positive and negative datasets
params_dataset.filename_positive = 'rt-polarity.pos';
params_dataset.filename_negative = 'rt-polarity.neg';

% Setting the paths for the binarized positive and negative reviews
params_dataset.pos_binarized = 'rt-polarity_pos_binarized.mat';
params_dataset.neg_binarized = 'rt-polarity_neg_binarized.mat';
params_dataset.cv_obj = 'cv_obj.mat';

% Specify the fold
params_dataset.kfold = 1;

% Preprofile settings
params_dataset.filename_preprofile = 'preprofile.mat';

% Load from preprofile if it exists
preprofile_path = strcat(params_dataset.path, params_dataset.filename_preprofile);
if exist(preprofile_path, 'file') == 2
	load(preprofile_path, 'labels','train_ind','test_ind', 'cv_ind', 'ww', 'dictNum', 'test_nums');
else
	read_dataset(params_dataset, parameters);
    load(preprofile_path, 'labels','train_ind','test_ind', 'cv_ind', 'ww', 'dictNum', 'test_nums');
end

dictLength = length(ww);
num_training_ex = length(dictNum(train_ind));





