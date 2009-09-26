clear 
close all
clc

load('dream_hymod.mat')






numTime = datenum([yearNumber(objDomainIx),monthNumber(objDomainIx),dayNumber(objDomainIx)]);
xTicksAt = min(numTime):200:max(numTime);


figure
plot(numTime,discharge(objDomainIx))
set(gca,'xlim',[min(numTime),max(numTime)],...
    'xtick',xTicksAt,...
    'xticklabel',datestr(xTicksAt,1))
