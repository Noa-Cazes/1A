function [out] = frequencyTranspose(in, fp, time, fig)
%FREQTRANS Transpose en fr�quence le signal in
%   in : Signal � transposer
%   fp : Fr�quence Porteuse
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
    
    out = real(in .* exp(2i * pi * fp * time));
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(out), out, 'b-'); 
        ylim([min(out)-1 max(out)+1])
        title('Signal généré sur fréquence porteuse');
        xlabel('Temps');
        ylabel('Tension');
    end
end

