clc
clear all

stages1 = 7;
num_iter = 8;
max_symbols = 2e4;
EbNo_vec = 1:num_iter;

bpsk_cod_sim = zeros(1, num_iter);
bpsk_sim = zeros(1, num_iter);

trellis1 = poly2trellis(stages1,[171 133]);
tbd1 = 5*(stages1 - 1);

for EbNo = 1:num_iter
    sim('tpi_sim');
    
    bpsk_cod_sim(EbNo) = bpsk_cod(1,1);
    bpsk_sim(EbNo) = bpsk(1,1);
    
end

%%

largo_entrada = 1000;


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