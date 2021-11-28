function hsi = rgb2hsi(rgb)
R = rgb(:,:,1);
G = rgb(:,:,2);
B = rgb(:,:,3);
a = double(0.5*((R-G)+(R-B)));
b = sqrt(double((R-G).^2 + (R-B).*(G-B)));
value = a./b;
value(isnan(value)) = 0;
theta = acos(value);
H = theta.*(B<=G) + (2*pi-theta).*(B>G);

I = (R+G+B)/3;
num = double(min(min(R,G), B));
den = double(R+G+B);
S = 1 - 3.*num./den;
hsi = cat(3, H, S, I);
end