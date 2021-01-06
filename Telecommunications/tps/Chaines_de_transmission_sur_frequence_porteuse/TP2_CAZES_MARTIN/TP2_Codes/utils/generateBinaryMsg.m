function [msg] = generateBinaryMsg(length, fig)
%GENERATEBINARYMSG Génère aléatoirement un message binaire
%   length : Longueur du message binaire
%   fig : Poignée de la figure sur laquelle afficher le résultat
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
