clc; clear all; close all;
img = imread('data/pattern.tif');
% img = imread('rice.png');

% Near Neighbor
imgNN081 = myResizeNN(img, 0.81);
imgNN143 = myResizeNN(img, 1.43);
figure(1);
subplot(1,3,1);
imshow(img);
title('Original','fontsize',16)
subplot(1,3,2);
imshow(imgNN081);
title('0.81','fontsize',16)
subplot(1,3,3);
imshow(imgNN143);
title('1.43','fontsize',16)

% Bilinear
imgBil081 = myResizeBil(img, 0.81);
imgBil143 = myResizeBil(img, 1.43);
figure(2)
subplot(1,3,1);
imshow(img);
title('Original','fontsize',16)
subplot(1,3,2);
imshow(imgBil081);
title('0.81','fontsize',16)
subplot(1,3,3);
imshow(imgBil143);
title('1.43','fontsize',16)

figure(4)
subplot(1,2,1);
imshow(imgNN143);
title('NearNeighbor 1.43','fontsize',16)
subplot(1,2,2);
imshow(imgBil143);
title('Bilinear 1.43','fontsize',16)

% Near Neighbor_builtin
imgNN081_builtin = imresize(img, 0.81, 'nearest');
imgNN143_builtin = imresize(img, 1.43, 'nearest');
figure(5);
subplot(2,2,1);
imshow(imgNN081);
title('0.81','fontsize',16)
subplot(2,2,2);
imshow(imgNN143);
title('1.43','fontsize',16)
subplot(2,2,3);
imshow(imgNN081_builtin);
title('0.81-builtin','fontsize',16)
subplot(2,2,4);
imshow(imgNN143_builtin);
title('1.43-builtin','fontsize',16)

% Bilinear_builtin
imgBil081_builtin = imresize(img, 0.81, 'bilinear');
imgBil143_builtin = imresize(img, 1.43, 'bilinear');
figure(6);
subplot(2,2,1);
imshow(imgBil081);
title('0.81','fontsize',16)
subplot(2,2,2);
imshow(imgBil143);
title('1.43','fontsize',16)
subplot(2,2,3);
imshow(imgBil081_builtin);
title('0.81-builtin','fontsize',16)
subplot(2,2,4);
imshow(imgBil143_builtin);
title('1.43-builtin','fontsize',16)