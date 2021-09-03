% kod pro vypocet parametru pro query
% s1 je vstupni signal q1 a s2 je vstupni signal q2

Fs = 16000; N = 512; wlen = 25e-3 * Fs; wshift = 10e-3*Fs; woverlap = wlen - wshift;
win = hamming(wlen);

% vypocet parametru pro q1
x1 = s1 - mean(s1);
X = specgram (x1, N, Fs, win, woverlap);
P = 10*log(abs(X).^2);

pocet_ramcu = size(P, 2);

Fq1 = reshape(P, 16, pocet_ramcu, 16);
Fq1 = sum(Fq1);
Fq1 = reshape(Fq1, 16, pocet_ramcu);

% vypocet parametru pro q2
x2 = s2 - mean(s2);
X = specgram (x2, N, Fs, win, woverlap);
P = 10*log(abs(X).^2);

pocet_ramcu = size(P, 2);

Fq2 = reshape(P, 16, pocet_ramcu, 16);
Fq2 = sum(Fq2);
Fq2 = reshape(Fq2, 16, pocet_ramcu);