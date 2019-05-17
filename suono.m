load vicru.mat

Fs = 8192;
n = length(y);
F = fft(y);
amp = 2*abs(F(1:floor(n/2)+1)/n);
f = (0:n/2)*Fs/n;

figure('Name','Periodogramma');
plot(f,amp);

N = 512;
figure('Name','Spettrogramma');
spectrogram(y,blackman(N),floor(0.5*N),N,Fs,'yaxis');

suono_filtrato = F;
ind = find(f>1500);
suono_filtrato(ind)=0;
suono_filtrato(n+2-ind)=0;

ampR = 2*abs(suono_filtrato(1:floor(n/2)+1)/n);
figure('Name','Periodogramma del segnale filtrato');
plot(f,ampR);
vicruR = ifft(suono_filtrato);

figure('Name','Spettrogramma del segnale filtrato');
spectrogram(vicruR,blackman(N),floor(0.5*N),N,Fs,'yaxis');
vicruR = vicruR/max(abs(vicruR));
audiowrite('vicruR.wav',vicruR,Fs);
%soundsc(real(treno))
