function [a_estime,b_estime] = estimation_1(x_donnees_bruitees,y_donnees_bruitees,psi_tests)
    x_g = mean(x_donnees_bruitees);
    y_g = mean(y_donnees_bruitees);
    
    x_donnees_centrees = x_donnees_bruitees - x_g;
    y_donnees_centrees = y_donnees_bruitees - y_g;
    
    S = sum((y_donnees_centrees - tan(psi_tests)*x_donnees_centrees).^2, 2);
    [valeur_min, indice_min] = min(S);
    
    a_estime = tan(psi_tests(indice_min,1));
   
    b_estime = y_g - a_estime*x_g;
end 