% Step 2, creating a 2d style walk (allowing for other
% directiions/dimensions)

% Number of steps
N = 1000;

% Initialize the position vectors 
positionX = zeros(1, N);
positionY = zeros(1, N);

% Loop to simulate the random walk
for i = 2:N
    % Generate a random direction for both X and Y axes
    stepX = 2 * randi([0, 1]) - 1; % -1 or 1
    stepY = 2 * randi([0, 1]) - 1; % -1 or 1
    
    positionX(i) = positionX(i-1) + stepX;
    positionY(i) = positionY(i-1) + stepY;
end

% Plot the 2D random walk
plot(positionX, positionY);