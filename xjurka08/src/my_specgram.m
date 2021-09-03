%kod pro zobrazeni spektrogramu signalu
% s je vstupni signal
x = s - mean(s)
Fs = 16000; N = 512; wlen = 25e-3 * Fs; wshift = 10e-3*Fs; woverlap = wlen - wshift;
win = hamming(wlen);
f = (0:(N/2-1)) / N * Fs;
t = (0:(1 + floor((length(x) - wlen) / wshift) - 1))* wshift/Fs;
X = specgram (x, N, Fs, win, woverlap);
imagesc(t,f,10*log(abs(X).^2));
set (gca (), "ydir", "normal"); xlabel ("Time"); ylabel ("Frequency"); colormap(jet);