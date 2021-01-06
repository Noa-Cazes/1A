function [out] = downConversion(in, fp, Fe, time, fig)
%DOWNCONVERSION Retour en bande de base du out
%   in : out en entr�e
%   fp : Fr�quence porteuse
%   Fe : Fr�quence d'�chantillonage
%   time : Vecteur de temps
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    out_re = in .* cos(2*pi*fp*time);
    out_im = in .* sin(2*pi*fp*time);
    out = lowpass(out_re, fp/Fe) - 1i * lowpass(out_im, fp/Fe);
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(out), real(out), 'b-'); 
        plot(1:length(out), imag(out), 'c--');
        ylim([min(min(real(out), imag(out)))-1 max(max(real(out), imag(out)))+1])
        title('Signal en réception');
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end

