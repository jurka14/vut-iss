%kod pro vypocet skore pro vetu
% s je vstupni signal
% je nutne pred timto skriptem spustit skript my_query
x = s - mean(s);
Fs = 16000; N = 512; wlen = 25e-3 * Fs; wshift = 10e-3*Fs; woverlap = wlen - wshift;
win = hamming(wlen);
f = (0:(N/2-1)) / N * Fs;
t = (0:(1 + floor((length(x) - wlen) / wshift) - 1))* wshift/Fs;
X = specgram (x, N, Fs, win, woverlap);
P = 10*log(abs(X).^2);

pocet_ramcu_vety = size(P, 2);
pocet_ramcu_q1 = size(Fq1, 2);
pocet_ramcu_q2 = size(Fq2, 2);

features = reshape(P, 16, pocet_ramcu_vety, 16);
features = sum(features);
features = reshape(features, 16, pocet_ramcu_vety);

clear score1;
clear score2;
score_index = 1; %index matice skore

%posouvej se po peti ramcich, posledni pozice se plne prekryva
for index = 1:5:pocet_ramcu_vety - pocet_ramcu_q1 
  
  score1(score_index) = corr2(Fq1, features(:, index:index+pocet_ramcu_q1-1));%vypocet koeficientu
  score_index = score_index +1;%posun indexu
   
endfor

score_index = 1;

for index = 1:5:pocet_ramcu_vety - pocet_ramcu_q2
  
  score2(score_index) = corr2(Fq2, features(:, index:index+pocet_ramcu_q2-1));
  score_index = score_index +1;
   
endfor


dt = 1/Fs;
ts = 0:dt:(length(s)*dt)-dt;
subplot(3, 1, 1), plot(ts,s); ylabel('signal');

subplot(3, 1, 2), imagesc(t,f,features);
set (gca (), "ydir", "reverse");
ylabel ("features");
yticklabels(0:5:1000);

subplot(3, 1, 3), plot (score1);
hold on;
subplot(3, 1, 3), plot (score2);
legend('northeast', 'penetrated');
set(gca,'XTick',0:20:1200)
set(gca,'XTickLabel',0:1:100);
ylabel ("scores");
