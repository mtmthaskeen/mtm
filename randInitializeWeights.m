function weights = randInitializeWeights(Layer_in, Layer_out)

weights = zeros(Layer_out, 1 + Layer_in);

epsilon_init = 0.12;
weights = rand(Layer_out, 1 + Layer_in) * 2 * epsilon_init - epsilon_init;
end
