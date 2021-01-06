function  [Beta_chapeau]= MCO(x,y)

% Détermination de la matrice A
A = [ x.*x, x.*y y.*y, x, y, ones(200,1); 1, 0, 1, 0, 0, 0]
B = zeros(200, 1);
B(201, 1) = [1];
%Beta_chapeau = A\B
Beta_chapeau = pinv(A)*B;
end

