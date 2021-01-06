function [r,a,b] = calcul_parametres(X,Y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
moyx = mean(X);
moyy = mean(Y);
nb = size(X,1);
varx = sum(X.^2) / nb - moyx*moyx;
vary = sum(Y.^2) / nb - moyy*moyy;
sigmax = sqrt(varx);
sigmay = sqrt(vary);
covxy = sum(X.*Y) / nb - moyx*moyy;
r = covxy / (sigmax*sigmay);
a = covxy / varx;
b = (covxy/(varx))*(-moyx) + moyy;
end

