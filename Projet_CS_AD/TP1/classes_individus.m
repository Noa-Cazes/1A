%% INITIALISATION
clear variables
close all

% chargement du jeu de donn�es
load('dataset.mat')
n = size(X, 1);

figure(4)
plot3(X(1:end, 1), X(1:end, 2), X(1:end, 4), "r+");
xlabel('1^e^r axe canonique')
ylabel('2^e^m^e axe canonique')
zlabel('4^e^m^e axe canonique')
%% CALCUL
X_m = mean(X);
X_c = X - X_m;
sigma = 1/n * (X_c' * X_c);

[axes, D] = eig(sigma);

Contraste = diag(D) ./ sum(diag(D));

[Contraste, ind] = sort(Contraste, 'descend');
axes = axes(:, ind);    % Là on a des axes et ils sont ordonnés

C = X_c * axes;

%% AFFICHAGE 
figure(1),clf
title('Pourcentage d info contenue sur chaque composante ppale')
bar(1:length(Contraste), 100*Contraste, 'LineStyle', 'none');
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

figure(2),clf, 
grid on
%title('Proj. des donnees sur 3 1ers axes ppaux')
plot3(C(1:end, 1), C(1:end, 2), C(1:end, 4), "r+");grid on;
xlabel('1^e^r^e Composante principale')
ylabel('2^e^m^e Composante principale')
zlabel('4^e^m^e Composante principale')