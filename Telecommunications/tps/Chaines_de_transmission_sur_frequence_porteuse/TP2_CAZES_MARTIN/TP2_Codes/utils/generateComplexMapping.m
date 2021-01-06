function mapping = generateComplexMapping(M, spacing, fig)
%GENERATEMAPPING G�n�re automatiquement un mapping M-aire complexe
%   M : Nombre de symboles
%   spacing : Espace entre chaque symboles
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
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
    if(log2(M) ~= floor(log2(M)))
        warning(['Génération d''un mapping ' int2str(2^floor(log2(M))) '-aire. (M=' int2str(M) ')']);
    end
        
    M_re = 2 * round(log2(M)/2);
    M_im = 2 * floor(log2(M)/2);
    
    mapping_re = generateMapping(M_re, spacing);
    mapping_im = generateMapping(M_im, spacing * 1i);
    mapping = repmat(mapping_re, M_im, 1) + transpose(repmat(mapping_im, M_re, 1));
    
    mappingGray = [0 1 3 2 4 5 7 6 12 13 15 14 8 9 11 10];
    %mapping = reshape(mapping(mappingGray(1:M) + 1), M_im, M_re);
    
    if(fig > 0)
        figure(fig)
        ratio(M_re, M_im);
        plot(real(mapping), imag(mapping), 'r.', 'markersize', 25);
        axis([-M_re*spacing/2 M_re*spacing/2 -M_im*spacing/2 M_im*spacing/2]);
        title(['Mapping ' int2str(2^floor(log2(M))) '-aire']);
        xlabel('Partie réelle du symbole');
        ylabel('Partie imaginaire du symbole');
        text(real(mapping(:)) -.5, imag(mapping(:)) -.5, num2str(flip(de2bi(0:M-1, log2(M)), 2)));
    end
end

