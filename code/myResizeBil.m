function img = myResizeBil(image, rate)
if length(size(image)) >= 2
    [row column channel] = size(image);
else
    [row column]= size(image);
    channel = 1;
end
resize = ceil([row column]*rate);
image(row+1, 1:column, 1:channel) = zeros(1, column, channel);
image(1:row+1, column+1, 1:channel) = zeros(row+1, 1, channel);
for i = 1:resize(1)
    x = i*1/rate;
    x(x<1) = 1;
    x(x>row) = row;
    l = floor(x);
    a = x - l;
    for j = 1:resize(2)
        y = j*1/rate;
        y(y<1) = 1;
        y(y>column) = column;
        k = floor(y);
        b = y - k;
        img(i,j,1:channel) = (1-a)*(1-b)*image(l,k,1:channel)+a*(1-b)*image(l+1,k,1:channel)+(1-a)*b*image(l,k+1,1:channel)+a*b*image(l+1,k+1,1:channel);
    end
end
end