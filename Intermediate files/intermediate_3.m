% Step 3, moving to a switch case based strcuture that allows for the
% removal of diagonal movements (as only 1 direction is called each move)
% Adding progressive graphing using pause function


% Initialising variables
steps = 100;
pos = [0,0];
x_vals = pos(1);
y_vals = pos(2); 

% Loop to simulate random walk
hold on 
for step = 1:steps
    dir = randi([1, 4]);
    switch dir
        case 1 % up
            pos(2) = pos(2) + 1;
        case 2 % right
            pos(1) = pos(1) + 1;
        case 3 % down
            pos(2) = pos(2) - 1;
        case 4 % left
            pos(1) = pos(1) - 1;
    end
    
    % Saving positions to vectors for plotting
    x_vals = [x_vals, pos(1)];
    y_vals = [y_vals, pos(2)];

    % Plotting each point
    plot(pos(1), pos(2), 'ko'); 
    pause(0.05);  
    
end
grid on

% Connecting each point
plot(x_vals, y_vals, 'b-', 'LineWidth', 2);