function [TEB] = ChQPSK(alpha, Rb, Eb_N0_dB, display)
%ChQPSK Cha�ne de transmission avec modulation Q-PSK
%   alpha : roll-off de mise en forme.
%   Rb : D�bit binaire.
%   Eb_N0_dB : SNR normalis�
%   display : Tableau de cellules contenant des cha�nes de caract�re.
%   dictant quoi afficher.
%       'msg' Affiche le message binaire g�n�r�
%       'map' Affiche le mapping g�n�r�
%       'sym' Affiche les symboles g�n��r�s
%       'dirac' Affiche le peigne de dirac pond�r� par les symboles
%       'bdb' Affiche le signal sur bande de base
%       'fp' Affiche le signal sur fr�quence porteuse
%       'c' Affiche le signal en sortie du canal de propagation
%       'dc' Affiche le signal apr�s retour en bande de base
%       'f' Affiche le signal apr�s mise en forme en r�ception
%       'sam' Affiche le signal �chantillon�
%       'dec' Affiche les symboles d�cid�s
%       'res' Affiche le message binaire obtenu
%
%       'all' Affiche tout
%       
%       Exemple : display = {'msg', 'res'} affichera le message binaire
%       g�n�r� et le message binaire obtenu

    if ~exist('display', 'var')
        display = {};
    end
    %% CONSTANTES
    
    Eb_N0 = 10.^(Eb_N0_dB/10);
    nbBits = 1000;
    M = 4;
    spacing = 2;
    fp = 2000; 
    Fe = 10000;
    Rs = Rb * log2(M);
    Ts = 1/Rs;
    Te = 1/Fe;
    Ns = floor(Ts/Te) + 1;
    time = generateTimeVector(nbBits, Ns, Te, M);
    h = rcosdesign(alpha, 4 * floor(log2(M)), Ns, 'normal');
    t0 = 1;
    
    TEB = zeros(1, length(Eb_N0));
    TEB_th = zeros(1, length(Eb_N0));

    %% GENERATION

    binMsg = generateBinaryMsg(nbBits, (ismember('all', display) | ismember('msg', display)) - 1);
    % mapping = generateComplexMapping(M, spacing, (ismember('all', display) | ismember('map', display)) - 1);
    % symbolesG = generateSymbols(binMsg, mapping, (ismember('all', display) | ismember('sym', display)) - 1);
    symbolesG = PSKMod(bimsg2demsg(binMsg, M), M, (ismember('all', display) | ismember('sym', display)) - 1)';
    dirac = toDirac(symbolesG, Ns, (ismember('all', display) | ismember('dir', display)) - 1);
    signalBDB = shaping(dirac, h, (ismember('all', display) | ismember('bdb', display)) - 1);

    %% TRANSPOSITION

    % signalFP = frequencyTranspose(signalBDB, fp, time, (ismember('all', display) | ismember('fp', display)) - 1);

    for i = 1:length(Eb_N0)
        %% CANAL

        signalC = addNoise(signalBDB, Eb_N0(i), Ns, M, (ismember('all', display) | ismember('c', display)) - 1);

        %% RETOUR EN BANDE DE BASE

        % signalR = downConversion(signalC, fp, Fe, time, (ismember('all', display) | ismember('dc', display)) - 1);

        %% DEMODULATION

        signalF = shaping(signalC, h, (ismember('all', display) | ismember('f', display)) - 1);
        signalE = sampling(signalF, Ns, t0, (ismember('all', display) | ismember('sam', display)) - 1);
        %symbolesD = decision(signalE, M, spacing, (ismember('all', display) | ismember('dec', display)) - 1);
        %msgR = demapping(symbolesD, mapping, (ismember('all', display) | ismember('res', display)) - 1);
        msgR = PSKDemod(signalE, M, (ismember('all', display) | ismember('res', display)) - 1);

        %% TEB

        % TES = 1 - sum(symbolesG == symbolesD) / length(symbolesG);
        TEB(i) = 1 - sum(msgR == binMsg) / nbBits;
        TEB_th(1,i) = qfunc(sqrt(Eb_N0(1,i)))/4;
    end
    
    if(ismember('all', display) || ismember('teb', display))
        figure()
        hold on;
        grid on;
        % ratio(460, 80);
        semilogy(Eb_N0, TEB_th, 'y.-');
        semilogy(Eb_N0, TEB, 'g.-');
        legend('TEB théorique', 'TEB simulé'); 
        title('Evolution du Taux d''Erreur Binaire fonction de (E_b/N_0)dB Q-PSK');
        ylabel('TEB');
        xlabel('(E_b/N_0)dB');
    end
    
     
end

