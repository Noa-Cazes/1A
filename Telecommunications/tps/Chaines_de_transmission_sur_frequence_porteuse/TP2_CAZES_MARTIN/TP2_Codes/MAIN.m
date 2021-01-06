clear all;
close all;
clc;
addpath('utils');

%% Partie 1

Eb_N0_dB = [0:0.5:6];

% Sans bruit
Ch4ASK(0.35, 1000, 0, {'bdb', 'fp'});

% Avec bruit
Ch4ASK(0.35, 1000, Eb_N0_dB, {'teb'});

%% Partie 2

Ch4ASK(0.5, 48000, Eb_N0_dB, {'teb'});
ChQPSK(0.5, 48000, Eb_N0_dB, {'teb'});
Ch8PSK(0.5, 48000, Eb_N0_dB, {'teb'});
Ch16QAM(0.5, 48000, Eb_N0_dB, {'teb'});