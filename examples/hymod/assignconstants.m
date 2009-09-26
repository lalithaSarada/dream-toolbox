 

load leafriver.mat

outflow = [];


% calibrate on data from 28-Jul-1952 through 30-Sep-1962:
startObjDomainIx = find(dayNumber==1 & monthNumber==10 & yearNumber==1952);
endObjDomainIx = find(dayNumber==30 & monthNumber==9 & yearNumber==1962);
objDomainIx = [startObjDomainIx:endObjDomainIx];


tStart = find(dayNumber==28 & monthNumber==7 & yearNumber==1952);
tEnd = endObjDomainIx;

% initialize time variable:
t = tStart;

% initialize factor to convert mm\cdotday^{-1} into m^3\cdotday^{-1}; i.e. 
% the watershed area has been incorporated in this factor:
convFactor = 22.5;

buildconstantsmap


% unitStr=['dailyDischarge    : [m^3\cdotday^{-1}]',char(10),...
%          'dailyPotEvapTrans : [mm\cdotday^{-1}]',char(10),...         
%          'dailyPrecip       : [mm\cdotday^{-1}]',char(10),...
%          'dayNumber         : [-]',char(10),...
%          'monthNumber       : [-]',char(10),...
%          'yearNumber        : [-]']
