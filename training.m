%function training
                     % LOADING DATA
%loading dataset ie. csv file having digits per pixel data
clc;
close all;
clear all;
%pkg load image
load('imagedata.mat');
rows= size(X,1);
columns= size(X,2);
%loading weights
%load('ex4weights.mat');
%parameters= [Theta1(:) ; Theta2(:)];

                     
         %setting up the initial size variables of the network 
nn_hiddenlayer_size=25;
nn_starting_input_layer_size=columns;  % per pixel information
nn_output_size=13;

              %  initial random parameters
 
init_Theta1 = randInitializeWeights(nn_starting_input_layer_size, nn_hiddenlayer_size);
init_Theta2 = randInitializeWeights(nn_hiddenlayer_size, nn_output_size);
initial_nn_params = [init_Theta1(:) ; init_Theta2(:)];


                    %  debugging not done 
                    %  TRAINING
options=optimset('MaxIter',100);
lambda=5;                    
E= @(p) meansq_error_fxn(p,nn_hiddenlayer_size,nn_starting_input_layer_size,nn_output_size...
                   ,X,y,lambda,rows);                          
[parameters, cost] = fmincg(E, initial_nn_params, options);                          
Theta1 = reshape(parameters(1:nn_hiddenlayer_size * (nn_starting_input_layer_size + 1)), ...
                 nn_hiddenlayer_size, (nn_starting_input_layer_size + 1));

Theta2 = reshape(parameters((1 + (nn_hiddenlayer_size * (nn_starting_input_layer_size + 1))):end), ...
                 nn_output_size, (nn_hiddenlayer_size + 1));                          
             
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100); 
%fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
%mat = reshape(X,38,20);      % reshaping the matrix
%imshow(mat); 
save('weights.mat','Theta1','Theta2');
%end  
                                                    