function N=smallLogChromaHist(img)
img=im2double(img);

[m,n,~]=size(img);
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);

u=g./(r+1e-6);
v=g./(b+1e-6);

nbins=64;
h=1/32;

u0=-1;
v0=-1;

N=zeros(nbins,nbins);

for i=1:m
    for j=1:n
        coord_u=floor(mod((u(i,j)-u0)/h,nbins));
        coord_v=floor(mod((v(i,j)-v0)/h,nbins));
        N(coord_u+1,coord_v+1)=N(coord_u+1,coord_v+1)+1;
    end
end



