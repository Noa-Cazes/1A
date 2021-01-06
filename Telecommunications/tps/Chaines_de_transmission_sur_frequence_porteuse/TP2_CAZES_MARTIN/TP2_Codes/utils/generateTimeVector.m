function [time] = generateTimeVector(nbBits, Ns, Te, M)
%GENERATETIMEVECTOR G�n�re le vecteur indiquant le temps
    time = 0:Te:nbBits/log2(M)*Ns*Te - Te;
end

