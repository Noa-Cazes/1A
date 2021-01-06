%-------------------------------------------------------------------------%
% 1SN - TP Optimisation                                                   %
% INP Toulouse - ENSEEIHT                                                 %
%                                                                         %
% Fonction de calcul du gradient des moindres carres                      %
% de la fonction de Cobb-Douglas                                          %
%-------------------------------------------------------------------------%

function g = grad_MC_CD(beta)

    r = res_CD(beta);
    Jres = Jac_res_CD(beta);
    g = Jres'*r;
    g = 0;
    
end
