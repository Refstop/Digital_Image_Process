clc;clear all;close all;
img = imread('data/pattern.tif');
kernel = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
f_map = myimfilter(img, kernel);

figure;
imshow(f_map);