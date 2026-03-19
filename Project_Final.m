% This project has the user input the amounts of steps they like and either
% uses a random walk (automated) or allows the user to create their own levels (manual). 
% Once the level has been generated, the player has free rein to walk
% around the map (using terminal input for wasd) in an attempt to find the goal (which is the end of the
% walk), whilst walking the player has a 20% chance to encounter an enemy
% which will enter a text based combat system where the player can heal or
% attack. The game ends when the player eventually dies to an enemy and 
% their score is saved.

% Updates from last iteration include updated visuals and making it so the
% steps inpuuted must be an integer and must not be negative

% Clearing any previous games
clf;
clc;
clearvars;


% Getting input for how many steps the walk/levels will go for
while true
    steps = input("How many steps would you like to take? ",'s');
    num = str2double(steps); % Converts to a integer
    
    % Ensures the input was positive and numerical value
    if ~isnan(num) && num > 0 % nan = not a number
        steps = num;
        break;
    else
        disp("Invalid Input. Enter a positive integer.")
    end
end

% Makes sure the input isnt a decimal
while mod(steps,1) ~= 0
    disp("It needs to be an integer.")
    steps = input("How many steps? ");
end

% asks about whether the levels will be generated automaticallty or
% manually
stepType = input("manual or automated step taking? ",'s');

% Ensures you have entered either manual or automated
while ~strcmp(stepType, 'manual') && ~strcmp(stepType, 'automated')
    disp('You need to enter either "manual" or "automated"')
    stepType = input("manual or automated: ", 's');
end

% initial map variables
canvas_size = 201;
offset = floor(canvas_size / 2);
floor_number = 1;
image = zeros(canvas_size, canvas_size);

% initial combat variables 
enemy_defeated = 0;
damage_bonuses = 0;
health_bonuses = 0;

% Uses readScores function to read highest score
scoreFile = 'scores.txt';
highestScore = readScores(scoreFile);


while true 

    % Variables that get reloaded when each floor is completed
    score = ((floor_number - 1) * 20) + (enemy_defeated * 10); %Generates current score
    clf; % Clears graph
    pos = [0,0]; %Resets position
    x_vals = pos(1); % resets the x and u positions of the map
    y_vals = pos(2); 
    image = zeros(canvas_size, canvas_size); % Resets array

    % Player initial health/damage
    player_damage_reference = 2; 
    player_health_reference = 10;

    % Loading player health/damage after floor 1
    player_health = player_health_reference + health_bonuses;
    player_damage = player_damage_reference + damage_bonuses;

    % Enemy chance
    encounter_chance = 0.2;

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
    
                case 3 % down
                    if pos(2) > -100 
                    pos(2) = pos(2) - 1;
                    end
    
                case 4 % left
                    if pos(1) > -100
                    pos(1) = pos(1) - 1;
                    end
            end
        
        % Saving coordinates for array
        x_vals = [x_vals, pos(1)];
        y_vals = [y_vals, pos(2)];
    
        % Drawing map
        rectangle('position', [(0 - .5), (0 - .5), 1, 1],'FaceColor','g')
        rectangle('position', [(pos(1) - .5), (pos(2) - .5), 1, 1],'FaceColor','g')
        pause(0.05);  
    
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
    
                case "s" % down
                    if pos(2) > -100 
                    pos(2) = pos(2) - 1;
                    end
    
                case "a" % left
                    if pos(1) > -100
                    pos(1) = pos(1) - 1;
                    end
            end
        
        % Saving coordinates for array
        x_vals = [x_vals, pos(1)];
        y_vals = [y_vals, pos(2)];
    
        % Drawing map
        scatter(pos(1), pos(2), 250, 'black.')
        pause(0.05);  
        end
    end
        
    % Setting positions on the array using previous x/y values so the player can move around
    for i = 1:length(x_vals)
        grid_x = x_vals(i) + offset;  
        grid_y = y_vals(i) + offset;  
        image((grid_y + 1), (grid_x + 1)) = 1;
    end
    
    % Loading scores and level counts
    grid on
    %plot(x_vals, y_vals, 'b-', 'LineWidth', 2);
    title(sprintf('Level: %d      Score: %d     Highscore: %d', floor_number, score, highestScore), ...
      'FontSize', 14, 'FontWeight', 'bold', 'Color', 'red');

    
    % Generating goal
    goal_pos = [x_vals(end), y_vals(end)];
    goal_grid = goal_pos + offset;
    image(goal_grid(1), goal_grid(2)) = 3;
    
    fprintf("\nLevel %d: Try to find the end of the path!\nUse 'w', 'a', 's', 'd' to move. You can only walk on the path.\n", floor_number);
    
    % Generating player
    player_pos = [0, 0];
    player_grid = player_pos + offset;
    image(player_grid(1), player_grid(2)) = 2;
  
    player_marker = plot(player_pos(1), player_pos(2), 'bo', ...
        'MarkerSize', 12, 'LineWidth', 2);
    
    % Game Loop
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
    
                case "s" % down
                    next_pos(2) = next_pos(2) - 1;
    
                case "a" % left
                    next_pos(1) = next_pos(1) - 1;
            otherwise
                fprintf("Invalid input. Use w/a/s/d.\n");
                continue;
         end
    
        % Saving player position
        grid_x = next_pos(1) + offset + 1;
        grid_y = next_pos(2) + offset + 1;
    
        % Ensuring new position is inside the map
        if grid_x < 1 || grid_x > canvas_size || grid_y < 1 || grid_y > canvas_size
            fprintf("Out of bounds!\n");
            continue;
        end
    
        % Ensures the new position is walkable (Marked 1 or 2 on array)
        if image(grid_y, grid_x) ~= 1 && image(grid_y, grid_x) ~= 2
            fprintf("You can't move there — it's off the path!\n");
            continue;
        end
    
        player_pos = next_pos;
    
        % Update player position marker
        set(player_marker, 'XData', player_pos(1), 'YData', player_pos(2));
        drawnow;

        % Enemy encounter loop 
        if rand() < encounter_chance
            pause(1)
            disp("An enemy appears!")

            % Calls combat system function
            combat_system(floor_number, player_health, player_damage, health_bonuses, damage_bonuses, score);
            
            enemy_defeated = enemy_defeated + 1;

            % Generates player bonus
            bonus = randi([1 2]);
            switch bonus
                case 1
                    disp("You got a health bonus!")
                    health_bonuses = health_bonuses + 1;
                case 2 
                    disp("you got a damage bonus!")
                    damage_bonuses = damage_bonuses + 1;
            end
                
                % Updates player stats
                player_health = player_health_reference + health_bonuses;
                player_damage = player_damage_reference + damage_bonuses;
        
            score = ((floor_number - 1) * 20) + (enemy_defeated * 10);
        
        end
    
        % End of level condition
        if all(player_pos == goal_pos)
            fprintf("\n YOU FOUND THE GOAL AT (%d, %d)!\n", goal_pos(1), goal_pos(2));
            floor_number = floor_number + 1;
            pause(1);
            break;
        end
    end
end