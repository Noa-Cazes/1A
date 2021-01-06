clear all;
close all;
clc;

%% Constantes
alpha = 0.35;
fp = 2000; 
Fe = 10000;
Rs = 1000;
Ts = 1/Rs;
Te = 1/Fe;
Ns = floor(Ts/Te);
nb_bits = 1000; 
n = 2; % nombre de bits par symbole
t0 = 1;
M = 4;

%% Tracer les signaux en phase et en quadrature de phase
% Générer l'information binaire
bits = randi([0,1], 1, nb_bits);

% Mapping 
a = 2*bits(1:2:end)-1;
b = 2*bits(2:2:end)-1;
symbole_complexe = a + j*b;

figure();
plot(a);
axis([0 length(a) -1.5 1.5]);
ylabel("a_k");
title("Signal généré sur la voie en phase");

figure();
plot(b);
title("Signal généré sur la voie en quadrature");
axis([0 length(b) -1.5 1.5]);
ylabel("b_k");

% Suite de diracs
suite_de_dirac = kron(symbole_complexe, [1 zeros(1, Ns-1)]);

% Signal en sortie du filtre de mise en forme
h = rcosdesign(alpha, 4*n, Ns, 'normal');
retard = 4 * Ns;
suite_de_dirac_r = cat(2,suite_de_dirac, zeros(1,retard));
x_e = filter(h, 1, suite_de_dirac_r); 
x_e = x_e(retard +1 : end);


%% Densité spectrale de puissance de l'enveloppe complexe associciée au signal modulé sur fréquence porteuse

dsp = (1/length(x_e)).*abs(fft(x_e).*fft(x_e));
figure();
plot(linspace(0,Fe,length(dsp)), dsp);
title("Périodogramme du signal modulé sur fréquence porteuse");
xlabel("fréquence en Hertz");
ylabel("Périodogramme");


%% Implantation de la chaîne complète sans bruit

% Passage dans le filtre de réception
x_f = filter(h, 1, [x_e zeros(1, retard)]);
x_f = x_f(retard + 1 : end);

% Echantillonnage
x_f_ech = x_f(t0:Ns:end);

% Prise de décisison
bits_decides = zeros(1,length(bits));
bits_decides(1:2:end) = (sign(real(x_f_ech)) + 1) / 2;
bits_decides(2:2:end) = (sign(imag(x_f_ech)) + 1) / 2;

% Calcul TEB
TEB = length(find(bits_decides ~= bits))/length(bits) % le TEB est bien nul

%% Implantation de la chaîne avec bruit

Eb_N0_dB = [0:0.5:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
TEB_th = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x_e).^2);


for i = 1:length(Eb_N0_dB)
    sigma_n_carre_reel = Px * Ns/ (2*log2(M)*Eb_N0(1,i)); % même que sigma_n_carre_im
    bruit_reel = sqrt(sigma_n_carre_reel) .* randn(1, length(x_e));
    bruit = bruit_reel + j*bruit_reel;
    x_c = x_e + bruit;
    
    % Passage dans le filtre de réception
    x_f = filter(h, 1, [x_c zeros(1, retard)]);
    x_f = x_f(retard + 1 : end);

    % Echantillonnage
    x_f_ech = x_f(t0:Ns:end);

    % Prise de décisison
    bits_decides = zeros(1,length(bits));
    bits_decides(1:2:end) = (sign(real(x_f_ech)) + 1) / 2;
    bits_decides(2:2:end) = (sign(imag(x_f_ech)) + 1) / 2;

    % Calcul TEB
    TEB_m(1,i) = length(find(bits_decides ~= bits))/length(bits);
    
end
figure();
semilogy(Eb_N0_dB, TEB_m);
title("TEB simulé");
xlabel("Eb/N0 en dB");
ylabel("TEB");
   
%% Constellations en sortie du mapping et en sortie de l'échantillonneur pour une valeur donnée de Eb/N0
% En sortie du mapping
figure();
plot(a, b, "r*");
axis([-1.5 1.5 -1.5 1.5]);
xlabel("a_k");
ylabel("b_k");
title("Constellations en sortie du mapping");

% En sortie de l'échantillonneur
figure();
plot(real(x_f_ech), imag(x_f_ech), "r*");
axis([-1.5 1.5 -1.5 1.5]);
xlabel("a_k");
ylabel("b_k");
title("Constellations en sortie de l'échantillonneur");

%% Comparaison TEB chaîne sur fréquence porteuse et chaîne passe-bas équivalente
TEB_ref = qfunc(sqrt(2*Eb_N0));

figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB , TEB_ref);
legend('TEB simulé (chaîne passe-bas équivalente)', 'TEB théorique (chaîne sur fréquence porteuse)');
title("Comparaison TEB chaîne sur fréquence porteuse et chaîne passe-bas équivalente");
xlabel("Eb/N0 en dB");
ylabel("TEB");

