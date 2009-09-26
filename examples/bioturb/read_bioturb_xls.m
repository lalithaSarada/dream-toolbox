function [out] = read_bioturb_xls(inputxls)
%
% [out] = read_bioturb_xls('inputxls')
%
% % e.g.
% [out] = read_bioturb_xls('1a_paleopar fauna A G7.xls')

    %% load data from 'inputxls'

    [startdata,datalbl] = xlsread( inputxls,'starting_data');
    out.Layer = startdata(:,1);	
    out.Depth =	startdata(:,2);
    out.SoilIdx = startdata(:,3);
    out.Carbonperc = startdata(:,4);	
    out.A14	= startdata(:,5);

    [fauna] = xlsread( inputxls, 'fauna_distribution' );
    out.Fauna_depth = fauna(:,1);
    out.Fauna_A = fauna(:,2);
    out.Fauna_B	= fauna(:,3);
    out.Fauna_C = fauna(:,4);
    out.MixCoef_ini = fauna(:,6)
    out.MixCoef_ini_depth= fauna(:,7)
   
    [param] = xlsread( inputxls, 'parameters' );
    out.MixingA = param(1);
    out.MixingB = param(2);
    out.MixingC = param(3);
    out.CLoss = param(4); 	
    out.C14Decay = param(5);	
    out.scaleCinput	= param(6);

    [biomass] = xlsread( inputxls, 'biomass_input' );
    out.biomTime = biomass(:,1);
    out.biomForest = biomass(:,2);
    out.biomParamo = biomass(:,3);
    
    [timing] = xlsread( inputxls, 'timing_parameters' );
    out.startTime = timing(1);
    out.stopTime = timing(2);
    out.timeStep = timing(3);
    out.storageTime = timing(4);
