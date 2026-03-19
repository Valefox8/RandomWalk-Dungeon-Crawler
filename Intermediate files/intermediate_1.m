% Step 1 creating a 1D walk

% Number of steps
N = 1000;

% Initialize the position vector (start at 0)
position = zeros(1, N);

% Loop to simulate the random walk
for i = 2:N
    % Generate a random step: -1 (left) or 1 (right)
    step = 2 * randi([0, 1]) - 1; % This will give -1 or 1
    position(i) = position(i-1) + step;
end

% Plotting the walk
plot(1:N, position);