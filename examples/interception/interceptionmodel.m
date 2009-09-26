function S = interceptionmodel(parVec)
% Single layer interception model
% rvw: set met randvoorwaarden
% Column 1: Time [day]
% Column 2: Cumulative precipitation [mm]
% Column 3: Cumulative potential evaporation [mm]
importconstants
importparameters


for t=StartTime:dt:(EndTime)

  PEvapR = PEvapTab(k);
  PrecR = PrecTab(k);
  St = (Storage(k)/dt(k)+a*PrecR+b*c)/(1/dt(k)+b+d*PEvapR/c);

  if (St<c)
      St = (Storage(k)/dt(k)+a*PrecR)/(1/dt(k)+d*PEvapR/c);
      if St>c
          St=c;
      end
  end
    
   k = k + 1;
   Storage(k) = St;
   Time(k) = Time(k-1) + dt(k);
   Storsave(k-1) = (Storage(k)-Storage(k-1))./2+Storage(k-1);
        
end
Storsave(k) = Storsave(k-1);
S = Storsave';