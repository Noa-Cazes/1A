function [symbols] = generateSymbols(binMsg, mapping, fig)
%GENERATESIGNAL G�n�re une signal � partir d'un message binaire, d'un
%mapping et d'un facteur de sur�chantillonage.
%   binMsg : Message binaire � partir duquel le message est g�n�r�
%   mapping : Symboles que le message binaire utilisera
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
    
    M = numel(mapping);
    binWordSize = log2(M);
    if length(binMsg)/binWordSize ~= floor(length(binMsg)/binWordSize)
        error('Le mapping n''est pas adapté à la taille du message.');
    end
    if binWordSize > 4
        warning('Mapping de gray impossible pour le mapping donné.');
    end
    
    indices = bi2de(flip(reshape(binMsg, log2(M), length(binMsg)/log2(M))', 2)) + 1;
    symbols = transpose(mapping(indices));
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(symbols), real(symbols), 'b+'); 
        plot(1:length(symbols), imag(symbols), 'cx');
        ylim([min(min(real(symbols), imag(symbols)))-1 max(max(real(symbols), imag(symbols)))+1])
        title('Symboles générés');
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end