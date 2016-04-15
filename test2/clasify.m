clear 
load('train.mat');
delete('empty/*.jpg');
delete('full/*.jpg');
F = 1000;
N = 4000;
Images = zeros( N, 37*66);
% Load images
for i = F:(F + N)
    filename = strcat('numeric/',num2str(i-1,'%05.5i'),'.jpg');
    A = imread(filename);
    B = rgb2gray(A);
    C = imresize(B(3:113,1:198),1/3);
    Images(i,:) = reshape(C,[1,size(C,1)*size(C,2)]);
end

pred = predict(Theta1, Theta2, Images );

for i = F:(F + N)
    
   source = strcat('numeric/',num2str(i-1,'%05.5i'),'.jpg');
   full = strcat('full/',num2str(i-1,'%05.5i'),'.jpg');
   empty = strcat('empty/',num2str(i-1,'%05.5i'),'.jpg');
   if(pred(i) == 2)
       copyfile( source, full );
   else
       copyfile( source, empty );
   end
   
end


pause;