load -ASCII co2.mat 
t = co2(:,1)';
y = co2(:,2)';

%Grafico del fenomeno
figure('Name',"Concentrazione di CO2 nell'atmosfera");
plot(t,y,'-o','LineWidth',1,'MarkerFaceColor','r')
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
stem(f,pow,'fill','LineStyle','-.','LineWidth',1,'MarkerFaceColor','red','MarkerEdgeColor',[0.5 1 0]);
xlabel('cicli/mesi');
ylabel('Potenza');

sorted_pow = sort(pow,'descend');
maxpow = sorted_pow(1); %calcolo della massima potenza
maxpow2 = sorted_pow(2); %calcolo della seconda potenza maggiore
f(pow == maxpow) %frequenza alla quale la potenza è massima
f(pow == maxpow2) %frequenza corrispondente alla seconda potenza maggiore

%si visualizza la potenza in funzione del periodo
figure('Name','Periodogramma');
p = 1./f;
stem(p,pow,'fill','LineStyle','-.','LineWidth',1,'MarkerFaceColor','red','MarkerEdgeColor',[0.5 1 0]);
xlabel('periodo(mesi/ciclo)');
ylabel('Potenza');

maxper = p(pow == maxpow); %periodo in cui il fenomeno raggiunge la massima potenza:
maxper2 = p(pow == maxpow2); %periodo in cui il fenomeno raggiunge la seconda potenza maggiore

