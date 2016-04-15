%% Initialize values

Positive_Ex = 2000;
Negative_Ex = 2000;
False_Positives = 2000;
Inc = 1000;

%read_images(Negative_Ex, Positive_Ex, False_Positives);
%ex4;
Inc = gen_false_pos(False_Positives + 1, False_Positives + 1000, 10 ) - False_Positives;

i = 1;
while( (i < 10) && ( Inc > 10 ) )
   Positive_Ex = Positive_Ex + round(Inc / 2);
   False_Positives = False_Positives + Inc;
   read_images(Negative_Ex, Positive_Ex, False_Positives);
   ex4;
   Inc = gen_false_pos(False_Positives + 1, False_Positives + 1000, 10 ) - False_Positives;
   i = i + 1;
    
end
