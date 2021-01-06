function [demsg] = bimsg2demsg(bimsg, M)
%BIMSG2DEMSG Convertit un message binaire en message décimal
%   bimsg : Message  convertir
%   M : Nombre de symboles
    demsg = bi2de(reshape(bimsg, log2(M), length(bimsg)/log2(M))');
end

