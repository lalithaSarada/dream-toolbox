% Misha Velthuis 2009

% Cfract is the output. This can be directly compared (by SCEM) with the Cfract observervations 
% of Tonneijck (see Cfract_dat_G7.xls) because the modeloutput is interpolated to the 
% right depths.

function [Cfract]=Bioturb_Velthuis_104_SCEM(pars);

%% input 
%parameters 
% NB1: 'pars' is the input of SCEM
% NB2: I included my suggestions for the test-ranges for each parameter 

Cinput=pars(1);         % 0.0001-0.01
CoefCoef1=pars(2);      % 0.00005-0.05
CoefCoef2=pars(3);      % 0.003-0.05
width1=pars(4);         % 0.1-3000 
width2=pars(5);         % 0.1-3000            CHANGE: 0.1-5000
vertpos2=pars(6);       % 0-2
DecDec=pars(7);         % 0.0001-5            CHANGE: 0.0001-8
extracarbon=pars(8);    % 0-10                CHANGE: -10-10

% Cinput=0.0001%pars(1);          % 0.0001-0.01
% CoefCoef1=0.00005%pars(2);      % 0.00005-0.05
% CoefCoef2=0.00005%(3);          % 0.003-0.05
% width1=3000%pars(4);            % 0.1-3000
% width2=3000%pars(5);            % 0.1-3000      CHANGE: 0.1-5000
% vertpos2=2%pars(6);             % 0-2
% DecDec=0.0001%pars(7);          % 0.0001-5      CHANGE: 0.0001-8
% extracarbon=-3%pars(8);         % 0-10          CHANGE: -10-10 
     

    persistent indat;
    if isempty(indat);
    indat = read_bioturb_xls('1a_paleopar_fauna_A_G7_3.xls');
    end;




%% Initialisation (constants and variables)

% Initialisation constants
Root_shoot=0.35; % Root_shoot * Cinput = Root_input (ratio)

% extracarbon=0; 
depth_tephra=0.2; %depth tephra deposition (m)

Depth_top_paleosol=40; % (cm) The current carbon - depth relation  of the paleosol 
% is extrapolated towards this depth. To get the initial carbon depth
% relation of the total initial soil, 30 cm pure mineral soil is added to
% this. The middle of the overprinted zone is at a depth of 80. The top of the
% overprinted zone is at a depth of 60.

carbon_stock_depth=0.3; %(optional) enter preferred depth (m) over which carbon stock is determined 

nrlayer = length(indat.Layer);
LayerDepth = diff(indat.Depth);                                     % if diff is applied on absDepth, LayerDepth would give negative values
LayerDepth = [ LayerDepth(:); LayerDepth(end) ];
m2cm = 100;
startTime=5;
stopTime=4600;
timeStep =5;
time=startTime;

% Matrix building
Cperc = NaN(nrlayer,1);
Cfract = zeros(nrlayer,1);
Mfract = NaN(nrlayer,1);
BulkDensity = NaN(nrlayer,1);
Cmass = NaN(nrlayer,1);
Mmass = NaN(nrlayer,1);
Total_mass=zeros(nrlayer,1);
Range_idx=zeros(nrlayer,1);
CFlux = zeros(nrlayer+1,1);
CFlux2 = zeros(nrlayer+1,1);
Netflux_C= zeros(nrlayer,1);
MFlux = zeros(nrlayer+1,1);
MFlux2= zeros(nrlayer+1,1);
Netflux_M= zeros(nrlayer,1);
MixCoef=zeros(nrlayer,1);
CDecay=zeros(nrlayer,1);
CDecay_constant=zeros(nrlayer,1);
Range=zeros(nrlayer,1);
Root_input=zeros(nrlayer,1);
absDepth=zeros(nrlayer,1);

%Initial values variables
IsSoil = indat.SoilIdx;
Depth = indat.Depth;
inidx = find(IsSoil);
outidx = (1 : inidx - 1);

%Cfract en Mfract paleosol (extracarbon can be negative now)
Cfract_ini1=[20.243647;19.263988;18.359402;17.234974;16.0310315;13.08549025;11.941142;...
    10.5175015;8.9110105;7.478389;5.42314775;3.8255925;3.781;2.724;0.3764865]+extracarbon; %(gC/gBulk)
Cfract_ini1(find(Cfract_ini1<0))=0;
Depth_ini1=[102;103;104;105;110;115;120;125;130;135;140;144.5;148;154;170;]; %(cm)
A=polyfit(Depth_ini1,Cfract_ini1,1);
Cfract_ini2=A(1).*([Depth_top_paleosol:5:170])+A(2);        
Cfract_ini2(Cfract_ini2<=0)=0;

Cfract(min(find(IsSoil))+ceil(depth_tephra/LayerDepth(1)):...
    min(find(IsSoil))+length(Cfract_ini2)-1+ceil(depth_tephra/LayerDepth(1)))=Cfract_ini2/100;    
Cfract(Cfract<=0)=0;

Mfract(inidx) = 1 - Cfract(inidx)*2; %(gM/gBulk)

BulkDensity=0.9247*exp((-0.05497*Cfract*100)); %(gBulk/cm^3)

Cmass(inidx) = Cfract(inidx) .* BulkDensity(inidx) .* LayerDepth(inidx) * m2cm; %(gC/cm^2)
Mmass(inidx) = Mfract(inidx) .* BulkDensity(inidx) .* LayerDepth(inidx) * m2cm; %(gM/cm^2)

Cfract(outidx) = 0;
Mfract(outidx) = 0;
BulkDensity(outidx) = 0;
Cmass(outidx) = 0;
Mmass(outidx) = 0;

fullidx = find(IsSoil);
litteridx = find( diff(IsSoil) );
    
topidx = fullidx(1:end-2);
mididx = fullidx(2:end-1);
lowidx = fullidx(3:end);
Top = fullidx(1);
Low = max(find(Cfract>0));
      
%initialisation storage
storIdx = 1;
tStor = startTime : timeStep : stopTime;

Mmtot = NaN( nrlayer, length(tStor) );
Cmtot = NaN( nrlayer, length(tStor) );
Bdtot = NaN( nrlayer, length(tStor) );
Cftot = NaN( nrlayer, length(tStor) );
Netlux_Ctot = NaN( nrlayer, length(tStor));
layerDepthtot=NaN(nrlayer,length(tStor));
absDepthtot=(NaN(nrlayer, length(tStor)));
MixCoeftot=NaN(nrlayer, length(tStor));
time_shift=NaN(1,100);
shiftidx1=0;
shiftidx2=0;
graph_idx=startTime;
split=0;


absDepth(Top:Low)=fliplr(([0:LayerDepth(Low):(Low-Top)*LayerDepth(Low)]))+0.5*LayerDepth(Low); %(m)

    warning off

%% simulation loop

while time <= stopTime & Top>500;


    %Determining the diffusion coefficient - depth relation
    Range(Top:Low)=cumsum(LayerDepth(Top:Low))-0.5.*LayerDepth(Top:Low); %(m)
    %(the range is only involved in the configuration of the coefficient(CoefCoef)that is used
    % in the configuration of the diffusion coefficient (MixCoef), and can therefore 
    % be calculated in meters without any problems)
    MixCoef(Top:Low)=CoefCoef1.*((exp(-((Range(Top:Low)).^2)*width1))-(5^-6))+...
            CoefCoef2.*((exp(-((Range(Top:Low)-vertpos2).^2)*width2))-(5^-6)); %(cm^2/yr) 
        MixCoef(find(MixCoef<0))=0; %(cm^2/yr)

    %Determining the carbon decay constant - depth relation    
    CDecay_constant(Top:Low)=DecDec*(CoefCoef1.*((exp(-((Range(Top:Low)).^2)*width1))-(5^-6))+...
        CoefCoef2.*((exp(-((Range(Top:Low)-vertpos2).^2)*width2))-(5^-6))); %(gC/(gC*yr))
    CDecay_constant(find(CDecay_constant<0))=0; %(gC/(gC*yr))
    
    %Rootinput
    Root_input(Top:Low)=((15.474332394999328*(0.0000001.^(Range(Top:Low))-10*10^-15)).*LayerDepth(Top:Low))*Root_shoot*Cinput; %(gC/(cm^2*yr)
    

    %Storing initial values of several variables
    if time==startTime
    MixCoef_zerotime(Top:Low)=MixCoef(Top:Low);
    Range_zerotime(Top:Low)=Range(Top:Low);
    Cfract_zerotime(Top:Low)=Cfract(Top:Low);
    Top0=Top;
    Low0=Low;
    end

    
    %FLUXES
    % C (Because layerdepth is calculated in meters I multiply layerdepth with 50
    % instead of 0.5 (correction to cm)).
    CFlux(Top+1:Low)=(((Cfract(Top+1:Low).*BulkDensity(Top+1:Low))-...
        (Cfract(Top:Low-1).*BulkDensity(Top:Low-1))).*MixCoef(Top:Low-1))...
        ./(50*LayerDepth(Top:Low-1)+50*LayerDepth(Top+1:Low));  
    %     (gC/gBulk)*(cm^2/yr)*(gBulk/cm^3)/(cm)=(gC/(cm2*yr))
    
    
    % De inputflux staat in de correcte eenheid
    CFlux(Top)=-Cinput; % (gC/(cm^2*yr)
    
    
    
    CFlux(Low+1)=0;
          
    %Zerocheck: if a cell is emptied at one side, and the magnitude of the flux exceeds the
    %magnitude of the state, the flux value is set to the state value. If a
    %cell is emptied at both sides, and the magnitude of the combined fluxes exceed the
    %magnitude of the state, the state value of the cell is divided over the two
    %fluxes accoriding to the ratio of the two fluxes. 
    C1idx2=find((CFlux(1:end-1)>0 & CFlux(2:end)<0)==1);
    C1idx=C1idx2.*(Cmass(C1idx2)<((-CFlux(C1idx2+1)+CFlux(C1idx2))*timeStep));
    C1idx=C1idx(find(C1idx>0));
    if sum(C1idx>0);
    CFlux2(C1idx)=CFlux(C1idx);
    CFlux(C1idx)=(Cmass(C1idx).*(CFlux(C1idx)./(CFlux(C1idx)-CFlux(C1idx+1))))/timeStep;
    CFlux(C1idx+1)=-(Cmass(C1idx).*(-CFlux(C1idx+1)./(CFlux2(C1idx)-CFlux(C1idx+1))))/timeStep;
    end

    %Only downward emtpying, input at the the top is taken into account. 
    C2idx=find((CFlux(2:end)<-Cmass(1:end))==1);
    C2idx2=C2idx(find(C2idx~=Top-1));
    if sum(C2idx2>0);
    CFlux(C2idx2+1)=-Cmass(C2idx2)/timeStep;
    end

    %only upward emptying
    C3idx=find((CFlux(1:end-1)>Cmass(1:end))==1);
    if sum(C3idx>0);
        CFlux(C3idx)=Cmass(C3idx)/timeStep;
    end
    
    
    Netflux_C(Top:Low)=(-CFlux(Top:Low)+CFlux(Top+1:Low+1)); % gC/(cm^2*yr)
    Netflux_C(Top:Low)=Netflux_C(Top:Low)+(Root_input(Top:Low));% gC/(cm^2*yr)
    
    %Carbon decay
    CDecay(Top:Low)=Cmass(Top:Low).*CDecay_constant(Top:Low); %(gC/cm^2)*((gC)/(gC*yr))=(gC/(cm^2*yr))
    if -Netflux_C(Top:Low)+CDecay(Top:Low)>Cmass(Top:Low);
        CDecay(Top:Low)=Cmass(Top:Low)-Netflux_C(Top:Low);
    end

    
    % Mineral transport 
    % Zie bijschrift berekening Cflux
    MFlux(Top+1:Low)=(((Mfract(Top+1:Low).*BulkDensity(Top+1:Low))-...
        (Mfract(Top:Low-1).*BulkDensity(Top:Low-1))).*MixCoef(Top:Low-1))...
        ./(50*LayerDepth(Top:Low-1)+50*LayerDepth(Top+1:Low)); % (cm^2/yr)*(gM/cm^3)/(cm)=(gM/(cm^2*yr))
    
    %The transport of mineral material is closed
    MFlux(Top)=0;
    MFlux(Low+1)=0;
    
    %zerofix: again: first the cells that are emptied at both sides
    M1idx2=find((MFlux(1:end-1)>0 & MFlux(2:end)<0)==1);
    M1idx=M1idx2.*(Mmass(M1idx2)<(-MFlux(M1idx2+1)+MFlux(M1idx2))*timeStep);
    M1idx=M1idx(find(M1idx>0));
    if sum(M1idx>0);
    MFlux2(M1idx)=MFlux(M1idx);
    MFlux(M1idx)=(Mmass(M1idx).*(MFlux(M1idx)./(MFlux(M1idx)-MFlux(M1idx+1))))/timeStep;
    MFlux(M1idx+1)=-(Mmass(M1idx).*(-MFlux(M1idx+1)./(MFlux2(M1idx)-MFlux(M1idx+1))))/timeStep;
    end

    % Only downward emptying
    M2idx=find((MFlux(2:end)<-Mmass(1:end))==1);
    if sum(M2idx>0);
    MFlux(M2idx+1)=-Mmass(M2idx)/timeStep;
    end
    
    M3idx=find((MFlux(1:end-1)>Mmass(1:end))==1);
    if sum(M3idx>0);
        MFlux(M3idx)=Mmass(M3idx)/timeStep;
    end
    
    Netflux_M(Top:Low)=(-MFlux(Top:Low)+MFlux(Top+1:Low+1)); % als probleem 1 is opgelost: (gM/(cm^2*yr)
    
    Cmass(Top:Low)=Cmass(Top:Low)+(Netflux_C(Top:Low)-CDecay(Top:Low))*timeStep; % (gC/cm^2)
    Mmass(Top:Low)=Mmass(Top:Low)+Netflux_M(Top:Low)*timeStep; % (gM/cm^2)

    Cfract = Cmass ./ (2*Cmass+Mmass); %gC/gBulk
    Mfract = Mmass ./ (2*Cmass+Mmass); %gM/gBulk
    
    %calculate new Bd per layer
    BulkDensity=0.9247.*exp(-0.05497*(Cfract*100));     %(gBulk/cm^3)
        
    % calculate new layer depths, as a consequence of changing Bd
    LayerDepth = ((Cmass*2+Mmass) ./ (BulkDensity)) / m2cm; % (m)
    
    % because the above relation fails for layers with Cmass = 0;
    % we include the steps below.
    zero_fix = (Cmass == 0);
    LayerDepth(zero_fix) = 0.05;
    LayerDepth(1:litteridx)=0;
     
    absDepth(Top:Low) = (sum(LayerDepth(Top:Low)) - cumsum(LayerDepth(Top:Low)))+0.5*LayerDepth(Top:Low);  %(m)
    
    %carbonstock
    carb_idx=abs((Range(Top:Low)-carbon_stock_depth));
    Carb_depth_idx2=find(carb_idx==(min(abs((Range-carbon_stock_depth)))));
    Carb_depth_idx3=Carb_depth_idx2(1);
    Carb_depth=Range(Top+Carb_depth_idx3-1)+0.5*LayerDepth(Top+Carb_depth_idx3-1);
    Carb_stock=sum(Cmass(Top:Top+Carb_depth_idx3-1));
    Carbon_stock_info=[('Carbon_stock='),num2str(Carb_stock),('g/cm2'),(' over_depth 0-'),num2str(Carb_depth),('m');];
    
    %Cellsplitting: If the top cell gets too big
    if  LayerDepth(Top) >= 0.1;
      
        rcC=(Cfract(Top)-Cfract(Top+1))/(0.5*LayerDepth(Top)+0.5*LayerDepth(Top+1));
        Cfract(Top)=((0.5*LayerDepth(Top+1)+0.25*LayerDepth(Top))*rcC)+Cfract(Top+1);
        Cfract(litteridx)=((0.5*LayerDepth(Top+1)+0.75*LayerDepth(Top))*rcC)+Cfract(Top+1);
        
        Mfract(Top)=1-Cfract(Top)*2;
        Mfract(litteridx)=1-Cfract(litteridx)*2;
                
        BulkDensity(Top)=0.9247*exp(-0.05497*Cfract(Top)*100);    
        BulkDensity(litteridx)=0.9247*exp(-0.05497*Cfract(litteridx)*100);    
        Total_mass(Top)=0.5*LayerDepth(Top)*BulkDensity(Top)*m2cm;
        Total_mass(litteridx)=0.5*LayerDepth(Top)*BulkDensity(litteridx)*m2cm;
        
        Cmass(Top)=Cfract(Top)*Total_mass(Top);
        Mmass(Top)=Mfract(Top)*Total_mass(Top);

        Cmass(litteridx)=Cfract(litteridx)*Total_mass(litteridx);
        Mmass(litteridx)=Mfract(litteridx)*Total_mass(litteridx);
               
        LayerDepth(litteridx)=0.5*LayerDepth(Top);
        LayerDepth(Top)=0.5*LayerDepth(Top);
                
    absDepth(Top:Low) = (sum(LayerDepth(Top:Low)) - cumsum(LayerDepth(Top:Low)))+0.5*LayerDepth(Top:Low);
        
        Top=Top-1;
        litteridx=litteridx-1;

    Range(Top:Low)=cumsum(LayerDepth(Top:Low))-0.5.*LayerDepth(Top:Low);%(absDepth(Top:Low)+0.5*LayerDepth(Top:Low))
    MixCoef(Top:Low)=CoefCoef1.*((exp(-((Range(Top:Low)).^2)*width1))-(5^-6))+...
            CoefCoef2.*((exp(-((Range(Top:Low)-vertpos2).^2)*width2))-(5^-6));
        MixCoef(find(MixCoef<0))=0;
        split=split+1;
    end


    %Cell splitting: a cell in the middle of the matrix gets too large.
    %Multiple splittings at once are taken into account.
    splitidx_tot=find(LayerDepth>=0.1);

    
    if  sum(splitidx_tot)>0 & splitidx_tot(end)>Low-2 & length(splitidx_tot)<200;
        for i=1:1:length(splitidx_tot);
            splitidx=splitidx_tot(i);
            

        rcC=(Cfract(splitidx-1)-Cfract(splitidx+1))/(0.5*LayerDepth(splitidx+1)+...
            LayerDepth(splitidx)+0.5*LayerDepth(splitidx-1));
        
        % cell information shifts one cell upwards
        Cfract(Top-1:splitidx-2)=Cfract(Top:splitidx-1);
        Mfract(Top-1:splitidx-2)=Mfract(Top:splitidx-1);

        Cmass(Top-1:splitidx-2)=Cmass(Top:splitidx-1);
        Mmass(Top-1:splitidx-2)=Mmass(Top:splitidx-1);

        BulkDensity(Top-1:splitidx-2)=BulkDensity(Top:splitidx-1);     
 
        Cfract(splitidx)=Cfract(splitidx+1)+...
            ((0.5*LayerDepth(splitidx-1)+0.25*LayerDepth(splitidx))*rcC);
        Cfract(splitidx-1)=Cfract(splitidx+1)+...
            ((0.5*LayerDepth(splitidx+1)+0.75*LayerDepth(splitidx))*rcC);
        
        
        Mfract(splitidx)=1-Cfract(splitidx)*2;
        Mfract(splitidx-1)=1-Cfract(splitidx-1)*2;
        
        Bulkdensity(splitidx)=0.9247*exp(-0.05497*Cfract(splitidx)*100);
        Bulkdensity(splitidx-1)=0.9247*exp(-0.05497*Cfract(splitidx)*100);
        Total_mass(splitidx)=0.5*LayerDepth(splitidx)*BulkDensity(splitidx)*m2cm;
        Total_mass(splitidx-1)=0.5*LayerDepth(splitidx)*BulkDensity(splitidx-1)*m2cm;
        
        Cmass(splitidx)=Cfract(splitidx)*Total_mass(splitidx);
        Mmass(splitidx)=Mfract(splitidx)*Total_mass(splitidx);

        Cmass(splitidx-1)=Cfract(splitidx-1)*Total_mass(splitidx-1);
        Mmass(splitidx-1)=Mfract(splitidx-1)*Total_mass(splitidx-1);
        
        LayerDepth(Top-1:splitidx-2)=LayerDepth(Top:splitidx-1);
        
        LayerDepth(splitidx-1)=0.5*LayerDepth(splitidx);
        LayerDepth(splitidx)=0.5*LayerDepth(splitidx);
                
        absDepth(Top:Low) = (sum(LayerDepth(Top:Low)) - cumsum(LayerDepth(Top:Low)))+0.5*LayerDepth(Top:Low);
        
        Top=Top-1;
        litteridx=litteridx-1;

    Range(Top:Low)=cumsum(LayerDepth(Top:Low))-0.5.*LayerDepth(Top:Low);%(absDepth(Top:Low)+0.5*LayerDepth(Top:Low))
    MixCoef(Top:Low)=CoefCoef1.*((exp(-((Range(Top:Low)).^2)*width1))-(5^-6))+...
            CoefCoef2.*((exp(-((Range(Top:Low)-vertpos2).^2)*width2))-(5^-6));
        MixCoef(find(MixCoef<0))=0;
                split=split+1;

        end
    end



time=time+timeStep;


end

    persistent xxx;
    if isempty(xxx);
    xlsread Cfract_dat_G7.xls;
    xxx=(ans(:,1)/100);
    end;

    
    idx=find(Range>0);
    Range=Range(idx);
    Cfract=Cfract(idx);
    MixCoef=MixCoef(Top:Low);
    
    LayerDepth_check=find(LayerDepth(Top:Low)<=0 | LayerDepth(Top:Low)>2);
    
    if sum(Cfract>0)>2 & isempty(LayerDepth_check);
    
    Cfract=interp1(Range,Cfract,xxx,'linear','extrap');
    Cfract(find(Cfract<0))=0;
    
    else
        
        Cfract(1:length(xxx))=0;
        Cfract=Cfract(1:length(xxx))';
    end

