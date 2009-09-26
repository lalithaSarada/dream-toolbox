function p = bimodalmodel(par)



    Extra.Lam = eye(size(par,2));             % covariance
    Extra.mu1 = -5 * ones(1,size(par,2));     % center point of first density
    Extra.mu2 =  5 * ones(1,size(par,2));     % center point of second density
    Extra.sigma = eye(size(par,2));           % define the std of the target
    
% Forward call
p = 1/3 * mvnpdf(par,Extra.mu1,Extra.sigma) + 2/3 * mvnpdf(par,Extra.mu2,Extra.sigma);

%p = mvnpdf(x,Extra.mu,Extra.qcov); ---> (log_density): p =
%-0.5*x*Extra.invC*x';