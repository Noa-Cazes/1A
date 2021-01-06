function [dirac] = toDirac(symbols, Ns, fig)
%TODIRAC G�n�re un peigne de dirac pond�r� par les symboles
%   symbols : Symboles � partir desquels g�n�rer le peigne
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
    
    dirac = kron(symbols, [1, zeros(1, Ns-1)]);
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(dirac), real(dirac), 'b-');
        plot(1:length(dirac), imag(dirac), 'c--'); 
        ylim([min(min(real(dirac), imag(dirac)))-1 max(max(real(dirac), imag(dirac)))+1])
        title('Peigne de dirac pondéré par les symboles');
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end

