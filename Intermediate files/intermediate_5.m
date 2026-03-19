% Step 5, Generates a 2D array and prints it as an image

% initial variables
steps = 100;
canvas_size = 511;
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
            if pos(2) < 255 
            pos(2) = pos(2) + 1;
            end 

        case 2 %right
            if pos(1) < 255
            pos(1) = pos(1) + 1;
            end

        case 3 % south
            if pos(2) > -255 
            pos(2) = pos(2) - 1;
            end

        case 4 % west
            if pos(1) > -255
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

% Plots all points together
grid on
plot(x_vals, y_vals, 'b-', 'LineWidth', 2);

% Displays array and plot
figure;
imshow(image)
