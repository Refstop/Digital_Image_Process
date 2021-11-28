clc;clear all;close all;

img = imread('profile.jpg');
gray_img = rgb2gray(img);
subplot(2,4,1); imshow(img); title('Original Image');

% 1. padding parameter P, Q
[m,n] = size(gray_img);
P = 2*m; Q = 2*n;

% 2. generate padding image
padding_img = zeros(P, Q);
padding_img(1:m, 1:n) = gray_img;
subplot(2,4,2); imshow(uint8(padding_img)); title('2. Padding Image');

% 3. multiply -1^(i+j)
center_img = zeros(P, Q);
for i = 1:P
    for j = 1:Q
        center_img(i,j) = padding_img(i,j) * (-1)^(i+j);
    end
end
subplot(2,4,3); imshow(uint8(center_img)); title('3. Centered Image');

% 4. DFT
F = fft2(center_img);
subplot(2,4,4); imshow(uint8(F)); title('4. FFT result');

% 5. generate ILPF
u = 0:(P-1); u = u-P/2;
v = 0:(Q-1); v = v-Q/2;
[V, U] = meshgrid(v,u);
D = sqrt(U.^2+V.^2);
D0 = 150;
H = D<D0;
subplot(2,4,5); imshow(uint8(H), []); title('5. H matrix: ILPF(real, symmetric)');

% 6. product G = H.*F
G = H.*F;
subplot(2,4,6); imshow(uint8(G), []); title('6. Convolution result in Frequency Area');

% 7. obtatin processed img
processed_img = real(ifft2(G));
result_img = zeros(P,Q);
for i = 1:P
    for j = 1:Q
        result_img(i,j) = processed_img(i,j) * (-1)^(i+j);
    end
end
subplot(2,4,7); imshow(uint8(result_img)); title('7. Centered Image after Filtering');

% 8. final img, top left of result_img
result_img = uint8(result_img(1:m, 1:n));
subplot(2,4,8); imshow(uint8(result_img)); title('8. Final Result');

figure;
imshow(uint8(result_img)); title('8. Final Result');

