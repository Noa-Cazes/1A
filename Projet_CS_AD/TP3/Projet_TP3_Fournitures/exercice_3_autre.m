clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);
% Seuil de reconnaissance a regler convenablement
s = 25;

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

% Composantes principales des donnees d'apprentissage
C = X_c * W;

% N premieres composantes principales des images d'apprentissage :
N_CP_Appr = C( : , 1:N );

% N premieres composantes principales de l'image de test :
image_test_c = image_test - individu_moyen;
C_test = image_test_c * W;
N_CP_test = C_test( : , 1:N );

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
ListeClasse = 1:37;

train_labels = repmat(numeros_individus, nb_postures, 1);
train_labels = train_labels(:);

%Inspiré du TP 4 Analyse de Données:
k = 3;
% Calcul des distances entre les vecteurs de test et les vecteurs
% d'apprentissage (voisins)
Distance = sqrt(sum((N_CP_Appr - repmat(N_CP_test, size(N_CP_Appr, 1), 1)).^2, 2));

% On ne garde que les indices des k + proches voisins
[~, indexes] = sort(Distance, 'ascend');
kppv = indexes;
kppv = kppv(1:k);

%data_labels = repmat(1:37,6,1);
%data_labels = data_labels(:);
test_labels = train_labels(kppv);
postures = mod(kppv, nb_postures).';
postures(postures == 0) = nb_postures;
recognitionMatrix = [test_labels postures'];

%Comptage du nombre de voisins appartenant à chaque classe
occurrences = histc(test_labels, ListeClasse);

% Recherche de la classe contenant le maximum de voisins
[maxOccurrence, maxOccurrenceIndex] = max(occurrences);

% Si l'image test a le plus grand nombre de voisins dans plusieurs
% classes différentes, alors on lui assigne celle du voisin le + proche,
% sinon on lui assigne l'unique classe contenant le plus de voisins
if length(find(occurrences == maxOccurrence)) > 1
    individu_reconnu_test = train_labels(kppv(1));
else
    individu_reconnu_test = ListeClasse(maxOccurrenceIndex);
end
% Affichage du resultat :
if min(Distance) < s
    individu_reconnu = individu_reconnu_test; % le n° de l'indiv reconnu est celui dont la classe est la plus présente
    title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
        ['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
else
    title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
        'Je ne reconnais pas cet individu !'},'FontSize',20);
end

% Affichage de l'image requête
figure('Name',"FIGURE - Résultat d'une requête sur une base de visages",'Position',[0.2*L,0.2*H,0.6*L,0.5*H]);
subplot(1, k + 1, 1);
colormap gray;
imagesc(I);
axis image;
title("Requête");

for i = 1:k
    subplot(1, k+1, i+1);
    fichier = [chemin '/' num2str(recognitionMatrix(i, 1) + 3) '-' num2str( recognitionMatrix(i, 2) ) '.jpg'];
    Im = importdata(fichier);
    I = rgb2gray(Im);
    I = im2double(I);
    imagesc(I);
    axis image;
    title("Trouvée - choix " + i);
end