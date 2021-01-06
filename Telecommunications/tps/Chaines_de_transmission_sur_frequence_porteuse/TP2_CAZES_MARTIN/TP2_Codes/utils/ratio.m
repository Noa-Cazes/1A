function ratio(fig, width, height, anchor)
%RATIO Change le ratio d'une figure relativement � sa taille actuelle
%   fig : Poign�e de la figure � modifier
%   width : Largeur du ratio
%   height : Hauteur du ratio
%   anchor : C�t� dont la taille est pr�serv�e
    if ~exist('height', 'var')
        height = width;
        width = fig;
        fig = gcf;
    end
    if ~exist('anchor', 'var')
        if isnumeric(height)
            if(width > height)
                anchor = 'width';
            else
                anchor = 'height';
            end
        else
            anchor = height;
            height = width;
            width = fig;
            fig = gcf;
        end
    end
    if ~ismember(anchor, {'width', 'height'})
        error(['Valeur de anchor invalide.' newline 'anchor devrait être soit ''width'' soit ''height''']);
    end
    
    ratio = width / height;
    pos = get(fig, 'position');
    if(strcmp(anchor, 'width'))
        width = pos(3);
        height = width/ratio;
    else
        height = pos(4);
        width = height*ratio;
    end
    resize(fig, width, height);
end

