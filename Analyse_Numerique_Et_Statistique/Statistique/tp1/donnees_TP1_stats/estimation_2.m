function [C_estime, R_estime] = estimation_2(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_tests)
    M = size(x_donnees_bruitees);
    x_donnees_brutes_repliquee = repmat(C_tests(:,1), 1, M(1));
    y_donnees_brutes_repliquee = repmat(C_tests(:,2), 1, M(1));
    x_donnees_bruitees_repliquee = repmat(x_donnees_bruitees', 1, 1000)';
    y_donnees_bruitees_repliquee = repmat(y_donnees_bruitees', 1, 1000)';
    R_matrice = R_tests*ones(1,M(1))
    A = (sqrt((x_donnees_bruitees_repliquee - x_donnees_brutes_repliquee).^2 + (y_donnees_bruitees_repliquee - y_donnees_brutes_repliquee).^2)-R_matrice).^2;
    S = sum(A,2);
    % somme sur les colonnes
    [valeur_min,indice] = min(S);
    % renvoie l'indice de l'élément minimal
    % ou find(S==min(S))
    C_estime = C_tests(indice,:)
    R_estime = R_tests(indice, :)
end