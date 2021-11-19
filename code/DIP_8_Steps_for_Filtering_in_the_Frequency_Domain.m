clc;clear all;close all;

img = imread('profile.jpg');
img = rgb2gray(img);

% 1. padding parameter P, Q
[m,n] = size(img);
P = 2*m;
Q = 2*n;

% 2. generate padding image
padding_img = zeros(P, Q);
padding_img(1:m, 1:n) = img;

% 3. multiply -1^(i+j)
center_img = zeros(P, Q);
for i = 1:P
    for j = 1:Q
        center_img(i,j) = padding_img(i,j) * (-1)^(i+j);
    end
end

% 4. DFT
F = fft2(center_img);

% 5. generate ILPF
u = 0:(P-1); u = u-P/2;
v = 0:(Q-1); v = v-Q/2;
[V, U] = meshgrid(v,u);
D = sqrt(U.^2+V.^2);
D0 = 150;
H = D<D0;

% 6. product G = H.*F
G = H.*F;

% 7. obtatin processed img
processed_img = real(ifft2(G));
result_img = zeros(P,Q);
for i = 1:P
    for j = 1:Q
        result_img(i,j) = processed_img(i,j) * (-1)^(i+j);
    end
end

% 8. final img, top left of result_img
result_img = uint8(result_img(1:m, 1:n));

figure;
imshow(result_img);

