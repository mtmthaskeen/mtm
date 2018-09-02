function [E grad] = meansq_error_fxn(parameters,nn_hiddenlayer_size,nn_starting_input_layer_size,nn_output_size...
                   ,X,y,lambda,rows);
                   
Theta1 = reshape(parameters(1:nn_hiddenlayer_size * (nn_starting_input_layer_size + 1)), ...
                 nn_hiddenlayer_size, (nn_starting_input_layer_size + 1));

Theta2 = reshape(parameters((1 + (nn_hiddenlayer_size * (nn_starting_input_layer_size + 1))):end), ...
                 nn_output_size, (nn_hiddenlayer_size + 1));                     
                   
                   
                   
                   
theta1_gradient=zeros(size(Theta1));
theta2_gradient=zeros(size(Theta2));
X=[ones(rows,1) X];
E=0;
for i = 1:rows
X_i = X(i,:);
	h_of_Xi = sigmoid( [1 sigmoid(X_i * Theta1')] * Theta2' );
	
	% if y = 5 then y_i = [0 0 0 0 1 0 0 0 0 0]
	y_i = zeros(1,nn_output_size);
	y_i(y(i)) = 1;
	E = E + sum( -1 * y_i .* log(h_of_Xi) - (1 - y_i) .* log(1 - h_of_Xi) );
end;

E=1/rows*E;
% Add regularization term

E = E + (lambda / (2 * rows) * (sum(sumsqr(Theta1(:,2:nn_starting_input_layer_size+1)))...
      + sum(sumsqr(Theta2(:,2:nn_hiddenlayer_size+1)))));
delta_a=zeros(size(Theta1));
delta_b=zeros(size(Theta2));
for t=1:rows
a_1=X(t,:);
z_2=a_1*Theta1';
a_2=[1 sigmoid(z_2)];
z_3=a_2*Theta2';
a_3=sigmoid(z_3);
y_i=zeros(1,nn_output_size);
y_i(y(t))=1;

delta3=a_3-y_i;
delta2=delta3*Theta2.*sigmoidGradient([1 z_2]);

delta_a=delta_a+delta2(2:end)' *a_1;
delta_b=delta_b+delta3'*a_2;
end
theta1_gradient=delta_a/rows;
theta2_gradient=delta_b/rows;
%applying the regularization
theta1_gradient(:,2:nn_starting_input_layer_size+1)=...
theta1_gradient(:,2:nn_starting_input_layer_size+1)+lambda/rows*Theta1(:,2:nn_starting_input_layer_size+1);
theta2_gradient(:,2:nn_hiddenlayer_size+1)=...
theta2_gradient(:,2:nn_hiddenlayer_size+1)+lambda/rows*Theta2(:,2:nn_hiddenlayer_size+1);

grad=[theta1_gradient(:); theta2_gradient(:)];                    
end                    