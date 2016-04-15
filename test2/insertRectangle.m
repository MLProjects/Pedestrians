function result = insertRectangle( ii, rectangle_coordinates,c, tr, g, full )
%INSERTRECTANGLE Insert a colored regtangle over a given input image
%   result = INSERTRECTANGLE(ii, rectangle_coordinates) returns a RGB image
% with a colour rectangle on top of it.
% ii Input Image.
% rectangle_coordinates = [ x, y, width,height ] where x, y have the reference
% zero on the upper left corner.
% c from colour = [ R, G, B ]
% tr makes reference to the rectangle transparency
% g is the rectangle line width
% full indicates if the rectangle is completely filled with colour or not

% Check if input image is B&W or RGB
if( size(ii,3) == 1)
    result = zeros( size(ii,1),size(ii,2),3);
    for i = 1:3
        result(:,:,i) = ii;
    end
else
    result = ii;
end

x = rectangle_coordinates(1);
y = rectangle_coordinates(2);
width = rectangle_coordinates(3);
height = rectangle_coordinates(4);

if( full )
    for b = 0:(height-1)
        for i = x:(x + width - 1)
            % Top line R G B
            prev = [result(y+b,i,1),result(y+b,i,2),result(y+b,i,3)];
            result(y+b,i,:) = floor(tr*c + (1 - tr)*double(prev));
            
        end
    end
    
else
    % Horizontal Lines
    for b = 0:g
        for i = x:(x + width - 1)
            % Top line R G B
            prev = [result(y+b,i,1),result(y+b,i,2),result(y+b,i,3)];
            result(y+b,i,:) = floor(tr*c + (1 - tr)*double(prev));
            % Bottom line R G B
            prev = [result((y+height-1-b),i,1),result((y+height-1-b),i,2),result((y+height-1-b),i,3)];
            result((y+height-1-b),i,:) = floor(tr*c + (1 - tr)*double(prev));
        end
    end
    % Vertical Lines
    
    for b = 0:g
        for j = (y+g+1):(y + height - 2 - g)
            % Left line
            prev = [result(j,(x+b),1),result(j,(x+b),2),result(j,(x+b),3)];
            result(j,(x+b),:) = floor(tr*c + (1 - tr)*double(prev));
            % Right line
            prev = [result(j,(x+width-1-b),1),result(j,(x+width-1-b),2),result(j,(x+width-1-b),3)];
            result(j,(x+width-1-b),:) = floor(tr*c + (1 - tr)*double(prev));
        end
    end
end
result = uint8(result);

end