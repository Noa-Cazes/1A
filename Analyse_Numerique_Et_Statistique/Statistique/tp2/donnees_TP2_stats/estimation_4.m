function [cos_theta_estime,sin_theta_estime,rho_estime] = estimation_4(x_donnees_bruitees,y_donnees_bruitees)
    x_g = mean(x_donnees_bruitees);
    y_g = mean(y_donnees_bruitees);
    
    x_donnees_centrees = x_donnees_bruitees - x_g;
    y_donnees_centrees = y_donnees_bruitees - y_g;

    C = [x_donnees_centrees;y_donnees_centrees]';
    
    [vect_p,val_p] = eig(C'*C);
    
    Y = vect_p(:,find(diag(val_p)==min(diag(val_p))));
    
    cos_theta_estime = Y(1);
    sin_theta_estime = Y(2);
    rho_estime = cos_theta_estime*x_g + sin_theta_estime*y_g;
end