%%*************************************************************************
% Inputs:
% NE = number of negative examples
% PE = number of positive examples
% FP = number of false positive examples
% Output:
% Saves a file called "images.mat" that contains X_tr, X_cv, Y_tr and Y_cv
%%*************************************************************************
function read_images(NE, PE, FP)

delete('images.mat');
%NE = 3000;    %Negative example
%PE = 2000;    %Positive example
Images = zeros( NE + PE, 36*18 );
Y = zeros( NE + PE, 1 );

%% Reading negative examples
for i = 1:NE
    filename = ...
    strcat('../DaimlerBenchmark/Data/TrainingData/NonPedestriansSmall/18x36/neg',num2str(i-1,'%05.5i'),'.jpg');
    A = imread(filename);
    %[Gmag,Gdir] = imgradient(A);
    Gmag = A;
    Gmag = normal(Gmag);
    Images(i,:) = reshape(Gmag,[1,size(Gmag,1)*size(Gmag,2)]);
    Y(i,1) = 0; % 0 stands for empty
end

%% Reading positive examples
for i = 1:PE
    filename = strcat('../DaimlerBenchmark/Data/TrainingData/Pedestrians/18x36/pos',num2str(i-1,'%05.5i'),'.pgm');
    A = imread(filename);
    %[Gmag,Gdir] = imgradient(A);
    Gmag = A;
    Gmag = normal(Gmag);
    %imshow(Gmag);
    %pause();
    Images(i + NE,:) = reshape(Gmag,[1,size(Gmag,1)*size(Gmag,2)]);
    Y(i + NE,1) = 1; % 1 stands for person
end

%% Reading false positives
for i = 1:FP
    filename = strcat('../DaimlerBenchmark/Data/TrainingData/FalsePositives/neg',num2str(i-1,'%05.5i'),'.jpg');
    A = imread(filename);
    %[Gmag,Gdir] = imgradient(A);
    Gmag = A;
    Gmag = normal(Gmag);
    %imshow(Gmag);
    %pause();
    Images(i + NE + PE,:) = reshape(Gmag,[1,size(Gmag,1)*size(Gmag,2)]);
    Y(i + NE + PE,1) = 0; % 1 stands for person
end

%% Randomly arrange images
r = randperm(NE + PE + FP);
Images = Images(r,:);
Y = Y(r,:);


%% Division training set and cross validation set
tr = round(0.9 * ( NE + PE + FP));
X_tr = Images(1:tr,:);
Y_tr = Y(1:tr,:);
X_cv = Images((tr + 1):end,:);
Y_cv = Y((tr + 1):end,:);


save('images.mat', 'X_tr', 'X_cv', 'Y_tr', 'Y_cv');
clear X_tr;
clear X_cv;
clear Y_tr;
clear Y_cv;
clear Y;
clear Images;

end
