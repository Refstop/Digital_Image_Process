clc;clear all;close all;
img = imread('data/pattern.tif');
noise_img = imnoise(img, 'salt & pepper');
med_img = medfilt2(noise_img);
subplot(1,3,1);
imshow(img);
title('Original Image');
subplot(1,3,2);
imshow(noise_img);
title('Noised Image');
subplot(1,3,3);
imshow(med_img);
title('Median Filtered Image');