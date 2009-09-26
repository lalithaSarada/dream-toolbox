function Tau = boxcoxtransform(Y,Lambda)

if any(Y<0)
    error('Box-Cox transformation can only be performed on positive data.')
end

if numel(Lambda)~=1
    error('Lambda must be scalar.')
end




if Lambda==0
    Tau = log(Y);
else
    Tau = ((Y.^Lambda)-1)/Lambda;
end