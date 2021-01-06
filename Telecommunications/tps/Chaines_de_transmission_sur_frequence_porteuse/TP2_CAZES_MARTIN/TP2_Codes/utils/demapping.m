function [msg] = demapping(symboles, mapping, fig)
%DEMAPPING Convertion des symboles en message binaire
%   symboles : Symboles à convertir
%   mapping : Mapping  partir duquel situer les symboles
%   fig : Poignée de la figure sur laquelle afficher le résultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    M = numel(mapping);
    index = zeros(length(symboles), log2(M));
    for i = 1:length(symboles)
        index(i, :) = de2bi(find(mapping == symboles(i)) - 1, log2(M));
    end
    index_re = bi2de(index(:, 1:log2(length(mapping))));
    index_im = bi2de(index(:, log2(length(mapping))+1:end));
    msg = [flip(de2bi(index_im, log2(M)-log2(length(mapping))), 2) flip(de2bi(index_re, log2(length(mapping))), 2)]';
    msg = msg(:)';
    
    if(fig > 0)
        figure(fig);
        ratio(460, 80);
        plot(msg, 'r.');
        ylim([-1 2]);
        title("Message binaire obtenu");
        xlabel("Index du bit");
        ylabel("Valeur du bit");
    end
end

