function img = myResizeNN(image, rate)
if length(size(image)) >= 2
    [row column channel] = size(image);
else
    [row column]= size(image);
    channel = 1;
end % channel issue
resize = ceil([row column]*rate);
for i = 1:resize(1)
    x = i*1/rate;
    x(x<1) = 1;
    x(x>row) = row;
    for j = 1:resize(2)
        y = j*1/rate;
        y(y<1) = 1;
        y(y>column) = column;
        img(i,j,1:channel) = image(round(x), round(y), 1:channel);
    end
end
disp('nn end');
end