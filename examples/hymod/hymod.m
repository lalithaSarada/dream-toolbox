function SimRR = hymod(parVec)

importconstants
importparameters 


% HYMOD PROGRAM IS SIMPLE RAINFALL RUNOFF MODEL
% START PROGRAMMING LOOP WITH DETERMINING RAINFALL - RUNOFF AMOUNTS

x_loss = 0.0;

% Initialize slow tank state
x_slow = 2.3503/(Rs*convFactor);

% Initialize state(s) of quick tank(s)
x_quick(1:3,1) = 0;



while t < tEnd+1
    
   Pval = dailyPrecip(t,1);
   PETval = dailyPotEvapTrans(t,1);
   
   % Compute excess precipitation and evaporation
   [UT1,UT2,x_loss] = excess(x_loss,cmax,bexp,Pval,PETval);
   
   % Partition UT1 and UT2 into quick and slow flow component
   UQ = fQuickFlow*UT2 + UT1; 
   US = (1-fQuickFlow)*UT2;
   
   % Route slow flow component with single linear reservoir
   inflow = US; 
   [x_slow,outflow] = linres(x_slow,inflow,outflow,Rs); 
   QS = outflow;
   
   % Route quick flow component with linear reservoirs
   inflow = UQ; 
   k = 1; 
   while k < 4
      [x_quick(k),outflow] = linres(x_quick(k),inflow,outflow,Rq); 
      inflow = outflow; 
      k = k+1;
   end
   
   % Compute total flow for timestep
   output(t,1) = (QS + outflow)*convFactor;
   t = t+1;   
end

SimRR = output;