function result insertRectangle( ii, rectangle_coordinates )

result = zeros( size(ii,1),size(i,1),3);

for i = 1:3
  result(:,:,i) = ii;
end

x = rectangle_coordinates(1);
y = rectangle_coordinates(2);
width = rectangle_coordinates(3);
height = rectangle_coordinates(4);

% Colour green in rgb is 50, 205, 50
% Horizontal Lines
for i = x:(x + width - 1)
  % Top line R G B
  result(i,y,:) = [50,205,50];
  % Bottom line R G B
  result(i,(y-height+1),:) = [50,205,50];
end
% Vertical Lines

for j = y:(y - height + 1)
  % Left line
  result(x,j,:) = [50,205,50];
  % Right line
  result((x + width - 1),j,:) = [50,205,50];
end

result = uint8(result);

end