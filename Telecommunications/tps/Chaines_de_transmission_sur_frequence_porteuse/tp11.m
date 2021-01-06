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
Ns = floor(Ts/Te); % facteur de suréchantillonnage
nb_bits = 10000; 
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

% Transposition sur fréquence
tps = [0:Te:(nb_bits/2)*Ts-Te];
x_t = x_e .* exp(j*2*pi*fp*tps);

% Signal transmis
x = real(x_t);


%% Densité spectrale de puissance du signal modulé sur fréquence porteuse

dsp = (1/length(x)).*abs(fft(x).*fft(x));
%dsp = fftshift(dsp);
figure();
plot(linspace(0,Fe,length(dsp)), dsp);
title("Périodogramme du signal modulé sur fréquence porteuse");
xlabel("fréquence en Hertz");
ylabel("Périodogramme");

%% Implantation de la chaîne complète sans bruit
% Retour en bande de base
N = length(symbole_complexe)*Ns;
passe_bas = 2*(fp/Fe)*sinc(2*[-((N-1)/2)*Te:Te:((N-1)/2)*Te]*(fp));
retard_pb = floor(length(passe_bas)/2);


x_reel = x .* cos(2*pi*fp*tps);
x_reel = filter(passe_bas, 1, [x_reel zeros(1, retard_pb)]);
x_reel = x_reel(retard_pb + 1 : end);

x_im = x .* sin(2*pi*fp*tps);
x_im = filter(passe_bas, 1, [x_im zeros(1, retard_pb)]);
x_im = x_im(retard_pb + 1 : end);

x_recu = x_reel - 1i*x_im;

% Passage dans le filtre de récption
x_f = filter(h, 1, [x_recu zeros(1, retard)]);
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
Px = mean(abs(x.*x));


for i = 1:length(Eb_N0_dB)
    sigma_n_carre= Px * Ns/ (2*log2(M)*Eb_N0(1,i));
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    x_c = x + bruit;
    
    % Retour en bande de base
    N = length(symbole_complexe)*Ns; 
    passe_bas = 2*fp/Fe.*sinc(2*fp*linspace(-Te*Ns,Te*Ns,2*Ns));
    retard_pb = Ns - 1;

    x_reel = x_c .* cos(2*pi*fp*tps);
    x_reel = filter(passe_bas, 1, [x_reel zeros(1, retard_pb)]);
    x_reel = x_reel(retard_pb + 1 : end);

    x_im = x_c .* sin(2*pi*fp*tps);
    x_im = filter(passe_bas, 1, [x_im zeros(1, retard_pb)]);
    x_im = x_im(retard_pb + 1 : end);

    x_recu = x_reel - j.*x_im;

    % Passage dans le filtre de récption
    x_f = filter(h, 1, [x_recu zeros(1, retard)]);
    x_f = x_f(retard + 1 : end);

    % Echantillonnage
    x_f_ech = x_f(t0:Ns:end);

    % Prise de décisison
    bits_decides = zeros(1,length(bits));
    bits_decides(1:2:end) = (sign(real(x_f_ech)) + 1) / 2;
    bits_decides(2:2:end) = (sign(imag(x_f_ech)) + 1) / 2;

    % Calcul TEB
    TEB_m(i) = (length(find(bits_decides ~= bits))/length(bits));
    TEB_th(1,i) = qfunc(sqrt(2*Eb_N0(1,i)));
    
end
figure();
semilogy(Eb_N0_dB, TEB_m);
title("TEB simulé");
xlabel("Eb/N0 en dB");
ylabel("TEB");

figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB, TEB_th);
legend('TEB simulé', 'TEB théorique');
title("Comparaison entre le TEB simulé et le TEB théorique");
xlabel("Eb/N0 en dB");
ylabel("TEB");
   


