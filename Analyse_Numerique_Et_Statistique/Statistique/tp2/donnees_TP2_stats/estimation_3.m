function [theta_estime,rho_estime] = estimation_3(x_donnees_bruitees,y_donnees_bruitees,theta_tests)
    x_g = mean(x_donnees_bruitees);
    y_g = mean(y_donnees_bruitees);
    
    x_donnees_centrees = x_donnees_bruitees - x_g;
    y_donnees_centrees = y_donnees_bruitees - y_g;
    
    S = sum((sin(theta_tests)*y_donnees_centrees + cos(theta_tests)*x_donnees_centrees).^2, 2);
    [valeur_min, indice_min] = min(S);
    
    theta_estime = theta_tests(indice_min,1);
   
    rho_estime = y_g*sin(theta_estime) + x_g*cos(theta_estime);
end 