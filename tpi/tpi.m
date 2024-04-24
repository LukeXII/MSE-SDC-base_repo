clc
clear all

largo_entrada = 1000;

stages = 7;
data_bits = 1;
code_bits = 3;
prob_error = 0.5;

input = randi([0 1], 1, largo_entrada);

%% 

trellis1 = poly2trellis(7,[171 133]);
codedout1 = convenc(input, trellis1);

codedout1 = bsc(codedout1, prob_error);

%% 

decodedout = vitdec(codedout1, trellis1, 7*(stages - 1), 'cont', 'unquant');

[num, ratio] = biterr(input, decodedout)