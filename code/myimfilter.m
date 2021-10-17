function f_map = myimfilter(image, kernel)
[m,n] = size(image);
[a,b] = size(kernel);
pad_img = zeros(m+floor(a/2)*2,n+floor(b/2)*2);
pad_img(floor(a/2)+1:m+floor(a/2),floor(b/2)+1:n+floor(b/2)) = image;

f_map = uint8(zeros(m,n));
for i = floor(a/2)+1:m+floor(a/2)
    for j = floor(b/2)+1:n+floor(b/2)
        corr = pad_img(i-floor(a/2):i+floor(a/2),j-floor(b/2):j+floor(b/2)).*kernel;
        kernel_sum = sum(kernel, 'all');
        f_map(i-floor(a/2), j-floor(b/2)) = sum(corr, 'all')/kernel_sum;
    end
end
end