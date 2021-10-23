clc;clear all;close all;
img = imread('data/pattern.tif');
kernel = [1 2 1; 2 4 2; 1 2 1];
f_map = myimfilter(img, kernel);

subplot(1,3,1);
imshow(img);
title('Original Image');
subplot(1,3,2);
imshow(f_map);
title('Filtered Image');