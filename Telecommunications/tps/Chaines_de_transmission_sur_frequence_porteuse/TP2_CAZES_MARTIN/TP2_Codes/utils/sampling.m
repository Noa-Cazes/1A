function [sample] = sampling(signal, Ns, t0, fig)
%SAMPLING �chantillonage du signal avec un d�callage de t0
%   signal : Signal � �chantilloner
%   Ns : Facteur de sur�chantillonage
%   t0 : Instant id�al d'�chantillonage
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
            fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    sample = signal(t0:Ns:end);
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(sample), real(sample), '+--', 'color', '#88f', 'markeredgecolor', '#00f'); 
        plot(1:length(sample), imag(sample), 'x--', 'color', '#8ff', 'markeredgecolor', '#0ff'); 
        ylim([min(min(real(sample), imag(sample)))-1 max(max(real(sample), imag(sample)))+1])
        title('Signal reçu échantilloné en t0');
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end

