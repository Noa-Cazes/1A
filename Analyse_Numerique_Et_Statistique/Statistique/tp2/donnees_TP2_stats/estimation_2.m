function [a_estime,b_estime] = estimation_2(x_donnees_bruitees,y_donnees_bruitees)
 
    A = [x_donnees_bruitees; ones(1,length(x_donnees_bruitees))]'; 
    
    B = y_donnees_bruitees';
    
    X = A\B;
    a_estime = X(1);
    b_estime = X(2);
end 