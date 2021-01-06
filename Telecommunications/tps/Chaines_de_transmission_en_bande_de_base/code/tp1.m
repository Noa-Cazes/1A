clear all;
close all;
clc;

%% Implantation de la chaîne sans bruit
% Générer la suite de bits/ symboles
nb_bits = 1000;
bits = randi([0,1], 1, nb_bits);
symboles = 2*bits - 1; %pour avoir des 1 et des -1 au lieu des 1 et des 0
Ns = 4; % car on veut Ts = Ns * Te = 4
suite_de_dirac = kron(symboles, [1, zeros(1, Ns-1)]);

% Filtre de mise en forme
h = ones(1, Ns);

% Signal filtré et tracé
x = filter(h, 1, suite_de_dirac);
%x = conv(h, suite_de_dirac, 'same');
figure();
plot(x);
axis([0 length(x) -4.5 4.5]);
title("Signal filtré (filtre de mise en forme)");
xlabel("temps en secondes");
ylabel("Signal à transmettre");

hr = fliplr(h); % "inverse" le signal
z = filter(hr, 1, x);
figure();
plot(z);
title("Signal filtré (filtre de mise en forme inversé)");
xlabel("temps en secondes");
ylabel("Signal à transmettre");
axis([0 length(x) -4.5 4.5]); %axis([minx maxx miny maxy]

% Densité spectrale de puissance
dsp = (1/length(x)).*abs(fft(x).*fft(x));
Te = 1;
figure();
plot(linspace(0,1/Te, length(dsp)), dsp);
title("Périodogramme du signal filtré (filtre de mise en forme)");
xlabel("fréquence en Hertz");
ylabel("Périodogramme");

%% Deuxième question
% Signal en sortie du filtre de reception
x_r = filter(h, 1, x);
%x_r = conv(h, x, 'same');
figure;
plot(x_r);
axis([1 length(bits) -4.5 4.5]);
title("Signal en sortie du filtre de reception");
xlabel("temps en secondes");
ylabel("Signal en sortie du filtre de reception");

% Diagramme de l'oeil
Ts = Ns * Te;
oeil = reshape(x_r, Ns, length(x_r)/Ns); %  length(x)/Ns = nombre de colonnes de Ns valeurs
figure;
plot(oeil); % superpose les différentes colonnes
axis([1 Ts (-Ns-1) (Ns+1)]);
title("Diagramme de l'oeil en sortie du filtre de reception");
xlabel("Temps en secondes");
ylabel("Diagramme de l'oeil");

%% Calcul du TEB
% Calcul TES
signal_echantillonne = x_r(Ns:Ns:end); % commnce à t0 = Ts = Ns, pas de Ns (t0 + l*Ts = t0 + l*Ns)jusqu'à la fin
symboles_decides = sign(signal_echantillonne); % seuil à 0
TES = length(find(symboles_decides ~= symboles))/length(symboles); % cherche les symboles pour lesquels la décision est différente du vrai symbole/ nbre de bits 
% % Avec un autre échantillonnage
% signal_echantillonne = x_r(Ns/2:Ns:end);
% symboles_decides = sign(signal_echantillonne);  
% TES = length(find(symboles_decides ~= symboles))/length(symboles);

% TES
Eb_N0_dB = 0;
Px = mean(abs(x.*x));
sigma_n_carre= Px * Ns/ (2*log2(2)*10^((Eb_N0_dB)/10));
bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
y = x + bruit;
signal_echantillonne = x_r(Ns:Ns:end);
symboles_decides = sign(signal_echantillonne);
TES = length(find(symboles_decides ~= symboles))/length(symboles);

% TEB
bits_decides = (symboles_decides + 1) / 2;
TEB = length(find(bits_decides ~= bits))/length(bits) % le TEB est bien nul

Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
TEB_th = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));
%Px = mean(abs(x).^2);

t0 = Ts;

M = 2;

for i = 1:length(Eb_N0_dB)
    sigma_n_carre= Px * Ns/ (2*log2(M)*Eb_N0(1,i));
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, y);
    signal_echantillonne = x_r(t0:Ts:end);
    symboles_decides = sign(signal_echantillonne);
    bits_decides = (symboles_decides + 1) / 2;
    TEB_th(1,i) = qfunc(sqrt(2 * Eb_N0(1,i)));
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