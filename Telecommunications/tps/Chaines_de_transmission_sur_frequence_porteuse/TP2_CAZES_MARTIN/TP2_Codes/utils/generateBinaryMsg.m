function [msg] = generateBinaryMsg(length, fig)
%GENERATEBINARYMSG G�n�re al�atoirement un message binaire
%   length : Longueur du message binaire
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    msg = randi([0, 1], 1, length);
    
    if(fig > 0)
        figure(fig);
        ratio(460, 80);
        plot(msg, 'r.');
        ylim([-1 2]);
        title("Message binaire");
        xlabel("Index du bit");
        ylabel("Valeur du bit");
    end
end
