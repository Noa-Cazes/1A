%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [Partition] = kppv(DataA,DataT,labelA, labelT, K,ListeClass)

[Na,~] = size(DataA);
[Nt,~] = size(DataT);

Nt_test = Nt/1000; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1); %contient les classes associées m

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    % A COMPLÉTER
    D = zeros(Na, 1); % matrice des distances
    I = ones(Na, 1);
    D = vecnorm((I * DataT(i, :) - DataA)')'; % vecnorm retourne la norme de chaque colonne, renvoie un vecteur ligne
    
    
    % On ne garde que les indices des K + proches voisins
    
    [E, indices] = sort(D); % E  est la matrice avec les distances classées par ordre croissant
    indicesK = indices(1:K); % inidces des K plus proches voisins
    
    % Comptage du nombre de voisins appartenant à chaque classe
    % A COMPLÉTER
    cpt = zeros(1, length(ListeClass));
    
    for l = [1:K]
        for j = [1:length(ListeClass)]
                
                if labelA(indicesK(l,1))== j
                    cpt(1,j) = cpt(1,j) + 1;
                end
        end
    end
            
    
    % Recherche de la classe contenant le maximum de voisins
    % A COMPLÉTER
    [max_c, indice_max] = max(cpt);
   
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    % A COMPLÉTER
    
    if length(indice_max) == 1
        classe = ListeClass(indice_max);
    else
        classe = labelA(indicesK(1));
    end
    
    
        
        
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    % A COMPLÉTER
   Partition(i,1) = classe;
   
    
end

% matrice de confusion
C = zeros(length(ListeClass),length(ListeClass));
for k = [1:Nt_test]
    C(labelT(i) + 1, Partition(i) + 1) = C(labelT(i) + 1, Partition(i) + 1) + 1;
end

taux_erreur = (Nt_test - sum(diag(C))) / Nt_test

% les taux d'erreur sont à 1 pour k = 0 et k = 10
