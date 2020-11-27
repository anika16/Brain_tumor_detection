
clear all;
clc;
%read image
img=imread('brain1.jpg');
%segment the image using threshold
bw=im2bw(img,0.7);
label=bwlabel(bw);
%measure solidity and area
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);
%morphological erosion with a structuring element of shape square
se=strel('square',5);
%morphological dilation
tumor=imdilate(tumor,se);
figure(2);
subplot(1,3,1);
imshow(img,[]);
title('Brain');

subplot(1,3,2);
%display grayscale image
imshow(tumor,[]);
title('Tumor Alone');
%search only for object boudaries nohole
[B,L]=bwboundaries(tumor,'noholes');
subplot(1,3,3);
imshow(img,[]);
hold on
%for displaying th boudaries of the tumor 'y' is for yellow linewidth for
%thickness 1.45
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.45);
    
    
    
end

title('Detected Tumor');
hold off;