function [f,g] = autoencoder(datacell, vocabulary, output, ei, init)
%AUTOENCODER Summary of this function goes here
%   Detailed explanation goes here

% ei has these fields
% dimensionality = no. of dimensions the word has
% outputsize = no. of classes
% depth = no. of words in the sentence
% alpha - alpha value
% lambda - lambda value

% input and output --
% input - txnxd vector
% output - txo vector - o = outputsize
% issues : i don't understand the norm1tanh_prime function. it's giving weird answer

    t = length(datacell);
    f = 0;
    g = zeros(size(init));
    init = params2stack(init, ei);
    for i = 1:t
        i
        vocabIndices = datacell{i};
        input = vocabulary(vocabIndices, :);
        %this should ideally be autoencoder(@norm1tanh, @norm1tanh_prime, init, ei, input(i,:), out(i,:));
        ei.depth = length(vocabIndices);
        [f1 g1] = calc(@norm1tanh, @norm1tanh_prime, init, ei, input, output(i), vocabIndices);
        f = f + f1;
        g = g + g1;
    end
    init = stack2params(init);
    f = f +  0.5 * ei.lambda * norm(init)^2;
    g = g + ei.lambda*g;
end

