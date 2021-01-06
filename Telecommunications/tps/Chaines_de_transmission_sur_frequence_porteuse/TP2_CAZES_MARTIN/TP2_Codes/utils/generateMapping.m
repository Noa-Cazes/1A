function [mapping] = generateMapping(M, spacing, fig)
%GENERATEMAPPING Génère automatiquement un mapping M-aire
%   M : Nombre de symboles
%   spacing : Espace entre chaque symboles
%   fig : Poignée de la figure sur laquelle afficher le résultat
    if ~exist('spacing', 'var')
        spacing = 2;
    end
    if ~exist('fig', 'var')
            fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end
    
    M = floor(M);
    mapping = ((0:M-1) * spacing) - (M-1) * spacing/2;
    mapping = flip(mapping, 1);
    
    mappingGray = [0 1 3 2 4 5 7 6 12 13 15 14 8 9 11 10];
    mapping = mapping(mappingGray(1:M)+1);
    
    if(fig > 0)
        figure(fig)
        grid on;
        ratio(460, 80);
        plot(mapping, zeros(length(mapping)), 'r.', 'markersize', 25);
        axis([-M*spacing/2 M*spacing/2 -1 1]);
        title(['Mapping ' int2str(M) '-aire']);
        xlabel('Symbole');
        text(mapping, zeros(1, length(mapping)) -.5, num2str(flip(de2bi(0:M-1, log2(M)), 2)));
    end
end

