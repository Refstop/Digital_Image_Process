clc; clear all; close all;
img = imread('data/dark.tif');
[eq_img, S, hist, eq_hist, pr_rk, ps_sk] = myhisteq(img, 256);
builtin_eq_img = histeq(img, 256);
figure(1);
subplot(1,3,1);
imshow(img);
title('Original Image');
subplot(1,3,2);
imshow(eq_img);
title('Equalized Image');
subplot(1,3,3);
imshow(builtin_eq_img);
title('Built-in Equalized Image');
figure(2); subplot(1,2,1);
bar(hist);
xlabel('r_k'); ylabel('n_k');
title('Original Histogram');
subplot(1,2,2);
bar(eq_hist);
xlabel('r_k'); ylabel('n_k');
title('Equalized Histogram');
figure(3);
bar(S);
xlabel('r_k'); ylabel('s_k');
title('s=T(r)');
figure(4); subplot(1,2,1);
bar(pr_rk);
xlabel('r_k'); ylabel('p_{r}(r_k)');
title('Normalized Original Histogram');
subplot(1,2,2);
bar(ps_sk);
xlabel('r_k'); ylabel('p_{s}(s_k)');
title('Normalized Equalized Histogram');