clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

%% EXERCICE 3

% Seuil de reconnaissance a regler convenablement
s = 7.0e+00;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :
individu = randi(37);
posture = randi(6);
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
C = X_c * W;
C_N = C(:, 1:N);

% N premieres composantes principales de l'image de test :
C_test = (image_test - individu_moyen) * W;
C_test_N = C_test(:, 1:N);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
%ecarts = C_N - C_test_N;
%[ecart_min, ind_ecart] = min(vecnorm(ecarts'));
K = 3;
distances = vecnorm((C_test_N - C_N)');
[~, indices] = sort(distances);
voisins = indices(1:K);
labels = repmat(numeros_individus, nb_postures, 1);

% Affichage du resultat :
if min(distances) < s
	individu_reconnu = labels(voisins(1));
	title({['Posture numero ' num2str(posture) ' de l''individu numero '...
        num2str(individu)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero '...
        num2str(individu)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end


%% CLASSIFIEUR
numero_postures_test = [1, 2, 3, 4, 5, 6];
nb_postures_test = length(numero_postures_test);
partition = zeros(nb_postures_test, nb_individus);
for i = 1:nb_individus
    for j = 1:nb_postures_test
        individu = numeros_individus(i);
        posture = numero_postures_test(j);
        fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
        Im=importdata(fichier);
        I=rgb2gray(Im);
        I=im2double(I);
        image_test=I(:)';
        % Nombre N de composantes principales a prendre en compte 
        % [dans un second temps, N peut etre calcule pour atteindre le pourcentage
        % d'information avec N valeurs propres] :
        N = 8;

        % N premieres composantes principales des images d'apprentissage :
        C = X_c * W;
        C_N = C(:, 1:N);

        % N premieres composantes principales de l'image de test :
        C_test = (image_test - individu_moyen) * W;
        C_test_N = C_test(:, 1:N);

        % Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
        %ecarts = C_N - C_test_N;
        %[ecart_min, ind_ecart] = min(vecnorm(ecarts'));
        K = 1;
        distances = vecnorm((C_test_N - C_N)');
        [~, indices] = sort(distances);
        voisins = indices(1:K);
        labels = repmat(numeros_individus, nb_postures, 1);

        % Classification
        ListeClasses = 1:37;
        labels_voisins = labels(voisins);
        compte = histc(labels_voisins, ListeClasses);
        [valeurMax, indiceClasse] = max(compte);

        if length(find(compte == valeurMax)) > 1
            classe = labels(voisins(1));
        else
            classe = ListeClasses(indiceClasse);
        end
        
        % Partition
        partition(j, i) = classe;
    end
end

% Calcul de la matrice de confusion et du taux d'erreur

nb_tests = nb_individus*nb_postures_test;
confusion = zeros(length(ListeClasses));
labels_test = repmat(numeros_individus, nb_postures_test, 1);
for i = 1:nb_tests
    confusion(labels_test(i), partition(i)) = confusion(labels_test(i), partition(i)) + 1;
end

nb_erreurs = (nb_tests - sum(diag(confusion)));
taux = nb_erreurs ./ nb_tests;

disp('Matrice de confusion :')
disp(confusion)
disp(['Taux d''erreur :' num2str(taux)])
