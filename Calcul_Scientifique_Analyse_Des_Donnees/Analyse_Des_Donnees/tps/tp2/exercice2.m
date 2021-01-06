clear all;
close all;
clc;

%% Les fichiers utiles
load SG1.mat;
load ImSG1.mat;

%% Résolution par la méthode aux MCO
% Avec les données tronquées
Data = reshape(Data, length(Data)*50, 1);
DataMod = reshape(DataMod, length(DataMod)*50, 1);
A = [Data, ones(2500, 1)]
B = log(DataMod);
X = pinv(A)*B;

% Avec l'image complète
alpha = X(1,1);
beta = - X(2,1);
Im = - (1/alpha) * (log(ImMod) - beta);
figure();
imshow(Im)

% Reconstruire l'image originale
% I image réelle
% Im image reconstruite
C = [A, B];
Y = [X; -1];
err = norm(C*Y)*norm(C*Y)

%% Résolution par la méthode des MCT
% Résolution
A1 = [Data, ones(2500, 1)]
B1 = log(DataMod);
s = svd(A1);
V = s(1, 3);
X1 = -V(:,end)/V(end,end);

% Reconstruire l'image originale
alpha = X1(1,1);
beta = - X1(2,1);
Im = - (1/alpha) * (log(ImMod) - beta);
figure();
imshow(Im)


% Calculer l'erreur
C = [A, B];
Y = [X; -1];
err = norm(C*Y)*norm(C*Y)

