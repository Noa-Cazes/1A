%-------------------------------------------------------------------------%
% 1SN - TP Optimisation                                                   %
% INP Toulouse - ENSEEIHT                                                 %
%                                                                         %
% Fonction de calcul de la Hessienne des moindres carres                  %
% de la fonction de Cobb-Douglas                                          %
%-------------------------------------------------------------------------%

function H = Hess_MC_CD(beta)

    global Ki Li
    Jres = Jac_res_CD(beta);
    r = res_CD(beta);
    H_r = zeros(2,2);
    H_r(1,1) = 0;
    H_r(1,2) = -log(Ki/li).*beta(1)*(Ki.^beta(2))*(Li.^(1-beta(2)));
    H_r(2,1) = H_r(1,2);
    H_r(2,2) = - (log(Ki/li).^2)*beta(1)*(Ki.*beta(2)).*(Li.*(1-beta(2)));
    H = Jres'*Jres + sum(r.*H_r);

end
