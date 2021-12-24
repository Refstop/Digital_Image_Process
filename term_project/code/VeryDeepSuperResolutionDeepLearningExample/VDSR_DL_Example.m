clc;clear all;close all;

%% Perform Single Image Super-Resolution Using VDSR Network
net_weight = 'trainedVDSR-Epoch-100-ScaleFactors-234.mat';

%% Create Sample Low-Resolution Image
baby_small = imread('[크기변환]baby.png'); baby = imread('baby.png');
bird_small = imread('[크기변환]bird.png'); bird = imread('bird.png');
butterfly_small = imread('[크기변환]butterfly.png'); butterfly = imread('butterfly.png');
head_small = imread('[크기변환]head.png'); head = imread('head.png');
woman_small = imread('[크기변환]woman.png'); woman = imread('woman.png');

[bicubicPSNR(1), vdsrPSNR(1)] = VDSR_prediction(baby, baby_small,net_weight, 'baby');
[bicubicPSNR(2), vdsrPSNR(2)] = VDSR_prediction(bird, bird_small, net_weight, 'bird');
[bicubicPSNR(3), vdsrPSNR(3)] = VDSR_prediction(butterfly, butterfly_small, net_weight, 'butterfly');
[bicubicPSNR(4), vdsrPSNR(4)] = VDSR_prediction(head, head_small, net_weight, 'head');
[bicubicPSNR(5), vdsrPSNR(5)] = VDSR_prediction(woman, woman_small, net_weight, 'woman');
fprintf("bicubicPSNR 평균값: %.6f\n", mean(bicubicPSNR));
fprintf("vdsrPSNR 평균값: %.6f\n", mean(vdsrPSNR));


function [bicubicPSNR, vdsrPSNR] = VDSR_prediction(original_img, resized_img, weight_mat, filename)
load(weight_mat);

Ireference_uint8 = original_img;
Ireference = im2double(Ireference_uint8);

Ilowres = resized_img;

%% Improve Image Resolution Using Bicubic Interpolation
Ibicubic = imresize(Ilowres, 4,'bicubic');

%% Improve Image Resolution Using Pretrained VDSR Network
Iycbcr = rgb2ycbcr(Ilowres);
Iy = Iycbcr(:,:,1);
Icb = Iycbcr(:,:,2);
Icr = Iycbcr(:,:,3);

Iy_bicubic = imresize(Iy,4,'bicubic');
Icb_bicubic = imresize(Icb,4,'bicubic');
Icr_bicubic = imresize(Icr,4,'bicubic');

Iresidual = activations(net,Iy_bicubic,41);
Iresidual = double(Iresidual);

Isr = double(Iy_bicubic) + 0.41*Iresidual;

Ivdsr = ycbcr2rgb(cat(3,Isr,Icb_bicubic,Icr_bicubic));
fig1 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(231); imshow(Ireference_uint8); title('High-Resolution Reference Image', 'FontSize', 15)
subplot(232); imshow(Ibicubic); title('High-Resolution Image Obtained Using Bicubic Interpolation', 'FontSize', 15)
subplot(233); imshow(Ivdsr); title('High-Resolution Image Obtained Using VDSR', 'FontSize', 15)
subplot(234); imshow(Iresidual,[]); title('Residual Image from VDSR', 'FontSize', 15)

%% Visual and Quantitative Comparison
bicubicPSNR = psnr(Ibicubic,Ireference_uint8);
vdsrPSNR = psnr(Ivdsr,Ireference_uint8);
roi = [31 96 187 161];
subplot(235); imshow(imcrop(Ibicubic,roi)); title('HR Results Using Bicubic Interpolation, ' + string(bicubicPSNR), 'FontSize', 15)
subplot(236); imshow(imcrop(Ivdsr,roi)); title('HR Results Using VDSR, ' + string(vdsrPSNR), 'FontSize', 15);
saveas(fig1, filename+"_result.png");
end