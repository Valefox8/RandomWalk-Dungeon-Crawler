% Step 7, adding user input and manual movement

% Clearing any previous games
clc;
clearvars;

% Player input for steps and steptype
steps = input("How many steps would you like to take? ");
stepType = input("manual or automated step taking? ",'s');

% Initial variables
canvas_size = 201;
offset = floor(canvas_size / 2);
pos = [0,0];
x_vals = pos(1);
y_vals = pos(2);

% initial Array
image = ones(canvas_size, canvas_size);

% loop for random walk generating map automated
if stepType == "automated" 
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

    % Drawing map
    rectangle('position', [(pos(1) - .5), (pos(2) - .5), 1, 1])

    %pause(0.05);  
    end
end

% Loop for generating map manually
if stepType == "manual" 
    hold on 
    for step = 1:steps
    dir = input("Enter direction based of wasd keys: ", 's');
        switch dir
            case "w" % up
                if pos(2) < 100 
                pos(2) = pos(2) + 1;
                end 

            case "d" %right
                if pos(1) < 100
                pos(1) = pos(1) + 1;
                end

            case "s" % south
                if pos(2) > -100 
                pos(2) = pos(2) - 1;
                end

            case "a" % west
                if pos(1) > -100
                pos(1) = pos(1) - 1;
                end
        end
    
        % Saving coordinates for array
    x_vals = [x_vals, pos(1)];
    y_vals = [y_vals, pos(2)];

    % Drawing map
    scatter(pos(1), pos(2), 250, 'black.')
    
    %pause(0.05);  
    end
end
    
% Setting the values of x/y so the array can be drawn
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