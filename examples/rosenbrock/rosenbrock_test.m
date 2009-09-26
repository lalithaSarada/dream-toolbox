clear
close all
clc

X1 = -10:.05:10;
X2 = X1;

n1 = numel(X1);
n2 = numel(X2);

y=repmat(NaN,[n1,n2]);

for i1 = 1:n1
    for i2 = 1:n2
        y(i2,i1)=hyperbanana([],[X1(i1),X2(i2)]);
    end
end
        
figure
imagesc(X1,X2,y)
set(gca,'ydir','normal','clim',[0,100])
axis image
colorbar
