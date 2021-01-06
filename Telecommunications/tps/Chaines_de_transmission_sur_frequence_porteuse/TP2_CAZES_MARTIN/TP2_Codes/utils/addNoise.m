function out = addNoise(in, Eb_N0, Ns, M, fig)
%ADDNOISE Ajoute du bruit au signal
%   in : Signal en entr�e
%   Eb_N0 : SNR normalis�
%   Ns : Facteur de sur�chantillonage
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    if(Eb_N0 > 0)
        Px = mean(abs(in .* in));
        sigma2 = Px * Ns / (2 * log2(M) * Eb_N0);
        noise = sqrt(sigma2) .* randn(1, length(in));

        out = in + noise;
    else
        out = in;
    end
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(out), out, 'b-'); 
        ylim([min(out)-1 max(out)+1])
        title('Signal bruité');
        xlabel('Temps');
        ylabel('Tension');
    end
end

