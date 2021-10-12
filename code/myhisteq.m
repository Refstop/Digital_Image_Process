function [img, S, hist, equalized_hist, pr_rk, ps_sk] = myhisteq(image, intensity_level)
[row column]= size(image);
hist = zeros(1,intensity_level);
for i = 1:row
    for j = 1:column
        hist(image(i,j)) = hist(image(i,j)) + 1;
    end
end
pr_rk = hist/(row*column);
for i = 1:intensity_level
    S(i) = round(((intensity_level-1)/(row*column))*sum(hist(1:i)));
end
equalized_hist = zeros(1,length(S));
for i = 1:length(S)
    if S(i) ~= 0
        equalized_hist(S(i)) = equalized_hist(S(i)) + pr_rk(i);
    end
end
ps_sk = equalized_hist;
equalized_hist = ps_sk*(row*column);
img = uint8(S(image));
end