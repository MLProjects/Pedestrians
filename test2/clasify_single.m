function result = clasify_single( filename )
%CLASIFY_SINGLE Predict weather input image represents a loaded [2]/
%unloaded [1] truck
%   result = clasify_single( filename ) outputs 1 or 2
% filename ex: 'truck.jpg' The imput image must be 200 by 113 px

% trained weights of a neural network (Theta1, Theta2)
load('train.mat');

% Defining image of 37 by 66 px
Image = zeros( 1, 37*66);

% Load image and resize image
A = imread(filename);
B = rgb2gray(A);
C = imresize(B(3:113,1:198),1/3);
Image(1,:) = reshape(C,[1,size(C,1)*size(C,2)]);

% Predict 
pred = predict(Theta1, Theta2, Image );

result = pred(1);

end