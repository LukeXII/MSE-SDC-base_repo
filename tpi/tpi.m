clc
clear all

num_iter = 10;
EbNo_vec = 1:num_iter;
err_bpsk = zeros(1, num_iter);

for i = 1:num_iter
    EbNo = i;
    sim('tpi_sim');
    err_bpsk(i) = ErrorVec(1,1);
end

%%

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