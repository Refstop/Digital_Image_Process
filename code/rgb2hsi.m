function [hsi, H, S, I] = rgb2hsi(rgb)
R = rgb(:,:,1);
G = rgb(:,:,2);
B = rgb(:,:,3);
a = double(0.5*((R-G)+(R-B)));
b = sqrt(double((R-G).^2 + (R-B).*(G-B)));
value = a./b;
value(isnan(value)) = 0;
theta = acos(value);
H = theta.*(B<=G) + (2*pi-theta).*(B>G);

S = 1 - 3./double(R+G+B).*double(min(min(R,G), B));
I = double((R+G+B)/3);
hsi = cat(3, H, S, I);
end