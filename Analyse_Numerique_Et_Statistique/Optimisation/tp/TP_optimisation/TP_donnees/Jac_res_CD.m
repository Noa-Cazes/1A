%-------------------------------------------------------------------------%
% 1SN - TP Optimisation                                                   %
% INP Toulouse - ENSEEIHT                                                 %
%                                                                         %
% Fonction de calcul de la Jacobienne du residu                           %
% de la fonction de Cobb-Douglas                                          %
%-------------------------------------------------------------------------%

function Jres = Jac_res_CD(beta)

    global Ki Li
    
    Jres = [-(Ki.^beta(2)).*(Li.^(1-beta(2)));-log(Ki/Li).*beta(1).*(Ki.^beta(2)).*(Li.^(1-beta(2)))];
    

end
