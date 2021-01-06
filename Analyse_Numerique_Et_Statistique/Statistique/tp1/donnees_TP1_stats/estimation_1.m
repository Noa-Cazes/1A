function C_estime = estimation_1(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_0)
    x_donnees_brutes_repliquee = repmat(C_tests(:,1), 1, 50);
    y_donnees_brutes_repliquee = repmat(C_tests(:,2), 1, 50);
    x_donnees_bruitees_repliquee = repmat(x_donnees_bruitees', 1, 1000)';
    y_donnees_bruitees_repliquee = repmat(y_donnees_bruitees', 1, 1000)';
    A = (sqrt((x_donnees_bruitees_repliquee - x_donnees_brutes_repliquee).^2 + (y_donnees_bruitees_repliquee - y_donnees_brutes_repliquee).^2)-R_0).^2;
    S = sum(A,2);
    % somme sur les colonnes
    [valeur_min,indice] = min(S);
    % renvoie l'indice de l'élément minimal
    % ou find(S==min(S))
    C_estime = C_tests(indice,:)
end

