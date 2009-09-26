

load('bound_211.mat')
load('stor_211.mat')

TimeTab = bound_211(:,1);
PrecTab = bound_211(:,2);
PEvapTab = bound_211(:,3);

StartTime = TimeTab(1);
Time(1) = StartTime;
[m,n] = size(TimeTab);
EndTime = TimeTab(m);
for k=1:m-1
    dt(k) = TimeTab(k+1)-TimeTab(k);
end
dt(m) = dt(k);

k = 1;
Storage(1) = 0.128;

storageMeasured = stor_211(:,2);

clear bound_211

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
buildconstantsmap