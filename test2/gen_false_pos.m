function output = gen_false_pos(inp, N, Im_max)
count = 1;
tot_count = inp;
enough = false;
while( (count < 600) && not(enough) )
    %% Read image
    
    B = imread(strcat('../DaimlerBenchmark/Data/TrainingData/NonPedestrians/neg',num2str(count-1,'%05.5i'),'.pgm'));
    fprintf('\nScanning image: %f\n', count - 1);
    %A = rgb2gray(B);
    A = B;
    C = B;
    %% Load NN
    load('train.mat');
    
    %% Loops
    jump = 10;
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
    loc_enough = false;
    loc_count = 1;
    s_jump = jump;
    for l = 10:length(scales)
        s_jump = floor(jump * scale_X(1,l) / dim(1,2));
        bound = [size(A,2) - scale_X(1,l) + 1, size(A,1) - scale_Y(1,l) + 1];
        x_coor = 1:s_jump:floor(bound(1,1)/s_jump)*s_jump;
        y_coor = 1:s_jump:floor(bound(1,2)/s_jump)*s_jump;
        
        for i = 1:length(x_coor)
            for j = 1:length(y_coor)
                if(not(enough) && not(loc_enough))
                    J = imresize(A(y_coor(1,j):(y_coor(1,j)+scale_Y(1,l)-1),x_coor(1,i):(x_coor(1,i)+scale_X(1,l)-1)), scales(l), 'nearest');
                    [Gmag,Gdir] = imgradient(J);
                    Gmag = uint8((Gmag - min(min(Gmag))*ones(size(Gmag)))*(255/(max(max(Gmag)) - min(min(Gmag)))));
                    %imshow(Gmag);
                    %pause();
                    Image = reshape(Gmag,[1,size(Gmag,1)*size(Gmag,2)]);
                    %imshow(J);
                    if( predict(Theta1, Theta2, double(Image), 0.5) == 1 )
                        imwrite(J, strcat('../DaimlerBenchmark/Data/TrainingData/FalsePositives/neg',num2str(tot_count,'%05.5i'),'.jpg'),'jpg');
                         tot_count = tot_count + 1;
                         loc_count = loc_count + 1;
                         if(tot_count > N)
                             enough = true;
                         end
                         if(loc_count > Im_max)
                            loc_enough = true; 
                         end
                  
                        
                    else
                        %C = insertShape(B, 'Rectangle', [x_coor(1,i) y_coor(1,j) scale_X(1,l) scale_Y(1,l)], 'LineWidth', 2);
                    end
                   % imshow(C);
                    
                    C = B;
                end
            end
        end
        
    end
    
    %% Scann person
    %predict(Theta1, Theta2, X_cv, Threshold(i));
    
    %% Add rectangle
    %%A = insertShape(A, 'Rectangle', [20 40 100 60], 'LineWidth', 2);
    
    %% Display final result
    %%imshow(A);
    count = count + 1;
    fprintf('\nSaved cases: %f\n', tot_count);
    
end
output = tot_count - 1;
clear Image;
clear A;
clear B;
clear C;
clear J;
end