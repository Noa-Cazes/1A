function [out] = constellation(sortieMapping, sortieEch, mod)

% En sortie du mapping
figure();
plot(real(sortieMapping), imag(sortieMapping), "r*");
axis([-1.5 1.5 -1.5 1.5]);
xlabel("a_k");
ylabel("b_k");
title("Constellation en sortie du mapping ("+ mod + ")");

% En sortie de l'échantillonneur
figure();
plot(real(sortieEch), imag(sortieEch), "r*");
axis([-1.5 1.5 -1.5 1.5]);
xlabel("a_k");
ylabel("b_k");
title("Constellation en sortie de l'échantillonneur("+ mod + ")");

end 