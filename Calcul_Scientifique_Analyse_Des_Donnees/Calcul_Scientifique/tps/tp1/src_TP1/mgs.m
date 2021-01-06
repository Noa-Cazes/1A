%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% mgs.m
%--------------------------------------------------------------------------

function Q = mgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
   
    % Algorithme de Gram-Schmidt modifie
    for i= 1:m
        a = A(:,i);
        for j = 1:i-1
            q = Q(:,j);
            alpha = a'* q;
            a = a - alpha * q;
        end
        Q(:,i) = a/norm(a);
    end
end