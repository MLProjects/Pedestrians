%% Read image
i = 500;
B = imread(strcat('../DaimlerBenchmark/Data/TestData/00m_25s_704914u.pgm'));
%A = rgb2gray(B);
A = B;
C = B;
%% Load NN
load('train.mat');

%% Loops
jump = 4;
dim = [36, 18];
scale_X = dim(1,2):jump:floor((size(A,2)-dim(1,2))/jump)*jump;
scale_Y = dim(1,1):2*jump:floor((size(A,1)-dim(1,1))/(2*jump))*2*jump;
length_shortest = min(length(scale_X),length(scale_Y));
scale_min = zeros(1,length_shortest);
if(length(scale_X) < length(scale_Y) )
    scale_min = scale_X;
else
    scale_min = scale_Y;
end
scales = scale_min(1,1) * ones(size(scale_min)) ./ scale_min;

bounds = [size(A,1) - dim(1,1) + 1, size(A,2) - dim(1,2) + 1];

%% Loops
s_jump = jump;
bug_count = 0;
true_count = 0;
for l = 17:length(scales)
    s_jump = floor(jump * scale_X(1,l) / dim(1,2));
    bound = [size(A,2) - scale_X(1,l) + 1, size(A,1) - scale_Y(1,l) + 1];
    x_coor = 1:s_jump:floor(bound(1,1)/s_jump)*s_jump;
    y_coor = 1:s_jump:floor(bound(1,2)/s_jump)*s_jump;
    
    for i = 1:length(x_coor)
        for j = 1:length(y_coor)
            bug_count = bug_count + 1;
            J = imresize(A(y_coor(1,j):(y_coor(1,j)+scale_Y(1,l)-1),x_coor(1,i):(x_coor(1,i)+scale_X(1,l)-1)), scales(l), 'nearest');
            [Gmag,Gdir] = imgradient(J);
            Gmag = uint8((Gmag - min(min(Gmag))*ones(size(Gmag)))*(255/(max(max(Gmag)) - min(min(Gmag)))));
            %imshow(Gmag);
            %pause();
            Image = reshape(Gmag,[1,size(Gmag,1)*size(Gmag,2)]);
            %imshow(J);
            if( predict(Theta1, Theta2, double(Image), 0.8) == 1 )
                true_count = true_count + 1;
                B = insertRectangle(B,[x_coor(1,i),y_coor(1,j),scale_X(1,l),scale_Y(1,l)],[255,255,10],0.5,3,true);
                %B = insertShape(B, 'FilledRectangle', [x_coor(1,i) y_coor(1,j) scale_X(1,l) scale_Y(1,l)], 'LineWidth', 2);
                %imshow(Gmag);
                %pause();
                imshow(B);
                refresh();
            else
                C = insertRectangle(B,[x_coor(1,i),y_coor(1,j),scale_X(1,l),scale_Y(1,l)],[255,255,10],0.9,3,false);
                %C = insertShape(B, 'Rectangle', [x_coor(1,i) y_coor(1,j) scale_X(1,l) scale_Y(1,l)], 'LineWidth', 2);
            end

            
            C = B;
        end
    end
    
end

%% Scann person
%predict(Theta1, Theta2, X_cv, Threshold(i));

%% Add rectangle
A = insertShape(A, 'Rectangle', [20 40 100 60], 'LineWidth', 2);

%% Display final result
imshow(A);