function coeff_compression_avant_decorrelation = coeff_compression_image(histogramme,dico)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
nb_bits_sans_compression = 8 * sum(histogramme);
nb_bits_avec_compression = 0;
for i = 1:length(histogramme)
    nb_bits_avec_compression = nb_bits_avec_compression + histogramme(i) * length(dico{i,2});
end
coeff_compression_avant_decorrelation = nb_bits_sans_compression / nb_bits_avec_compression; 
end

