clc
clear all

stages1 = 7;
stages2 = 3;
stages3 = 5;
stages4 = 9;
num_iter = 10;
max_symbols = 3e5;
EbNo_vec = 1:num_iter;

bpsk_cod_sim = zeros(1, num_iter);
bpsk_sim = zeros(1, num_iter);
qpsk_cod_sim = zeros(1, num_iter);
qpsk_sim = zeros(1, num_iter);
psk8_cod_sim = zeros(1, num_iter);
psk8_sim = zeros(1, num_iter);
qam16_cod_sim = zeros(1, num_iter);
qam16_sim = zeros(1, num_iter);
qam64_cod_sim = zeros(1, num_iter);
qam64_sim = zeros(1, num_iter);
cod2_sim = zeros(1, num_iter);
cod3_sim = zeros(1, num_iter);
cod4_sim = zeros(1, num_iter);

trellis1 = poly2trellis(stages1,[171 133]);
tbd1 = 5*(stages1 - 1);

trellis2 = poly2trellis(stages2,[5 7]);         % cod2
tbd2 = 5*(stages2 - 1);

trellis3 = poly2trellis(stages3,[35 23]);
tbd3 = 5*(stages3 - 1);

trellis4 = poly2trellis(stages4,[753 561]);
tbd4 = 5*(stages4 - 1);

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
    
    qam64_cod_sim(EbNo) = qam64_cod(1,1);
    qam64_sim(EbNo) = qam64(1,1)/6;
    
    cod2_sim(EbNo) = cod2(1,1);
    cod3_sim(EbNo) = cod3(1,1);
    cod4_sim(EbNo) = cod4(1,1);
    
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

figure(3)

semilogy(EbNo_vec, psk8_sim, '--o', ...
        EbNo_vec, psk8_cod_sim, '--v', ...
        EbNo_vec, psk8_teo, 'LineWidth', 3.5);

legend('8PSK s/cod. sim.', '8PSK c/cod. sim.', '8PSK s/cod. teo.');
title('8PSK - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% 16-QAM con/sin cod. sim y teo.

qam16_teo = berawgn(EbNo_vec, 'qam', 16, 'nondiff');

figure(4)

semilogy(EbNo_vec, qam16_sim, '--o', ...
        EbNo_vec, qam16_cod_sim, '--v', ...
        EbNo_vec, qam16_teo, 'LineWidth', 3.5);

legend('16-QAM s/cod. sim.', '16-QAM c/cod. sim.', '16-QAM s/cod. teo.');
title('16-QAM - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% 64-QAM con/sin cod. sim y teo.

qam64_teo = berawgn(EbNo_vec, 'qam', 64, 'nondiff');

figure(5)

semilogy(EbNo_vec, qam64_sim, '--o', ...
        EbNo_vec, qam64_cod_sim, '--v', ...
        EbNo_vec, qam64_teo, 'LineWidth', 3.5);

legend('64-QAM s/cod. sim.', '64-QAM c/cod. sim.', '64-QAM s/cod. teo.');
title('64-QAM - Con/sin cod.');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% Todas las modulaciones sin codificar

figure(6)

semilogy(EbNo_vec, bpsk_sim, '--o', ...
        EbNo_vec, qpsk_sim, '--v', ...
        EbNo_vec, psk8_sim, '--square', ...
        EbNo_vec, qam16_sim, '--diamond', ...
        EbNo_vec, qam64_sim, '-->', 'LineWidth', 3.5);

legend('BPSK', 'QPSK', '8PSK', '16-QAM', '64-QAM');
title('BER simulado para todas las modulaciones sin codificar');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% Todas las modulaciones con codificacion

figure(7)

semilogy(EbNo_vec, bpsk_cod_sim, '--o', ...
        EbNo_vec, qpsk_cod_sim, '--v', ...
        EbNo_vec, psk8_cod_sim, '--square', ...
        EbNo_vec, qam16_cod_sim, '--diamond', ...
        EbNo_vec, qam64_cod_sim, '-->', 'LineWidth', 3.5);

legend('BPSK', 'QPSK', '8PSK', '16-QAM', '64-QAM');
title('BER simulado para todas las modulaciones con codificacion 171 133');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;

%%

% Otros codigos convolucionales

figure(8)

semilogy(EbNo_vec, cod2_sim, '--o', ...
        EbNo_vec, cod3_sim, '--v', ...
        EbNo_vec, qpsk_cod_sim, '--square', ...
        EbNo_vec, cod4_sim, '-->', 'LineWidth', 3.5);

legend('3 [5 7]', '5 [35 23]', '7 [171 133]', '9 [753 561]');
title('Codigos convolucionales 1/2 de 3, 5, 7 y 9 etapas');
xlabel('Eb/No [dB]');
ylabel('Bit Error Rate');

grid on;