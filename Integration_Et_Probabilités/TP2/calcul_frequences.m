function frequences = calcul_frequences(texte,alphabet)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
frequences = zeros(128,1);
    for i = 1:128
        frequences(i,1) = (length(find(texte == alphabet(i))))/length(texte);
    end
end

