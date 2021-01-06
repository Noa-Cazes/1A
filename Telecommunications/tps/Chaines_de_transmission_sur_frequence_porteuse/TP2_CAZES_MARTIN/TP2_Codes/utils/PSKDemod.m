function [out] = PSKDemod(in, M, fig)
%PSKDEMOD Demodulation PSK
%   in : Signal à transposer
%   M : Nombre de symboles
%   fig : Poignée de la figure sur laquelle afficher le résultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    out = demsg2bimsg(pskdemod(in, M, 0, 'gray'), M);
    
    if(fig > 0)
        figure(fig);
        ratio(460, 80);
        plot(out, 'r.');
        ylim([-1 2]);
        title("Message binaire obtenu");
        xlabel("Index du bit");
        ylabel("Valeur du bit");
    end
end

