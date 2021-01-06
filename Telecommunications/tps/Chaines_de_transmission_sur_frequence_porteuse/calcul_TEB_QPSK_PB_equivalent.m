function [mat_TEB, diag_oeil, Puissance, DSP, I, Q, x, symboles, zm] = calcul_TEB_QPSK_PB_equivalent(mat_SNR);
    mat_TEB = mat_SNR;
    taille = length(mat_SNR);

    %% Constantes
    
    % Fréquence porteuse
    fp = 2000;
    % Fréquence d'échantillonnage
    Fe = 10000;
    Te = 1/Fe;
    % Débit symbole
    Rs = 1000;
    Ts = 1/Rs;
    % Ordre de modulation
    M = 4;
    % Facteur de suréchantillonnage
    Ns = floor(Ts/Te);
    % Nombre de bits générés
    nb_bits = 10000;
    % Génération des bits
    bits = randi([0,1], 1, nb_bits);
    
    %% Chaine de transmistion sur porteuse
    
    % Mapping
    I = 2*bits(1:2:end)-1;
    Q = 2*bits(2:2:end)-1;
    symboles = complex(I,Q);
    
    % Génération de la suite de Diracs pondérés
    Suite_diracs = kron(symboles, [1 zeros(1,Ns - 1)]);
    
    % Réponse impulsionnelle du filtre de mise en forme (NRZ)
    h = rcosdesign(0.35,8,Ns,'normal');
    
    %Génération du message complexe
    retard = 4*Ns;
    Suite_dirac2 = cat(2,Suite_diracs, zeros(1,retard));
    xe = filter(h,1,Suite_dirac2);
    x = xe(retard +1 : end);
    
    for k = 1:taille
        % Ajout de bruit blanc
        SNR = mat_SNR(k);
        N=length(x);
        Pr = mean(abs(x).^2);
        sigma_carre = Pr*Ns/(2*log2(M)*SNR);
        nI = sqrt(sigma_carre)*randn(1,Ns*nb_bits/2);
        nQ = sqrt(sigma_carre)*randn(1,Ns*nb_bits/2);
        bruit = nI + 1j*nQ;
        canal = x + bruit;
        
        % Filtrage de réception
        x_complete = [canal zeros(1, retard)];
        z_recep = filter(h,1,x_complete);
        z = z_recep(retard + 1 : end);
        
        % Driagramme de l'oeil et échantillonnage
        diag_oeil = reshape(imag(z),Ns*2,[]);
        t0 = 1;
        zm = z(t0:Ns:end);
        % Prise de décision et démapping
        signal_recu = zeros(1, length(bits));
        for i = 1:length(zm)
            if real(zm(i))>0
                signal_recu(2*i-1) = 1;
            end;
            if imag(zm(i))>0
                signal_recu(2*i) = 1;
            end;
        end;
        
        %% Calcul du TEB
        bits_mal_recus = 0;
        for i = 1:nb_bits
            bits_mal_recus = bits_mal_recus + (signal_recu(i) ~= bits(i));
        end
        TEB = bits_mal_recus/nb_bits;
        mat_TEB(k) = TEB;
    end
    
    %% DSP 
    
    DSP = abs(fft(x));
    DSP = fliplr(DSP(round(length(DSP))/2:end));

    %% Puissance
    
    Puissance = trapz(DSP); %Intégration de la DSP
end
        
        
