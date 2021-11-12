clc;clear all;close all;

img = imread('profile.jpg');
img = rgb2gray(img);
F = fft2(img);
F = fftshift(F);

subplot(2,3,1); imshow(img);
title('Original Image');

%% phase
phase = angle(double(F));

subplot(2,3,2); imshow(phase);
title('Phase');

%% phase based reconstruction
phase_reconstructed = ifft2(exp(1i*phase)); % 해당 phase 만큼 이동한 값을 토대로 reconstruct

subplot(2,3,3); imshow(phase_reconstructed, []);
title('Phase based reconstruction');

%% spectrum based reconstruction
mag = abs(F);
logF = log(1+mag);
subplot(2,3,4); imshow(logF, []);
title('Spectrum based reconstruction(log)');

%% load rectangle.tif, calculate phase&mag
rect = imread('rectangle.tif');
img_new = imresize(img, [512 512], 'bicubic');
F_rect = fft2(rect);
F_new = fft2(img_new);
phase_rect = exp(1i*angle(double(F_rect)));
phase_new = exp(1i*angle(double(F_new)));
mag_rect = log(1+abs(F_rect));
mag_new =log(1+abs(F_new));

%% reconstruction by my phase + rectangle spectrum
reconstruction_1 = phase_new .* mag_rect; % 오일러 공식에 의해 exp 형태로 바꾼 후 페이즈를 더하기 때문에 각각 곱연산
result_1 = ifft2(reconstruction_1);
subplot(2,3,5); imshow(real(result_1), []);
title('Restruction by my phase+rectangle spectrum');

%% reconstruction by rectangle phase + my reconstruction
reconstruction_2 = phase_rect .* mag_new; % 오일러 공식에 의해 exp 형태로 바꾼 후 페이즈를 더하기 때문에 각각 곱연산
result_2 = ifft2(reconstruction_2);
subplot(2,3,6); imshow(real(result_2), []);
title('Restruction by rectangle phase+my spectrum');