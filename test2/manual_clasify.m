clear 
load('train.mat');
delete('empty/*.jpg');
delete('full/*.jpg');

N = 500;
counter_full = 1551;
counter_empty = 547;

for i = 1:N
    
   source = strcat('numeric/',num2str(i-1,'%05.5i'),'.jpg');
   full = strcat('full/',num2str(i-1,'%05.5i'),'.jpg');
   empty = strcat('empty/',num2str(i-1,'%05.5i'),'.jpg');
   A = imread(source);
   imshow(A);
   prompt = 'full or empty ? (f/e)';
   pred = input(prompt,'s');
   
   
   if(pred == 'f')
       copyfile( source, full );
   else
       copyfile( source, empty );
   end
   
end


pause;