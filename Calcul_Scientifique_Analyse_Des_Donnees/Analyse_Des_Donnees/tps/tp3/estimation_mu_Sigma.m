function [mu, Sigma] = estimation_mu_Sigma(X)
S = size(X);
n = S(1); % Nombre de lignes

mu = (1/n) * X'* ones(n,1);

moy = mean(X);
X_c = X - moy;
Sigma = (1/n) * (X_c') * X_c;
end

