clear all;
close all;
clc;

%% Paramètres
% Paramètres imposés
Fe = 12000;
Rs = 3000;
alpha = 0.5;
nb_bits = 1000;
Ns = Fe/Rs; % Ns = Fe/Rs Nombre de symboles
n = 2; % Nombre de bits par symboles


%% Implantation de la chaîne sans bruit
% Génération de l'information binaire à transmettre
bits = randi([0,1], 1, nb_bits);

% Mapping binaire à moyenne nulle
symboles = 2*bits - 1; %pour avoir des 1 et des -1 au lieu des 1 et des 0
suite_de_dirac = kron(symboles, [1, zeros(1, Ns-1)]);


% Signal en sortie du filtre de mise en forme
h = rcosdesign(alpha, 4*n, Ns, 'sqrt');
retard = 4 * Ns;
x = filter(h, 1, [suite_de_dirac zeros(1, retard) ]); 
x = x(retard +1 : end);

% Signal en sortie du filtre de réception
x_r = filter(h, 1, [x zeros(1, retard)]);
x_r = x_r(retard + 1 : end);

% Tracé du Signal en sortie du filtre de réception
figure;
plot(x_r);
axis([1 length(x_r) -4.5 4.5]);
title("Signal en sortie du filtre de réception");
xlabel("temps en secondes");
ylabel("Signal en sortie du filtre de réception");

% Diagramme de l'oeil
Ts = 4;
oeil = reshape(x_r, 2*Ts, length(x_r)/(2*Ts)); %  [] = nombre de colonnes de 2*Ts valeurs
figure;
plot(oeil); % superpose les différentes colonnes
axis([1 2*Ts (-Ns-1) (Ns+1)]);
title("Diagramme de l'oeil en sortie du filtre de réception");
xlabel("fréquences en Hertz");
ylabel("Diagramme de l'oeil");

% Calcul TEB
t0 = 1;

signal_echantillonne = x_r(t0 : Ts : end); 
symboles_decides = sign(signal_echantillonne); % car cas binaire
bits_decides = (symboles_decides + 1) / 2;
TEB = length(find(bits_decides ~= bits))/length(bits) % le TEB est bien nulle

%% Implantation de la chaîne avec bruit 

Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));

t0 = 1; 
M = 2;

for i = 1:length(Eb_N0_dB)
    sigma_n_carre= (Px * Ns/ (2*log2(M)*Eb_N0(1,i)));
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, [y zeros(1, retard)]);
    x_r = x_r(retard + 1 : end);
    signal_echantillonne = x_r(t0:Ts:end); 
    symboles_decides = sign(signal_echantillonne); % car cas binaire
    bits_decides = (symboles_decides + 1) / 2;
    
    TEB_m(i) = length(find(bits_decides ~= bits))/length(bits);
end
figure();
semilogy(Eb_N0_dB, TEB_m);
title("TEB simulé en fonction de Eb/N0 en dB");
xlabel("Eb/N0 en dB");
ylabel("TEB");

%% Comparaison du TEB simulé au TEB théorique de la chaîne étudiée

Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
TEB_th = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));

t0 = 1;
M = 2;

for i = 1:length(Eb_N0_dB)
    sigma_n_carre= (Px * Ns/ (2*log2(M)*10^(Eb_N0_dB(1,i)/10)));
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, [y zeros(1, retard)]);
    x_r = x_r(retard + 1 : end);
    signal_echantillonne = x_r(t0:Ts:end); 
    symboles_decides = sign(signal_echantillonne); % car cas binaire
    bits_decides = (symboles_decides + 1) / 2;
    TEB_th(1,i) = qfunc(sqrt(2*Eb_N0(1,i)));
    TEB_m(i) = mean(bits_decides ~= bits);
end
figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB, TEB_th);
legend('TEB simulé', 'TEB théorique');
title("Comparaison entre le TEB simulé et le TEB théorique");
xlabel("Eb/N0 en dB");
ylabel("TEB");

%% Comparaison du TEB simulé de cette chaîne et du TEB simulé de la chaîne de référence
h_ref = ones(1, Ts);
x_ref = filter(h_ref, 1, suite_de_dirac);  % x_ref = x % pour la chaîne de référence
x_r_ref = filter(h_ref, 1, x_ref);         % pour la chaîne de référence


Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);

TEB_m = zeros(1, length(Eb_N0_dB));     % pour cette chaîne étudiée
TEB_ref = zeros(1, length(Eb_N0_dB));   % pour la chaîne de référence

Px_ref = mean(abs(x_ref.*x_ref));
Px = mean(abs(x.*x));

t0 = 1;
M = 2;

for i = 1:length(Eb_N0_dB)
    sigma_n_carre_ref= Px_ref * Ns/ (2*log2(M)*Eb_N0(1,i));       % pour la chaîne de référence
    sigma_n_carre= (Px * Ns/ (2*log2(2)*Eb_N0(1,i)));           % pour cette chaîne étudiée % sigma_n_carre_ref = sigma_n_carre
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    bruit_ref = sqrt(sigma_n_carre_ref) .* randn(1, length(x_ref));
    y = x + bruit;
    y_ref = x_ref + bruit_ref;
    x_r = filter(h, 1, [y zeros(1, retard)]);
    x_r = x_r(retard + 1 : end);
    x_r_ref = filter(h_ref, 1, y_ref);
    signal_echantillonne = x_r(t0:Ts:end);
    signal_echantillonne_ref = x_r_ref(t0:Ts:t0 + (nb_bits -1)*Ts);
    symboles_decides = sign(signal_echantillonne);
    bits_decides = (symboles_decides + 1) / 2;
    symboles_decides_ref= sign(signal_echantillonne_ref);
    bits_decides_ref = (symboles_decides_ref + 1) / 2;
    TEB_m(i) = mean(bits_decides ~= bits);
    %TEB_ref(1, i) = length(find(bits_decides_ref ~= bits))/length(bits);
    TEB_ref(1,i) = qfunc(sqrt(2 * Eb_N0(1,i)));
end
figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB, TEB_ref);
legend('TEB simulé de cette chaîne', 'TEB simulé de la chaîne de référence');
title("Comparaison entre le TEB simulé de cette chaîne et de la chaîne de référence");
xlabel("Eb/N0 en dB");
ylabel("TEB");
legend("TEB simulé de cette chaîne", "TEB simulé de la chaîne de référence");

%% Comparaison de l'efficacité spectrale de cette chaîne et de la chaîne de référence
retard = Ts;
signal_echantillonne = x_r(t0:Ts:t0+(nb_bits-1)*Ts); 
x_r_sans_retard = signal_echantillonne(retard-1:end);

x_ref = filter(h, 1, suite_de_dirac);  % x_ref = x % pour la chaîne de référence
h_ref = ones(1, Ts);
x_r_ref = filter(h_ref, 1, x_ref); 

dsp = (1/length(x_r_sans_retard)).*abs(fft(x_r_sans_retard).*fft(x_r_sans_retard));
dsp_ref = (1/length(x_r_ref)).*abs(fft(x_r_ref).*fft(x_r_ref));
figure();
plot(linspace(0, Fe, length(dsp)), dsp);
hold on;
plot(linspace(0, Fe, length(dsp_ref)), dsp_ref);
%title("Tracé des DSPs des signaux transmis dans les deux cas pour un même débitbinaire");
xlabel("Fréquence en Hertz");
ylabel("DSP");
%legend("DSP de cette chaîne", "DSP de la chaîne de référence");

%% Reprise de la chaîne sans bruit et introduction d'un passage dans le canal de transmission
% BW = 1500 Hz
Fc = 1500;
Te = 1/Fe;
h_canal = 2 * Fc * Te * sinc(2 * Fc * [-50*Te : Te : 50*Te])';
x_canal = filter(h_canal, 1, x);
x_r = filter(h, 1, x_canal);

Ts = 4;
oeil = reshape(x_r, 2*Ts, length(x_r)/(2*Ts)); %  [] = nombre de colonnes de 2*Ts valeurs
figure;
plot(oeil); % superpose les différentes colonnes
axis([1 2*Ts (-Ns-1) (Ns+1)]);
title("Diagramme de l'oeil en sortie du filtre de réception avec passage dans un canal de transmission (BW = 1500 Hz)");
xlabel("fréquences en Hertz");
ylabel("Diagramme de l'oeil");

% BW = 3000 Hz
Fc = 3000;
Te = 1/Fe;
h_canal = 2 * Fc * Te * sinc(2 * Fc * [-50*Te : Te : 50*Te])';
x_canal = filter(h_canal, 1, x);
x_r = filter(h, 1, x_canal);

Ts = 4;
oeil = reshape(x_r, 2*Ts, length(x_r)/(2*Ts)); %  [] = nombre de colonnes de 2*Ts valeurs
figure;
plot(oeil); % superpose les différentes colonnes
axis([1 2*Ts (-Ns-1) (Ns+1)]);
title("Diagramme de l'oeil en sortie du filtre de réception avec passage dans un canal de transmission (BW = 1500 Hz)");
xlabel("fréquences en Hertz");
ylabel("Diagramme de l'oeil");

