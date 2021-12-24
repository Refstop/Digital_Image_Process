clc;clear all;close all;
baby_small = imread('[크기변환]baby.png');
bird_small = imread('[크기변환]bird.png');
butterfly_small = imread('[크기변환]butterfly.png');
head_small = imread('[크기변환]head.png');
woman_small = imread('[크기변환]woman.png');
baby = imread('baby.png');
bird = imread('bird.png');
butterfly = imread('butterfly.png');
head = imread('head.png');
woman = imread('woman.png');

[mynn_psnr(1), mybil_psnr(1), mybic_psnr(1), nn_psnr(1), bil_psnr(1), bic_psnr(1)] = compareResize(baby, baby_small, "baby");
[mynn_psnr(2), mybil_psnr(2), mybic_psnr(2), nn_psnr(2), bil_psnr(2), bic_psnr(2)] = compareResize(bird, bird_small, "bird");
[mynn_psnr(3), mybil_psnr(3), mybic_psnr(3), nn_psnr(3), bil_psnr(3), bic_psnr(3)] = compareResize(butterfly, butterfly_small, "butterfly");
[mynn_psnr(4), mybil_psnr(4), mybic_psnr(4), nn_psnr(4), bil_psnr(4), bic_psnr(4)] = compareResize(head, head_small, "head");
[mynn_psnr(5), mybil_psnr(5), mybic_psnr(5), nn_psnr(5), bil_psnr(5), bic_psnr(5)] = compareResize(woman, woman_small, "woman");
fprintf("mynn 평균값: %.6f\n", mean(mynn_psnr));
fprintf("mybil 평균값: %.6f\n", mean(mybil_psnr));
fprintf("mybic 평균값: %.6f\n", mean(mybic_psnr));
fprintf("nn 평균값: %.6f\n", mean(nn_psnr));
fprintf("bil 평균값: %.6f\n", mean(bil_psnr));
fprintf("bic 평균값: %.6f\n", mean(bic_psnr));

function [mynn_psnr, mybil_psnr, mybic_psnr, nn_psnr, bil_psnr, bic_psnr] = compareResize(original, resized, filename)
%% myResize
nn_output = myResizeNN(resized, 4);
bil_output = myResizeBil(resized, 4);
bic_output = myResizeBic(resized, 4);

fig1 = figure;
subplot(221); imshow(original); title("Original", 'FontSize', 20);
subplot(222); imshow(nn_output); title("myNN, " + string(psnr(original, nn_output)), 'FontSize', 20);
subplot(223); imshow(bil_output); title("myBil, " + string(psnr(original, bil_output)), 'FontSize', 20);
subplot(224); imshow(bic_output); title("myBic, " + string(psnr(original, bic_output)), 'FontSize', 20);
saveas(fig1, filename+"_myResize.png");


%% bulitin
nn_output_b = imresize(resized, 4, 'nearest');
bil_output_b = imresize(resized, 4, 'bilinear');
bic_output_b = imresize(resized, 4, 'bicubic');

fig2 = figure;
subplot(221); imshow(original); title("Original", 'FontSize', 20);
subplot(222); imshow(nn_output_b); title("NN, " + string(psnr(original, nn_output_b)), 'FontSize', 20);
subplot(223); imshow(bil_output_b); title("Bil, " + string(psnr(original, bil_output_b)), 'FontSize', 20);
subplot(224); imshow(bic_output_b); title("Bic, " + string(psnr(original, bic_output_b)), 'FontSize', 20);
saveas(fig2, filename+"_builtin.png");
mynn_psnr = psnr(original, nn_output);
mybil_psnr = psnr(original, bil_output);
mybic_psnr = psnr(original, bic_output);
nn_psnr = psnr(original, nn_output_b);
bil_psnr = psnr(original, bil_output_b);
bic_psnr = psnr(original, bic_output_b);
end