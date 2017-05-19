function lm = labelLandmarks(img,isround)
[rows,cols,~]=size(img);
figure('Name','Input Landmarks');imshow(img)
[x,y]=getpts();
close('Name','Input Landmarks');
if isround==1
    x=round(x);
    y=round(y);
    x(x<1)=1;
    y(y<1)=1;
    x(x>cols)=cols;
    y(y>rows)=rows;
end
lm=[x,y];
num=(1:size(lm,1))';
figure('Name','Show Landmarks');imshow(img)
hold on

plot(lm(:,1),lm(:,2),'ro','MarkerSize',10);
text(lm(:,1),lm(:,2),num2str(num),'Color','Green')
hold off
end