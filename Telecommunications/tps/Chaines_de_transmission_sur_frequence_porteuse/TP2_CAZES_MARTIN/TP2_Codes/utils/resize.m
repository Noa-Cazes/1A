function resize(fig, width, height)
%RESIZE Change la taille d'une figure
%   fig : Poignée de la figure à modifier
%   width : Largeur de la figure
%   height : Hauteur de la figure
    if ~exist('height', 'var')
        height = width;
        width = fig;
        fig = gcf;
    end
    
    pos = get(fig, 'position');
    set(fig, 'innerposition', [pos(1:2) width height]);
end

