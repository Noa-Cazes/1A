function [C_x,C_y,M] = matrice_inertie(E_x,E_y,G_norme_E)
    poids_tot = sum(G_norme_E);
    C_x = sum(G_norme_E.* E_x)/poids_tot;
    C_y = sum(G_norme_E.* E_y)/poids_tot;
    M = zeros(2,2);
    M(1,1) = sum(G_norme_E.*(E_x-C_x).^2)/poids_tot;
    M(2,2) = sum(G_norme_E.*(E_y-C_y).^2)/poids_tot;
    M(1,2) = sum(G_norme_E.*(E_y-C_y).*(E_x-C_x))/poids_tot;
    M(2,1) = M(1,2);
end

