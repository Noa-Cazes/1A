function [bimsg] = demsg2bimsg(demsg, M)
%BIMSG2DEMSG Convertit un message binaire en message décimal
%   demsg : Message  convertir
%   M : Nombre de symboles
    bimsg = flip(de2bi(demsg'), 2)';
    bimsg = bimsg(:)';
end

