clear
close all
img=imread('3.tif');

%%%%%%%%%%%%%%%
img=double(img);
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);

[m,n,chns]=size(img);

u=log(g./(r+1e-6));
v=log(g./(b+1e-6));
y=sqrt(r.^2+g.^2+b.^2);


eps=0.025;
nbins=257;
limit=round((nbins-1)/2);
M=zeros(nbins,nbins);
for i=1:m
    for j=1:n
        M_x=round(u(i,j)/(eps));
        M_y=round(v(i,j)/(eps));
        if M_x>limit
            M_x=limit;
        end
        if M_x<-limit
            M_x=-limit;
        end
        if M_y>limit
            M_y=limit;
        end
        if M_y<-limit
            M_y=-limit;
        end
        M(M_x+limit+1,M_y+limit+1)=M(M_x+limit+1,M_y+limit+1)+y(i,j);
    end
end
M=M/sum(M(:));
M_mod=uint8(mapminmax(M,0,255));
%imagesc(M)
figure;imagesc(M_mod)
axis('square')
%colormap('copper')
%caxis([0,5*mean(M(:))])











