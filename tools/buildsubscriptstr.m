function str=build_subscript_str(sizeVec,Ind)

str='';

tmpInd = Ind;
for k=numel(sizeVec):-1:1
    subtr = prod(sizeVec(k-1:-1:1));
    p=0;
    while tmpInd>subtr
        p=p+1;
        tmpInd=tmpInd-subtr;
    end
    str=[',',num2str(p+1),str];
end
str=str(2:end);

