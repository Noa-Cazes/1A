clear variables; close all; clc;

% Visualiser un individu de taille 1 :
x = rand(1); % generation d'un element aleatoire par une distribution uniforme
figure(1),clf, 
plot(0,0,'ko','linewidth',2)
hold on, plot([0 1.5*x],[0 0],'k-') % On trace un segment de la droite des 
% abscisses (ordonnees de debut et de fin : 0 et 0) suffisamment grand pour
% pouvoir placer x 
hold on, plot(x,0,'r*','linewidth',3) % on place x sur la droite des abscisses
legend('Origine du repere','Vecteur de base','Individu');
title('Un nombre sur la droite des réels');

% Visualiser un individu de taille 2 :
x = rand(1,2); % generation d'une matrice a une ligne et deux colonnes 
% -- x est donc un vecteur ligne -- par une distribution uniforme
figure(2),clf, plot(x(1),x(2),'r*','linewidth',3);grid on
title('Un élement de R2')

% Visualiser un individu de taille 3 :
x = rand(1,3);% generation d'une matrice a une ligne et trois colonnes 
% -- x est donc un vecteur ligne -- par une distribution uniforme
figure(3),clf, plot3(x(1),x(2),x(3),'r*','linewidth',3);grid on
title('Un élement de R3')

% Nous allons maintenant travailler avec un nuage d'individus. Ce nuage
% contient nb_indiv points
nb_indiv = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ATTENTION : LE CODE CI-DESSOUS (ET DE MANIERE GENERALE, LES AUTRES CODES)
% EST FOURNI POUR VOUS AIDER A COMPRENDRE LA GENERATION DE VECTEURS ET 
% LA MANIPULATION DES FIGURES SOUS MATLAB (AJOUT D'UNE LEGENDE, CREATION 
% D'AXES, AFFICHAGE DE PLUSIEURS POINTS EN MEME TEMPS...). 
% ILS DOIVENT ETRE MODIFIES OU COMPLETES POUR EFFECTUER CE QUI EST DEMANDE 
% EN CONSIGNE.
% AFIN QUE LE SCRIPT FONCTIONNE SANS PLANTAGE, NOUS AVONS ECRIT DES
% INSTRUCTIONS QUE VOUS DEVEZ CHANGER (PAR EXEMPLE, LA CREATION ET 
% L'AFFICHAGE DES INDIVIDUS DANS LA SUITE DE CE CODE)
%
% VOUS POUVEZ EFFACER LA LIGNE QUI AFFICHE A COMPLETER UNE FOIS LE TRAVAIL
% REALISE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERER ALEATOIREMENT UN TABLEAU DE DONNEES CONTENANT DIX NOMBRES GENERES
% SUIVANT UNE DISTRIBUTION  UNIFORME. 
% AFFICHER CES NOMBRES ET L'ELEMENT MOYEN SUR LA DROITE DES REELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = randn(1,nb_indiv); 
x_mean = mean(x);

figure(11),clf
plot(0,0,'ko','linewidth',2)
hold on,plot([0 1],[0 0],'k-') % tracer le segment de droite permettant de 
% placer le nuage de points
hold on, plot(x,zeros(1,nb_indiv),'r*',x_mean,0,'b+','linewidth',3);grid on
legend('Origine du repere','Vecteur de base','Individus','Élement moyen');
title('Des nombres sur la droite des réels');

% disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERER ALEATOIREMENT UN TABLEAU DE DONNEES CONTENANT DIX INDIVIDUS DE 
% TAILLE 2, SUIVANT UNE DISTRIBUTION GAUSSIENNE DE MOYENNE 0 ET D ECART 
% TYPE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = randn(2,nb_indiv); 
x_mean = mean(x, 2);  % Moyenne pour chaque colonne comme Ã§a on s'en rappelle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER CES VECTEURS ET L'ELEMENT MOYEN DANS LE PLAN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(12), clf
plot(x(1,:),x(2,:),'r*',x_mean(1),x_mean(2),'b+','linewidth',3);grid on
title('Des nombres dans le plan des réels')

% disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERER ALEATOIREMENT UN TABLEAU DE DONNEES CONTENANT DIX INDIVIDUS DE 
% TAILLE 3, SUIVANT UNE DISTRIBUTION GAUSSIENNE DE MOYENNE 2 ET D ECART 
% TYPE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

var = 3;
moy = 2;
x = sqrt(var) * randn(3,nb_indiv) + moy; 
x_mean = mean(x,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER CES VECTEURS ET L'ELEMENT MOYEN DANS L ESPACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(13), clf
plot3(x(1, :),x(2, :),x(3, :),'r*', x_mean(1), x_mean(2), x_mean(3), 'b+','linewidth',3);grid on
title('Des nombres dans l''espace des réels')

