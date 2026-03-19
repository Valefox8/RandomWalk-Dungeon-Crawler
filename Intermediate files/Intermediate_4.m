% Step 4, Making it so that the random walk is unable to exceed 255x255/
% giving the plot clear maxiumum dimensions

% Initialising variables
steps = 1000;
pos = [0,0];
x_vals = pos(1);
y_vals = pos(2); 

% Loop to simulate random walk
hold on 
for step = 1:steps
    dir = randi([3, 4]);
    switch dir
        case 1 % up
            if pos(2) < 255 
            pos(2) = pos(2) + 1;
            end 

        case 2 %right
            if pos(1) < 255
            pos(1) = pos(1) + 1;
            end

        case 3 % down
            if pos(2) > -255 
            pos(2) = pos(2) - 1;
            end

        case 4 % left
            if pos(1) > -255
            pos(1) = pos(1) - 1;
            end
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
