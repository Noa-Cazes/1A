function [time] = generateTimeVector(nbBits, Ns, Te, M)
%GENERATETIMEVECTOR Génère le vecteur indiquant le temps
    time = 0:Te:nbBits/log2(M)*Ns*Te - Te;
end

