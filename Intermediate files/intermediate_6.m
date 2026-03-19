% Step 6, putting the random walk onto the array and displaying it

% Initial variables
steps = 100;
canvas_size = 201;
offset = floor(canvas_size / 2);
pos = [0,0];
x_vals = pos(1);
y_vals = pos(2); 

% Initial array
image = ones(canvas_size, canvas_size);

 % loop for random walk generating map 
hold on 
for step = 1:steps
    dir = randi([1, 4]);
    switch dir
        case 1 % up
            if pos(2) < 100 
            pos(2) = pos(2) + 1;
            end 

        case 2 %right
            if pos(1) < 100
            pos(1) = pos(1) + 1;
            end

        case 3 % south
            if pos(2) > -100 
            pos(2) = pos(2) - 1;
            end

        case 4 % west
            if pos(1) > -100
            pos(1) = pos(1) - 1;
            end
    end

    % Saving coordinates for array
    x_vals = [x_vals, pos(1)];
    y_vals = [y_vals, pos(2)];

    % Plotting map
    plot(pos(1), pos(2), 'ko'); 
    %pause(0.05);  
    
end

% Setting positions on the array using previous x/y values
for i = 1:length(x_vals)
    grid_x = x_vals(i) + offset;  
    grid_y = y_vals(i) + offset;  
    
    image(grid_y, grid_x) = 0;
end

% Plots all points together
grid on
plot(x_vals, y_vals, 'b-', 'LineWidth', 2);

% Displays array and plot
figure;
imshow(image)
