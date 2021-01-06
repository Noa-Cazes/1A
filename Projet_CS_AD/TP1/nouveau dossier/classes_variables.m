%% INITIALISATION
clear variables
close all

% chargement du jeu de données
load('dataset.mat')
n = size(X, 1);

%% CALCUL
X_m = mean(X);
X_c = X - X_m;
sigma = 1/n * (X_c' * X_c);

[axes, D] = eig(sigma);

Contraste = diag(D) ./ sum(diag(D));

[Contraste, ind] = sort(Contraste, 'descend');
axes = axes(:, ind);    % LÃ  on a des axes et ils sont ordonnÃ©s

C = X_c * axes;

%% AFFICHAGE 
figure(1),clf
title('Pourcentage d info contenue sur chaque composante ppale')
bar(1:length(Contraste), 100*Contraste, 'LineStyle', 'none');
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

figure(2),clf, 
grid on
title('Proj. des donnees sur 3 1ers axes ppaux')
plot3(C(1:end, 1), C(1:end, 2), C(1:end, 4), "r+");grid on;

%% VARIABLES
I1 = X(1:end, 3) > 1;
C1 = [C(I1, 1) C(I1, 2) C(I1, 4)];
I2 = X(1:end, 3) <= 1;
C2 = [C(I2, 1) C(I2, 2) C(I2, 4)];

figure(3), clf,
title('je sé pa se ke je fé')
plot3(C1(1:end, 1), C1(1:end, 2), C1(1:end, 3), 'r+'); hold on; grid on;
plot3(C2(1:end, 1), C2(1:end, 2), C2(1:end, 3), 'b+');
xlabel('1^è^r^e Composante principale')
ylabel('2^e^m^e Composante principale')
zlabel('4^e^m^e Composante principale')


