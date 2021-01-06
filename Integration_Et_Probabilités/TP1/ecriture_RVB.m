function image_RVB = ecriture_RVB(image_originale)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[nb_lignes,nb_col] = size(image_originale);
image_RVB = zeros(nb_lignes/2,nb_col/2,3);
image_RVB(:,:,1) = image_originale(1:2:end,2:2:end);
image_RVB(:,:,2) = (image_originale(1:2:end,1:2:end) + image_originale(2:2:end,2:2:end))*0.5;
image_RVB(:,:,3) = image_originale(2:2:end,1:2:end);
end

