clc
clear all

stages1 = 7;
num_iter = 10;
max_symbols = 5e4;
EbNo_vec = 1:num_iter;

bpsk_cod_sim = zeros(1, num_iter);
bpsk_sim = zeros(1, num_iter);
qpsk_cod_sim = zeros(1, num_iter);
qpsk_sim = zeros(1, num_iter);
psk8_cod_sim = zeros(1, num_iter);
psk8_sim = zeros(1, num_iter);
qam16_cod_sim = zeros(1, num_iter);
qam16_sim = zeros(1, num_iter);

trellis1 = poly2trellis(stages1,[171 133]);
tbd1 = 5*(stages1 - 1);

for EbNo = 1:num_iter
    sim('tpi_sim');
    
    bpsk_cod_sim(EbNo) = bpsk_cod(1,1);
    bpsk_sim(EbNo) = bpsk(1,1);
    
    qpsk_cod_sim(EbNo) = qpsk_cod(1,1);
    qpsk_sim(EbNo) = qpsk(1,1)/2;
    
    psk8_cod_sim(EbNo) = psk8_cod(1,1);
    psk8_sim(EbNo) = psk8(1,1)/3;
    
    qam16_cod_sim(EbNo) = qam16_cod(1,1);
    qam16_sim(EbNo) = qam16(1,1)/4;
    
end

%%

% BPSK con/sin cod. sim y teo.

bpsk_teo = berawgn(EbNo_vec, 'psk', 2, 'nondiff');
bpsk_cod_teo = bercoding(EbNo_vec, 'conv', 'hard', 1/2, distspec(trellis1,3));

figure(1)

semilogy(EbNo_vec, bpsk_sim, '--o', ...
        EbNo_vec, bpsk_cod_sim, '--v', ...
        EbNo_vec, bpsk_teo, ...
        EbNo_vec, bpsk_cod_teo, 'LineWidth', 3.5);
    
legend('BPSK s/cod. sim.', 'BPSK c/cod. sim.', 'BPSK s/cod. teo.', 'BPSK c/cod. teo.');
title('BPSK - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% QPSK con/sin cod. sim y teo.

qpsk_teo = berawgn(EbNo_vec, 'psk', 4, 'nondiff');
qpsk_cod_teo = bercoding(EbNo_vec, 'conv', 'hard', 1/2, distspec(trellis1,3));

figure(2)

semilogy(EbNo_vec, qpsk_sim, '--o', ...
        EbNo_vec, qpsk_cod_sim, '--v', ...
        EbNo_vec, qpsk_teo, ...
        EbNo_vec, qpsk_cod_teo, 'LineWidth', 3.5);

legend('QPSK s/cod. sim.', 'QPSK c/cod. sim.', 'QPSK s/cod. teo.', 'QPSK c/cod. teo.');
title('QPSK - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% 8PSK con/sin cod. sim y teo.

psk8_teo = berawgn(EbNo_vec, 'psk', 8, 'nondiff');
psk8_cod_teo = [0.5 0.5 0.5 0.5 0.1466848090 0.0258046628 0.0035222302 0.0003643322 0.0000279345 0.0000014887];

figure(3)

semilogy(EbNo_vec, psk8_sim, '--o', ...
        EbNo_vec, psk8_cod_sim, '--v', ...
        EbNo_vec, psk8_teo, ...
        EbNo_vec, psk8_cod_teo, 'LineWidth', 3.5);

legend('8PSK s/cod. sim.', '8PSK c/cod. sim.', '8PSK s/cod. teo.', '8PSK c/cod. teo.');
title('8PSK - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% 16-QAM con/sin cod. sim y teo.

qam16_teo = berawgn(EbNo_vec, 'qam', 16, 'nondiff');
qam16_cod_teo = [0.5 0.5 0.5 0.5 0.5 0.1120017182 0.0173575430 0.0019746309 0.0001643850 0.0000098397];

figure(4)

semilogy(EbNo_vec, qam16_sim, '--o', ...
        EbNo_vec, qam16_cod_sim, '--v', ...
        EbNo_vec, qam16_teo, ...
        EbNo_vec, qam16_cod_teo, 'LineWidth', 3.5);

legend('16-QAM s/cod. sim.', '16-QAM c/cod. sim.', '16-QAM s/cod. teo.', '16-QAM c/cod. teo.');
title('16-QAM - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;