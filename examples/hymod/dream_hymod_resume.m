clear
close all
clc

load('dream-resume.mat')
dreamPar.startFromUniform = false;
dreamPar.nModelEvalsMax = 1e7


[evalResults,critGelRub,sequences,dreamPar] = dream(dreamPar);
