clear all;
close all;
clc;
addpath('utils');

%% CONSTANTES

Eb_N0 = 0;
nbBits = 120;
M = 4;
spacing = 2;
fp = 2000; 
Fe = 10000;
Rs = 1000;
Ts = 1/Rs;
Te = 1/Fe;
Ns = floor(Ts/Te) + 1;
time = generateTimeVector(nbBits, Ns, Te, M);
alpha = 0.35;
h = rcosdesign(alpha, 4 * floor(log2(M)), Ns, 'normal');
t0 = 1;

%% GENERATION

binMsg = generateBinaryMsg(nbBits, 0);
mapping = generateComplexMapping(M, spacing, 0);
symbolesG = generateSymbols(binMsg, mapping, 0);
dirac = toDirac(symbolesG, Ns, 0);
signalBDB = shaping(dirac, h, 0);

%% TRANSPOSITION

signalFP = frequencyTranspose(signalBDB, fp, time, 0);

%% PERIODIGRAMME

perio(signalFP, 'QPSK'); 

%% CANAL

signalC = addNoise(signalFP, Eb_N0, Ns, M, 0 - 1 * ~(Eb_N0 > 0));

%% RETOUR EN BANDE DE BASE

signalR = downConversion(signalC, fp, Fe, time, 0);

%% DEMODULATION

signalF = shaping(signalR, h, 0);
signalE = sampling(signalF, Ns, t0, 0);
symbolesD = decision(signalE, M, spacing, 0);
msgR = demapping(symbolesD, mapping, 0);

%% TEB

TES = 1 - sum(symbolesG == symbolesD) / length(symbolesG)
TEB = 1 - sum(msgR == binMsg) / nbBits

 %% CONSTELLATION
    constellation(mapping, signalE, 'QPSK'); 