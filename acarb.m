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
%Y1 = Y;
%Y1(1) = [];
f = (2:floor(N/2))*Fs/N; %segnale reale, per simmetria si opera con le frequenze da 1 a N/2
%pow = (2*abs(Y1(1:floor(N/2))/N)).^2;
pow = (2*abs(Y(2:floor(N/2))/N)).^2;

%Periodogramma
figure('Name','Periodogramma');
stem(f,pow,'fill','LineStyle','-.','LineWidth',1,'MarkerFaceColor','red','MarkerEdgeColor',[0.5 1 0]);
xlabel('cicli/mesi');
ylabel('Potenza');

sorted_pow = sort(pow,'descend');
maxpow = sorted_pow(1); %calcolo della massima potenza
maxpow2 = sorted_pow(2); %calcolo della seconda potenza maggiore
maxpow3 = sorted_pow(3); %calcolo della terza potenza maggiore
maxpow4 = sorted_pow(4); %calcolo della quarta potenza maggiore
f(pow == maxpow) %frequenza alla quale la potenza è massima
f(pow == maxpow2) %frequenza corrispondente alla seconda potenza maggiore

ind1 = find(Y==Y(pow==maxpow)); %indice corrispondente alla massima potenza
ind2 = find(Y==Y(pow==maxpow2)); %indice corrispondente alla seconda potenza maggiore
ind3 = find(Y==Y(pow==maxpow3)); %indice corrispondente alla terza potenza maggiore
ind4 = find(Y==Y(pow==maxpow4)); %indice corrispondente alla quarta potenza maggiore

%si visualizza la potenza in funzione del periodo
figure('Name','Periodogramma');
p = 1./f;
stem(p,pow,'fill','LineStyle','-.','LineWidth',1,'MarkerFaceColor','red','MarkerEdgeColor',[0.5 1 0]);
xlabel('periodo(mesi/ciclo)');
ylabel('Potenza');

maxper = p(pow == maxpow); %periodo in cui il fenomeno raggiunge la massima potenza:
maxper2 = p(pow == maxpow2); %periodo in cui il fenomeno raggiunge la seconda potenza maggiore

%Ricostruzione segnale mediante DC + 2 componenti maggiori
a = zeros(size(Y));
a(1) = Y(1);
a(ind1) = Y(ind1);
a(ind2) = Y(ind2);
xn = ifft(a);
figure('Name','Ricostruzione segnale I');
plot(t,xn)
xlim([0 216]);
xlabel('Mesi');
ylabel('CO2');

% Ricostruzione segnale mediante DC + 4 componenti maggiori
b = zeros(size(Y));
b(1) = Y(1);
b(ind1) = Y(ind1);
b(ind2) = Y(ind2);
b(ind3) = Y(ind3);
b(ind4) = Y(ind4);
xr = ifft(b);
figure('Name','Ricostruzione segnale II');
plot(t,xr)
xlim([0 216]);
xlabel('Mesi');
ylabel('CO2');
 
 