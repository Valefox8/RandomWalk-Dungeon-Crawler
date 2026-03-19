% Step 9, adds player, player movement, player barriers and a win condtion

% Clearing any previous games
clf;
clc;
clearvars;

% Player input for steps
steps = input("How many steps would you like to take? ");

% Makes sure the input isnt a decimal
while mod(steps,1) ~= 0
    disp("It needs to be an integer.")
    steps = input("How many steps? ");
end

% Player input for step type
stepType = input("manual or automated step taking? ",'s');

% Ensures you have entered either manual or automated
while ~strcmp(stepType, 'manual') && ~strcmp(stepType, 'automated')
    disp('You need to enter either "manual" or "automated"')
    stepType = input("manual or automated: ", 's');
end

% Initial map variables
canvas_size = 201;
offset = floor(canvas_size / 2);
pos = [0,0];
x_vals = pos(1);
y_vals = pos(2); 

% Initial array
image = zeros(canvas_size, canvas_size);

% loop for random walk generating map automated
hold on
if stepType == "automated" 
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

    % Drawing array
    rectangle('position', [(pos(1) - .5), (pos(2) - .5), 1, 1])

    %pause(0.05);  
    end
end

% Loop for generating map manually
if stepType == "manual" 
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
    
        % Saving coords for array 
    x_vals = [x_vals, pos(1)];
    y_vals = [y_vals, pos(2)];

    % Drawing array
    scatter(pos(1), pos(2), 250, 'black.')

    %pause(0.05);  
    end
end
    
% Setting positions on the array using previous x/y values so the player can move around    
for i = 1:length(x_vals)
    grid_x = x_vals(i) + offset;  
    grid_y = y_vals(i) + offset;  
    
    image((grid_y + 1), (grid_x + 1)) = 1;
end


% Plots all points together
grid on
plot(x_vals, y_vals, 'b-', 'LineWidth', 2);


% Generating goal
goal_pos = pos;
goal_grid = goal_pos + offset;
image(goal_grid(1), goal_grid(2)) = 3;

% Generating player
player_pos = [0, 0];
player_grid = player_pos + offset;
image(player_grid(1), player_grid(2)) = 2;

fprintf("\nStage 2: Try to find the end of the path!\nUse 'w', 'a', 's', 'd' to move. You can only walk on the path.\n");

player_marker = plot(player_pos(1), player_pos(2), 'bo', ...
    'MarkerSize', 12, 'LineWidth', 2);

% Game loop
while true

    % Getting user input for player
    hold on
    move = input("Your move (w/a/s/d): ", 's');
    next_pos = player_pos;
    switch move
            case "w" % up
                next_pos(2) = next_pos(2) + 1;

            case "d" %right
               next_pos(1) = next_pos(1) + 1;

            case "s" % south
                next_pos(2) = next_pos(2) - 1;

            case "a" % west
                next_pos(1) = next_pos(1) - 1;
        otherwise
            fprintf("Invalid input. Use w/a/s/d.\n");
            continue;
     end
    
     % Saving player position
    grid_x = next_pos(1) + offset + 1;
    grid_y = next_pos(2) + offset + 1;
    
    % Ensuring new position is inside the lap
    if grid_x < 1 || grid_x > canvas_size || grid_y < 1 || grid_y > canvas_size
        fprintf("Out of bounds!\n");
        continue;
    end

     % Ensures the new position is walkable (Marked 1 on array)   
    if image(grid_y, grid_x) ~= 1
        fprintf("You can't move there — it's off the path!\n");
        continue;
    end

    player_pos = next_pos;

    % Update player position marker
    set(player_marker, 'XData', player_pos(1), 'YData', player_pos(2));
    drawnow;

    % End of level condition
    if all(player_pos == goal_pos)
        fprintf("\n🎉 YOU FOUND THE GOAL at (%d, %d)!\n", goal_pos(1), goal_pos(2));
        % Reveal the goal
        plot(goal_pos(1), goal_pos(2), 'rx', 'MarkerSize', 14, 'LineWidth', 2);
        break;
    end
end

% Draw array and plot
figure;
imshow(image)
