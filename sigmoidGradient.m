function s = sigmoidGradient(z)
s = zeros(size(z));
s = sigmoid(z) .* (1 - sigmoid(z));
end












