function label = mybwlabel(image, adjacency)
label = double(padarray(image, [1 1], 0, 'both'));
if adjacency == 4
    filter = [0 1 0;
        1 0 0;
        0 0 0];
elseif adjacency == 8
    filter = [1 1 0;
        1 0 0;
        1 0 0];
end
[row column] = size(label);
l=1;
for j = 1:row-2
    for i = 1:column-2
        if label(i+1, j+1) == 1
            conv = label(i:i+2, j:j+2).*filter;
            if sum(conv, 'all') == 0
                label(i+1,j+1) = l;
                l=l+1;
            else
                conv_nonzero = conv(conv~=0);
                num = min(conv_nonzero);
                label(i+1,j+1) = num;
            end
        end
    end
end
label = label(2:row-1, 2:column-1);
end