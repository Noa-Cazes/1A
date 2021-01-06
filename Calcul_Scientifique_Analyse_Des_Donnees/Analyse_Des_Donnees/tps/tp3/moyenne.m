function X_T = moyenne(im)
 R = single(im(:, :, 1));
 V = single(im(:, :, 2));
 B = single(im(:, :, 3));
 
 % Vectoriser les trois caneaux
 taille = size(im);
 R_v = reshape(R, taille(1) * taille(2), 1);
 V_v = reshape(V, taille(1) * taille(2), 1);
 B_v = reshape(B, taille(1) * taille(2), 1);
 
 % Normaliser
 M = max(1, R_v + V_v + B_v);
 R_n = R_v ./ M;
 V_n = V_v ./ M;
 B_n = B_v ./ M;
 
 % Moyenne
 X_T = ones(1, 2);
 X_T(1,1) = mean(R_n);
 X_T(1, 2) = mean(V_n);
 

end

