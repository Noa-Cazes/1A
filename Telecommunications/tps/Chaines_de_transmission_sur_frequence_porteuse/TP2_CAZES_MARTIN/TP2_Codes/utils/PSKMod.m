function [out] = PSKMod(in, M, fig)
%PSKMOD Modulation PSK
%   in : Signal � transposer
%   M : Nombre de symboles
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    out = pskmod(in, M, 0, 'gray');
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(out), real(out), 'b+'); 
        plot(1:length(out), imag(out), 'cx'); 
        ylim([min(min(real(out), imag(out)))-1 max(max(real(out), imag(out)))+1])
        title('Signal généré sur bande de base');
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end

