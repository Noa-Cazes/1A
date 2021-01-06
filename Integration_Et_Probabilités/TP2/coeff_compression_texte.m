function coeff_compression = coeff_compression_texte(texte,texte_encode)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
coeff_compression = (length(texte) * 8) / length(texte_encode);
end

