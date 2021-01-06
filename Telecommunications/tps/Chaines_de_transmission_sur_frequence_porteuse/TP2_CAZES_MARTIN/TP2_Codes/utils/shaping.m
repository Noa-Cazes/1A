function [signal] = shaping(dirac, h, fig)
%SHAPING Met en forme le signal � l'aide du filtre de mise en forme
%   dirac : Peigne de dirac pond�r� par les symboles
%   h : Filtre de mise en forme
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
            fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    signal = conv(dirac, h, 'same');
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(signal), real(signal), 'b-'); 
        plot(1:length(signal), imag(signal), 'c--');
        ylim([min(min(real(signal), imag(signal)))-1 max(max(real(signal), imag(signal)))+1])
        if dirac(end) == 0
            title('Signal généré en bande de base');
        else
            title('Signal reçu après filtrage de réception');
        end
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end

