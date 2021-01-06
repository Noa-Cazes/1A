function [X,Y] = vectorisation(I)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[nb_lignes,nb_col] = size(I);
img_gauche = I(:,1:nb_col-1);
img_droite = I(:,2:nb_col);
X = img_gauche(:);
Y = img_droite(:);

end

