clear;
close all;
clc;

%% Paramètres
n = 2;
M = 4;
nb_bits = 10000;
Te = 1;
Ns = 4;
Ts = 4;

%% Chaîne sans bruit
% Génération de l'information binaire à transmettre
bits = randi([0,1], 1, nb_bits);

% Mapping 4-aire "naturel" 
symboles = (2*bi2de(reshape(bits, 2, length(bits)/2).')-3).';
suite_de_dirac = kron(symboles, [1 zeros(1, Ns-1)]);

% Filtre de mise en forme et filtre de réception
h = ones(1, Ts);

% Signal filtré et tracé
x = filter(h, 1, suite_de_dirac);

figure();
plot(x);
axis([0 length(x) -4.5 4.5]);
title("Signal filtré (filtre de mise en forme)");
xlabel("temps en secondes");
ylabel("Signal à transmettre");

% Densité spectrale de puissance de la chaîne étudiée
%dsp = (1/length(x)).*abs(fft(x).*fft(x));
dsp = (1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;

figure();
plot(linspace(0,1/Te, length(dsp)), dsp);
title("Périodogramme du signal filtré (filtre de mise en forme)");
xlabel("fréquence en Hertz");
ylabel("Périodogramme");

% Comparaison des DSPs de la chaîne étudiée et de la chaîne de référence
symboles_ref = 2*bits - 1; % mapping binaire
suite_de_dirac_ref = kron(symboles_ref, [1, zeros(1, Ns-1)]);
x_ref = filter(h, 1, suite_de_dirac_ref);
dsp_ref = (1/length(x_ref))*abs(fft(x_ref,2^nextpow2(length(x_ref)))).^2;

figure();
plot(linspace(0,1/Te, length(dsp)), dsp);
hold on;
plot(linspace(0,1/Te, length(dsp_ref)), dsp_ref);
title("Périodogramme du signal la chaîne étuidiée et de la chaîne de référence en sortie du filtre d'émission");
xlabel("fréquence en Hertz");
ylabel("Périodogrammes");
legend("Chaîne étudiée", "Chaîne de référence");

% Signal en sortie du filtre de reception
x_r = filter(h, 1, x);

% Diagramme de l'oeil
oeil = reshape(x_r, Ns, length(x_r)/Ns); %  length(x)/Ns = nombre de colonnes de Ns valeurs

figure();
plot(oeil); % superpose les différentes colonnes
axis([1 Ts -12 12]);
title("Diagramme de l'oeil en sortie du filtre de réception");
xlabel("Temps en secondes");
ylabel("Diagramme de l'oeil");

% Calcul du TEB
t0 = Ts;
%signal_echantillonne = x_r(t0:Ts:end); 
signal_echantillonne = x_r(Ns:Ns:end); 
for i = 1:length(signal_echantillonne)
    if signal_echantillonne(1,i) > 2*Ts
        symboles_decides(1,i) = 3;
    
    elseif signal_echantillonne(1,i) >= 0
        symboles_decides(1,i) = 1;
    
    elseif signal_echantillonne(1,i) < -2*Ts
        symboles_decides(1,i) = -3;
    
    else
        symboles_decides(1,i) = -1;
    end
end 
bits_decides = reshape(de2bi((symboles_decides + 3)/2).', 1, length(bits)); 
TEB = length(find(bits_decides ~= bits))/length(bits) % la TEB est bien nulle


%% Implantation de la chaîne avec bruit
% Tracé du TES  et du TEB de la chaîne
Eb_N0_dB = [0:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
TES_m = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));

t0 = Ts;
for i = 1:length(Eb_N0_dB)
    sigma_n_carre= (Px * Ns/ (2*log2(M)*Eb_N0(1,i)));
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, y);
    signal_echantillonne = x_r(t0:Ts:end); 
    symboles_decides = zeros(1, length(signal_echantillonne));
   for j = 1:length(signal_echantillonne)
    if signal_echantillonne(1,j) > 2*Ts
        symboles_decides(1,j) = 3;
    
    elseif signal_echantillonne(1,j) >= 0
        symboles_decides(1,j) = 1;
    
    elseif signal_echantillonne(1,j) < -2*Ts
        symboles_decides(1,j) = -3;
    
    else
        symboles_decides(1,j) = -1;
    end
end 
    
    bits_decides = reshape(de2bi((symboles_decides + 3)/2).', 1, length(bits)); 
    
    TES_m(1,i) = length(find(symboles_decides ~= symboles))/length(symboles);
    TEB_m(1,i) = length(find(bits_decides ~= bits))/length(bits);
end

figure();
semilogy(Eb_N0_dB, TES_m);
title("TES simulé en fonction de Eb/N0 en dB");
xlabel("Eb/N0 en dB");
ylabel("TES");

figure();
semilogy(Eb_N0_dB, TEB_m);
title("TEB simulé en fonction de Eb/N0 en dB");
xlabel("Eb/N0 en dB");
ylabel("TEB");



% Comparaison de ce TES et du TES théorique

Eb_N0_dB = [0:6];
Eb_N0 = 10.^(Eb_N0_dB/10);
TEB_m = zeros(1, length(Eb_N0_dB));
TES_m = zeros(1, length(Eb_N0_dB));
TES_th = zeros(1, length(Eb_N0_dB));
TEB_th = zeros(1, length(Eb_N0_dB));
Px = mean(abs(x.*x));

t0 = Ts;
for i = 1:length(Eb_N0_dB)
    sigma_n_carre= (Px * Ns/ (2*log2(M)*Eb_N0(1,i)));
    bruit = sqrt(sigma_n_carre) .* randn(1, length(x));
    y = x + bruit;
    x_r = filter(h, 1, y);
    signal_echantillonne = x_r(Ns:Ns:end); 
    symboles_decides = zeros(1, length(signal_echantillonne));
    for j = 1:length(signal_echantillonne)
    if signal_echantillonne(1,j) > 2*Ts
        symboles_decides(1,j) = 3;
    
    elseif signal_echantillonne(1,j) >= 0
        symboles_decides(1,j) = 1;
    
    elseif signal_echantillonne(1,j) < -2*Ts
        symboles_decides(1,j) = -3;
    
    else
        symboles_decides(1,j) = -1;
    end
    end
    
    bits_decides = reshape(de2bi((symboles_decides + 3)/2).', 1, length(bits)); 
    
    TEB_m(1,i) = mean(bits_decides ~= bits);
    TES_m(1,i) = TEB_m(1,i) * log2(M);
    TES_th(1,i) = (3/2) * qfunc(sqrt((4/5)*Eb_N0(1,i)));
    TEB_th(1,i) = (3/4) * qfunc(sqrt((4/5)*Eb_N0(1,i)));
end

figure();
semilogy(Eb_N0_dB, TES_m);
hold on;
semilogy(Eb_N0_dB, TES_th);
title("TES simulé et TES théorique en fonction de Eb/N0 en dB");
xlabel("Eb/N0 en dB");
ylabel("TES");
legend("TES simulé", "TES théorique");

figure();
semilogy(Eb_N0_dB, TEB_m);
hold on;
semilogy(Eb_N0_dB, TEB_th);
title("TEB simulé et TEB théorique en fonction de Eb/N0 en dB");
xlabel("Eb/N0 en dB");
ylabel("TEB");
legend("TEB simulé", "TEB théorique");

