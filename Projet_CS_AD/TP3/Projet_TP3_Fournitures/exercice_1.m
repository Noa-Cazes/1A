clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
load donnees;
figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

% Calcul de l'individu moyen :
individu_moyen = mean(X);

% Centrage des donnees :
X_c = X - individu_moyen;

% Calcul de la matrice Sigma_2 (de taille n x n) [voir Annexe 1 pour la nature de Sigma_2] :
sigma_2 = X_c * X_c' / n;

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
[Y, vp] = eig(sigma_2);
vp = diag(vp);

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[vp, ind_vp] = sort(vp, 'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
Y = Y(ind_vp, :);

% Elimination du dernier vecteur propre de Sigma_2 :
Y = Y(:, 1:n-1);

% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = X_c' * Y;
    
% Normalisation des vecteurs propres de Sigma
% [les vecteurs propres de Sigma_2 sont normalisés
% mais le calcul qui donne W, les vecteurs propres de Sigma,
% leur fait perdre cette propriété] :
W = W / norm(W);

[~, ind_test] = sort(vecnorm(W), 'descend');
W = W(:, ind_test);

% Affichage de l'individu moyen et des eigenfaces sous forme d'images :
colormap gray;
img = reshape(individu_moyen,nb_lignes,nb_colonnes);
subplot(nb_individus,nb_postures,1);
imagesc(img);
axis image;
axis off;
title('Individu moyen','FontSize',15);
for k = 1:n-1
    img = reshape(W(:, k),nb_lignes, nb_colonnes);
    subplot(nb_individus,nb_postures,k+1);
    imagesc(img);
    axis image;
    axis off;
	title(['Eigenface ',num2str(k)],'FontSize',15);
end

save exercice_1;
