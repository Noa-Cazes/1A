clear all;
close all;
clc;

%% Constantes
Ns = 4;
Ts = 4;
Te = 1;
nb_bits = 10000;

%% Implantation de la chaîne sans bruit
% Signal généré et tronqué
bits = randi([0,1], 1, nb_bits);
symboles = 2*bits - 1; %pour avoir des 1 et des -1 au lieu des 1 et des 0
Ns = 4; % car on veut Ts = Ns * Te = 
suite_de_dirac = kron(symboles, [1, zeros(1, Ns-1)]);
h = ones(1, Ns);

% Signal en sortie du filtre de mise en forme
x = filter(h, 1, suite_de_dirac);

% Signal en sortie du filtre de reception
%h_r = ones(1, Ns/2);
h_r = ones(1, Ts/2);
x_r = filter(h_r, 1, x);

figure;
plot(x_r);
axis([1 length(bits) -4.5 4.5]);
title("Signal en sortie du filtre de reception");
xlabel("temps en secondes");
ylabel("Signal en sortie du filtre de reception");

% Diagramme de l'oeil
Ts = Ns * Te;
oeil = reshape(x_r, Ts, length(x_r)/Ts); %  length(x)/Ns = nombre de colonnes de Ns valeurs
figure;
plot(oeil); % superpose les différentes colonnes
axis([1 Ts (-Ns-1) (Ns+1)]);
title("Diagramme de l'oeil en sortie du filtre de reception");
xlabel("Temps en secondes");
ylabel("Diagramme de l'oeil");

% Calcul TEB
signal_echantillonne = x_r(Ns:Ns:end); % commence à Ns, pas de Ns jusqu'à la fin
symboles_decides = sign(signal_echantillonne);
bits_decides = (symboles_decides + 1) / 2;
TEB = length(find(bits_decides ~= bits))/length(bits) % la TEB est bien nulle

%% Deuxième question
% Implantation de la chaîne avec bruit

Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));

t0 = Ts; 


for i = 1:length(Eb_N0_dB)
    sigma_n_carre= (Px * Ns/ (2*log2(2)*Eb_N0(1,i)))/2;
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, y);
    signal_echantillonne = x_r(t0:Ts:t0+(nb_bits-1)*Ts);
    
    symboles_decides = sign(signal_echantillonne);
    bits_decides = (symboles_decides + 1) / 2;
    
%     TEB_m(i) = length(find(bits_decides ~= bits))/length(bits);
    TEB_m(i) = mean(bits_decides ~= bits);
end
figure();
loglog(Eb_N0, TEB_m);
title("TEB simulé en fonction de Eb/N0 en dB");
xlabel("Eb/N0 en dB");
ylabel("TEB");

%% Troisème question
% Comparaison entre TEB simulé et TEB théorique
% TEB théorique

Eb_N0_dB = [1:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
TEB_th = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));

t0 = Ts;

for i = 1:length(Eb_N0_dB)
    sigma_n_carre= (Px * Ns/ (2*log2(2)*10^(Eb_N0_dB(1,i)/10)))/2;
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, y);
    signal_echantillonne = x_r(t0:Ts:t0 + (nb_bits-1)*Ts);
    symboles_decides = sign(signal_echantillonne);
    bits_decides = (symboles_decides + 1) / 2;
    TEB_th(1,i) = qfunc(Ts / (2 * sqrt(sigma_n_carre)));
    TEB_m(1, i) = length(find(bits_decides ~= bits))/length(bits);
end
figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB, TEB_th);
legend('TEB simulé', 'TEB théorique');
title("Comparaison entre le TEB simulé et le TEB théorique");
xlabel("Eb/N0 en dB");
ylabel("TEB");

%% Quatrième question
% Comparer la TEB simulé de cette chaîne de transmission, étudiée au TEB
% simulé pour la chaîne de référence

x_ref = filter(h, 1, suite_de_dirac);  % x_ref = x % pour la chaîne de référence
x_r_ref = filter(h, 1, x_ref);         % pour la chaîne de référence

%Eb_N0_dB = zeros(1, length(x_r));
Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);

TEB_m = zeros(1, length(Eb_N0_dB));     % pour cette chaîne étudiée
TEB_ref = zeros(1, length(Eb_N0_dB));   % pour la chaîne de référence

Px_ref = mean(abs(x_ref.*x_ref));
Px = mean(abs(x.*x));

t0 = Ts;
for i = 1:length(Eb_N0_dB)
    sigma_n_carre_ref= Px_ref * Ns/ (2*log2(2)*10^(Eb_N0_dB(1,i)/10));       % pour la chaîne de référence
    sigma_n_carre= (Px * Ns/ (2*log2(2)*10^(Eb_N0_dB(1,i)/10)))/2;           % pour cette chaîne étudiée % sigma_n_carre_ref = sigma_n_carre
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    bruit_ref = sqrt(sigma_n_carre_ref) .* randn(1, length(x_ref));
    y = x + bruit;
    y_ref = x_ref + bruit_ref;
    x_r = filter(h_r, 1, y);
    x_r_ref = filter(h, 1, y_ref);
    signal_echantillonne = x_r(t0:Ts:t0 + (nb_bits -1)*Ts);
    signal_echantillonne_ref = x_r_ref(t0:Ts:t0 + (nb_bits -1)*Ts);
    symboles_decides = sign(signal_echantillonne);
    bits_decides = (symboles_decides + 1) / 2;
    symboles_decides_ref= sign(signal_echantillonne_ref);
    bits_decides_ref = (symboles_decides_ref + 1) / 2;
    TEB_m(1, i) = length(find(bits_decides ~= bits))/length(bits);
    TEB_th(1,i) = qfunc(Ts / (sqrt(sigma_n_carre_ref)));
    TEB_ref(1, i) = length(find(bits_decides_ref ~= bits))/length(bits);
end
figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB, TEB_ref);
legend('TEB simulé de cette chaîne', 'TEB simulé de la chaîne de référence');
title("Comparaison entre le TEB simulé de cette chaîne et de la chaîne de référence");
xlabel("Eb/N0 en dB");
ylabel("TEB simulé");
legend("TEB simulé de cette chaîne", "TEB simulé de la chaîne de référence");

%% Cinquième question
% Comparaison de l'efficacité spectrale de la chaîne étudiée et de celle de
% référence.
% Tracé des DSPs des signaux transmis dans les deux cas pour un même débit
% binaire.


dsp = (1/length(x_r)).*abs(fft(x_r).*fft(x_r));
dsp_ref = (1/length(x_r_ref)).*abs(fft(x_r_ref).*fft(x_r_ref));
figure();
plot(linspace(0,1/Te, length(dsp)), dsp);
hold on;
plot(linspace(0,1/Te, length(dsp_ref)), dsp_ref);
title("DSPs des signaux transmis (chaîne étudiée et celle de référence)");
xlabel("Fréquence en Hertz");
ylabel("DSP");
legend("DSP de cette chaîne", "DSP de la chaîne de référence");
