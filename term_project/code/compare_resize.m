clc;clear all;close all;
input = imread('[크기변환]baby.png');
original = imread('baby.png');
%% myResize
nn_output = myResizeNN(input, 4);
bil_output = myResizeBil(input, 4);
bic_output = myResizeBic(input, 4);

figure(1);
subplot(221); imshow(original); title("Original");
subplot(222); imshow(nn_output); title("myNN");
subplot(223); imshow(bil_output); title("myBil");
subplot(224); imshow(bic_output); title("myBic");
truesize;

fprintf("myNN psnr: %.8f\n", psnr(original, nn_output));
fprintf("myBil psnr: %.8f\n", psnr(original, bil_output));
fprintf("myBic psnr: %.8f\n\n", psnr(original, bic_output));

%% bulitin
nn_output_b = imresize(input, 4, 'nearest');
bil_output_b = imresize(input, 4, 'bilinear');
bic_output_b = imresize(input, 4, 'bicubic');

figure(2);
subplot(221); imshow(original); title("Original");
subplot(222); imshow(nn_output_b); title("NN");
subplot(223); imshow(bil_output_b); title("Bil");
subplot(224); imshow(bic_output_b); title("Bic");
truesize;

fprintf("NN psnr: %.8f\n", psnr(original, nn_output_b));
fprintf("Bil psnr: %.8f\n", psnr(original, bil_output_b));
fprintf("Bic psnr: %.8f\n", psnr(original, bic_output_b));