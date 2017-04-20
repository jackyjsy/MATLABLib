clear
close all

he = imread('test.jpg');
figure;imshow(he), title('original image');
[m,n,~]=size(he);

[x,y]=getpts;

mouse_color=[he(round(y),round(x),1),he(round(y),round(x),2),he(round(y),round(x),3)];

crop_x1=round(max(x-n/40,1));
crop_x2=round(min(x+n/40,n));
crop_y1=round(max(y-m/40,1));
crop_y2=round(min(y+m/40,m));

img_crop=he(crop_y1:crop_y2,crop_x1:crop_x2,:);
figure;imshow(img_crop);

cform = makecform('srgb2lab');
lab_he = applycform(img_crop,cform);

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure;imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

median_colors=zeros(nColors,3);
figure;
for k = 1:nColors
    for i=1:3
        chn = img_crop(:,:,i);
        median_colors(k,i) = median(chn(pixel_labels==k));
        
    end
end


median_colors=double([median_colors;mouse_color]);

figure;
for i=1:size(median_colors,1)
    subplot(1,size(median_colors,1),i);
    imshow(cat(3,ones(100,100)*median_colors(i,1),ones(100,100)...
        *median_colors(i,2),ones(100,100)*median_colors(i,3))/255);
    title(strcat('Color ',num2str(i)));
end

%result=


for k = 1:nColors
    color = img_crop;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end


for fig_i=1:nColors
    figure;imshow(segmented_images{fig_i}), title('objects in cluster '+num2str(fig_i));
end

