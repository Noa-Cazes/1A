clear all;
close all;
clc;
%% Constantes globales
alpha = 0.5;
fp = 2000; 
Fe = 10000;
Te = 1/Fe;
nb_bits = 18000;

%% QPSK = 4-PSK
% Constantes
n = 2; % nombre de bits par symbole
M = 2^n;
Rb = 48*10^3;
Rs = Rb/log2(M); 
Ts = 1/Rs;
Ns = floor(Ts/Te);
t0 = 1;
nb_bits = 10000; 

% Générer l'information binaire
bits = randi([0,1], 1, nb_bits);

% Mapping 
a = 2*bits(1:2:end)-1;
b = 2*bits(2:2:end)-1;
symbole_complexe = a + j*b;

% Suite de diracs
suite_de_dirac = kron(symbole_complexe, [1, zeros(1, Ns-1)]);

% Signal en sortie du filtre de mise en forme
h = rcosdesign(alpha, 4*n, 10, 'normal');
retard = 40;
suite_de_dirac_r = cat(2,suite_de_dirac, zeros(1,retard));
x_e = filter(h, 1, suite_de_dirac_r); 
x_e = x_e(retard +1 : end);

% Passage dans le filtre de réception
x_f = filter(h, 1, [x_e zeros(1, retard)]);
x_f = x_f(retard + 1 : end);

% Echantillonnage
x_f_ech = x_f(1:1:end);

% Prise de décisison
bits_decides = zeros(1,length(bits));
bits_decides(1:2:end) = (sign(real(x_f_ech)) + 1) / 2;
bits_decides(2:2:end) = (sign(imag(x_f_ech)) + 1) / 2;

% Calcul TEB
TEB_QPSK = length(find(bits_decides ~= bits))/length(bits) % le TEB est bien nul

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
    x_f_ech = x_f(t0:1:end);

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
   
% Constellations en sortie du mapping et en sortie de l'échantillonneur pour une valeur donnée de Eb/N0
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

% Comparaison TEB chaîne sur fréquence porteuse et chaîne passe-bas équivalente
TEB_ref = qfunc(sqrt(2*Eb_N0));

figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB , TEB_ref);
legend('TEB simulé (chaîne passe-bas équivalente)', 'TEB théorique (chaîne sur fréquence porteuse)');
title("Comparaison TEB chaîne sur fréquence porteuse et chaîne passe-bas équivalente");
xlabel("Eb/N0 en dB");
ylabel("TEB");



%% 8 - PSK
% Constantes
n = 3; % nombre de bits par symbole
M = 2^n;
Rs = Rb/log2(M); 
Ts = 1/Rs;
Ns = floor(Ts/Te);
t0 = 1;

% Générer l'information binaire
bits = randi([0,1], 1, nb_bits);
bits = reshape(bits, [3, nb_bits/3]); % Comme un symbole correspond à trois bits,  on a une colonne corresond à un symbolebits = reshape(bits, [3, length(bits)/3]); % Comme un symbole correspond à trois bits,  on a une colonne corresond à un symbole
bits = bi2de(bits.'); % on convertit chaque symbole codé par 3 bits par un entier

% Mapping 
symbole_complexe = pskmod(bits, M, pi/M, 'gray');


% Suite de diracs
suite_de_dirac = kron(symbole_complexe, [1 zeros(1, Ns-1)]);

% Signal en sortie du filtre de mise en forme
h = rcosdesign(alpha, 8, 10, 'normal');
retard = 40;
suite_de_dirac_r = cat(2,suite_de_dirac, zeros(1,retard));
x_e = filter(h, 1, suite_de_dirac_r);  
x_e = x_e(retard +1 : end);

% Passage dans le filtre de réception
x_f = filter(h, 1, [x_e zeros(1, retard)]);
x_f = x_f(retard + 1 : end);

% Echantillonnage
x_f_ech = x_f(1:Ns:end);

% Démapping
bits_decides = pskdemod(x_f_ech, M); 

% Calcul TEB
TEB = length(find(bits_decides ~= bits))/length(bits) % le TEB est bien nul

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
   
% Constellations en sortie du mapping et en sortie de l'échantillonneur pour une valeur donnée de Eb/N0
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

%% 4 - ASK
% Constantes
n = 2; % nombre de bits par symbole
M = 2^n;
Rs = Rb/log2(M); 
Ts = 1/Rs;
Ns = floor(Ts/Te) + 1;
t0 = Ns;

% Générer l'information binaire
bits = randi([0,1], 1, nb_bits);

% Mapping 
symboles = 2*bits - 1; 

% Suite de diracs
suite_de_dirac = kron(symbole, [1, zeros(1, Ns-1)]);
suite_de_dirac = cat(2, suite_de_diracs, zeros(1, retard)); 

% Signal en sortie du filtre de mise en forme
h = rcosdesign(alpha, 4*n, Ns, 'normal');
retard = 4 * Ns;
x_e = filter(h, 1, [suite_de_dirac zeros(1, retard) ]); 
x_e = x_e(retard +1 : end);

% Passage dans le filtre de réception
x_f = filter(h, 1, [x_e zeros(1, retard)]);
x_f = x_f(retard + 1 : end);

% Echantillonnage
x_f_ech = x_f(t0:Ns:end);

% Démapping
symboles_decides = sign(x_f_ech);
bits_decides = (symboles_decides + 1) / 2;

% Calcul TEB
TEB_4_ASK = length(find(bits_decides ~= bits))/length(bits) % le TEB est bien nul