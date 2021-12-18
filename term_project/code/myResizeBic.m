function [output] = myResizeBic(input, rate)
    originSize = size(input);
    newSize = ceil([originSize(1) originSize(2)]*rate);
    newSizeX = newSize(1);
    newSizeY = newSize(2);
    channel = originSize(3);
    output = zeros(newSizeX, newSizeY, channel);
    ratiox = originSize(1) / newSizeX;
    ratioy = originSize(2) / newSizeY;

    for y = 0:newSizeY - 1
        yMappingToOrigin = y * ratioy;
        yMappingToOriginFloor = floor(yMappingToOrigin);
        yMappingToOriginFrac = yMappingToOrigin - yMappingToOriginFloor;
        for x = 0:newSizeX - 1
            xMappingToOrigin = x * ratiox;
            xMappingToOriginFloor = floor(xMappingToOrigin);
            xMappingToOriginFrac = xMappingToOrigin - xMappingToOriginFloor;
            ndata = zeros(4, 4, channel);
            for ndatay = -1:2
                clip_y = yMappingToOriginFloor + ndatay;
                clip_y(clip_y < 0) = 0; clip_y(clip_y > originSize(2)-1) = originSize(2)-1;
                for ndatax = -1:2
                    clip_x = xMappingToOriginFloor + ndatax;
                    clip_x(clip_x < 0) = 0; clip_x(clip_x > originSize(1)-1) = originSize(1)-1;
                    ndata(ndatax+2, ndatay+2, :) = input(clip_x+1, clip_y+1, :);
                end
            end
            output(x + 1, y + 1,:) = BicubicPolate(ndata, xMappingToOriginFrac, yMappingToOriginFrac);
        end
    end
    output = uint8(output);
end

function [output] = BicubicPolate(ndata, fracx, fracy)
    x1 = CubicPolate( ndata(1,1,:), ndata(2,1,:), ndata(3,1,:), ndata(4,1,:), fracx );
    x2 = CubicPolate( ndata(1,2,:), ndata(2,2,:), ndata(3,2,:), ndata(4,2,:), fracx );
    x3 = CubicPolate( ndata(1,3,:), ndata(2,3,:), ndata(3,3,:), ndata(4,3,:), fracx );
    x4 = CubicPolate( ndata(1,4,:), ndata(2,4,:), ndata(3,4,:), ndata(4,4,:), fracx );

    output = CubicPolate(x1, x2, x3, x4, fracy);
end

function [output] = CubicPolate(v0, v1, v2, v3, fracy)
    A = 0.5 .* (v3 - v0) + 1.5 .* (v1 - v2);
    B = 0.5 .* (v0 + v2) - v1 - A;
    C = (v2-v0)/2;
    D = v1;
    output =  D + fracy * (C + fracy * (B + fracy * A));
end