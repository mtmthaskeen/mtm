function number_plate =prediction(X,Theta1,Theta2)
                     % LOADING DATA
%loading dataset ie. csv file having digits per pixel data

%pkg load image
rows= size(X,1);
columns= size(X,2);
%loading weights
parameters= [Theta1(:) ; Theta2(:)];

                     
         %setting up the initial size variables of the network 
nn_hiddenlayer_size=25;
nn_starting_input_layer_size=columns;  % per pixel information
nn_output_size=12;
 

for i=1:rows
 
pred = predict(Theta1, Theta2, X(i,:));
 
%fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100); 
%fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
number_plate(i)=pred;
%mat = reshape(X(i,:),38,20);      % reshaping the matrix
%imshow(mat); 
end  
%number_plate
end                                                    