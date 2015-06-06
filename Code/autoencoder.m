function [f,g, pred_prob] = autoencoder( init, ei, datacell, output, just_pred)
%AUTOENCODER Summary of this function goes here
%   Detailed explanation goes here

% ei has these fields
% dimensionality = no. of dimensions the word has
% outputsize = no. of classes
% depth = no. of words in the sentence
% alpha = alpha value
% lambda = lambda value

% input and output --
% input - txnxd vector
% output - txo vector - o = outputsize
% issues : i don't understand the norm1tanh_prime function. it's giving weird answer

   
    t = length(datacell);
    
    pred_prob = zeros(t, ei.outputsize);
    
    f = 0;
    g = zeros(size(init));
    init = params2stack(init, ei);
    for i = 1:t
        if mod(i,200) == 0
            i;
        end
        vocabIndices = datacell{i};
        input = init.W(vocabIndices, :);
        %this should ideally be autoencoder(@norm1tanh, @norm1tanh_prime, init, ei, input(i,:), out(i,:));
        ei.depth = length(vocabIndices);
        [f1 g1 pred] = calc(@norm1tanh, @norm1tanh_prime, init, ei, input, output(i), vocabIndices, just_pred);
        if just_pred
            pred_prob(i,:) = pred;
        else
            f = f + f1;
            g = g + g1;
        end
    end
    
    if just_pred 
        f = -1;
        g = [];
        return;
    end
    init = stack2params(init);
    f = f/t +  0.5 * ei.lambda * norm(init)^2;
    g = g/t + ei.lambda*init;    
end

