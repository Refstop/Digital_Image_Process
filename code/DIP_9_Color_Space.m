clc;clear all;close all;

img = imread('profile.jpg');

%% Lab 7-1 Example: RGB space
figure(1); subplot(2,3,2); imshow(img); title('RGB image');
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
subplot(2,3,4); imshow(R); title('Red plane');
subplot(2,3,5); imshow(G); title('Green plane');
subplot(2,3,6); imshow(B); title('Blue plane');

%% Lab 7-2 Example: HSI space
hsi = rgb2hsv(img);
figure(2); subplot(2,3,2); imshow(img); title('RGB image');
H = hsi(:,:,1);
S = hsi(:,:,2);
I = hsi(:,:,3);
subplot(2,3,4); imshow(H); title('Hue');
subplot(2,3,5); imshow(S); title('Saturation');
subplot(2,3,6); imshow(I); title('Intensity');

%% Lab 7-3 MATLAB: RGB to HSI Color Model(Space)
[hsi_myfunc, H, S, I] = rgb2hsi(img);
% H = hsi_myfunc(:,:,1);
% S = hsi_myfunc(:,:,2);
% I = hsi_myfunc(:,:,3);

figure(3); subplot(2,3,2); imshow(img); title('RGB image');
subplot(2,3,4); imshow(uint8(H), []); title('H');
subplot(2,3,5); imshow(uint8(S), []); title('S');
subplot(2,3,6); imshow(uint8(I)); title('I');