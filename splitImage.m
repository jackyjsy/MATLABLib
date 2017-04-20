function out=splitImage(img,split)
%split is 1x2 matrix
%1st element is y split number
%2nd element is x split number
[m,n,~]=size(img);
x_split_n=split(1);
y_split_n=split(2);
split_yn=ceil(m/y_split_n);
split_xn=ceil(n/x_split_n);
out={};
for i=1:y_split_n
    for j=1:x_split_n
        ys=split_yn*(i-1)+1;
        yl=split_yn*i;
        xs=split_xn*(j-1)+1;
        xl=split_xn*j;
        
        if (yl>m)
            yl=m;
        end
        if (xl>n)
            xl=n;
        end 
        out{i,j}=img(ys:yl,xs:xl,:);
    end
end