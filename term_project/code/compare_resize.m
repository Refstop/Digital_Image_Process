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

compareResize(baby, baby_small, "baby");
compareResize(bird, bird_small, "bird");
compareResize(butterfly, butterfly_small, "butterfly");
compareResize(head, head_small, "head");
compareResize(woman, woman_small, "woman");

function compareResize(original, resized, filename)
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
end