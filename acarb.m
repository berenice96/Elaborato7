load -ASCII co2.mat 
t = co2(:,1)';
y = co2(:,2)';

%Grafico del fenomeno
figure('Name',"Concentrazione di CO2 nell'atmosfera");
plot(t,y,'-o')
xlim([0 216]);
xlabel('Mesi');
ylabel('CO2');

%Analisi dello spettro
Fs = 1;
N = length(y);
Y = fft(y);
Y(1) = [];
f = (1:floor(N/2))*Fs/N;
pow = (2*abs(Y(1:floor(N/2))/N)).^2;

%Periodogramma
figure('Name','Periodogramma');
stem(f,pow,'fill','MarkerFaceColor','red','MarkerEdgeColor','green');
xlabel('cicli/mesi');
ylabel('Potenza');

max(pow) %calcolo della massima potenza
f(pow == max(pow)) %frequenza alla quale la potenza è massima

%si visualizza la potenza in funzione del periodo
figure('Name','Periodogramma');
p = 1./f;
stem(p,pow,'fill','MarkerFaceColor','red','MarkerEdgeColor','green');
xlabel('periodo(mesi/ciclo)');
ylabel('Potenza');

%calcolo del ciclo in cui il fenomeno ha la massima potenza:
p(pow == max(pow))