clc;clear all;close all;

img = imread('profile.jpg');

%% Extract R, G, B
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

%% Convert to H, S, I
hsi_myfunc = rgb2hsi(img);
H = hsi_myfunc(:,:,1);
S = hsi_myfunc(:,:,2);
I = hsi_myfunc(:,:,3);

figure(1);
subplot(1,3,1); imshow(uint8(H), []); title('H');
subplot(1,3,2); imshow(uint8(S), []); title('S');
subplot(1,3,3); imshow(uint8(I)); title('I');


%% Convert to H, S, V by built-in
hsi = rgb2hsv(img);
figure(2);
subplot(1,3,1); imshow(hsi(:,:,1)); title('H');
subplot(1,3,2); imshow(hsi(:,:,2)); title('S');
subplot(1,3,3); imshow(hsi(:,:,3)); title('V');