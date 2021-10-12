clc; clear all; close all;
img = imread('rice.png');
rice_BW = imbinarize(img);

% source data
BW = logical([
1 1 1 0 0 0 0 0;
1 1 1 0 1 1 0 0;
1 1 1 0 1 1 0 0;
1 1 1 0 0 0 1 0;
1 1 1 0 0 0 1 0;
1 1 1 0 0 0 1 0;
1 1 1 0 0 1 1 0;
1 1 1 0 0 0 0 0 ]);
L = mybwlabel(BW, 8);
rice_L = mybwlabel(rice_BW, 8);
L_builtin = bwlabel(BW, 8);
rice_L_builtin = bwlabel(rice_BW, 8);

figure(1);
subplot(1,3,1); imagesc(BW); colormap jet; colorbar;
% imshow(BW);
title('Original','fontsize',16);
subplot(1,3,2); imagesc(L); colormap jet; colorbar;
% imshow(L);
title('Labeled','fontsize',16);
subplot(1,3,3); imagesc(L_builtin); colormap jet; colorbar;
% imshow(L_builtin);
title('Labeled-builtin','fontsize',16);

figure(2);
subplot(1,3,1); imagesc(rice_BW); colormap jet; colorbar;
% imshow(rice_BW); 
title('Original','fontsize',16);
subplot(1,3,2); imagesc(rice_L); colormap jet; colorbar;
% imshow(rice_L);
title('Labeled','fontsize',16);
subplot(1,3,3); imagesc(rice_L_builtin); colormap jet; colorbar;
% imshow(rice_L_builtin);
title('Labeled-builtin','fontsize',16);
