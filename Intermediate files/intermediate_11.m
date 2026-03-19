%Step 11, adds combat function

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

% initial map variables
canvas_size = 201;
offset = floor(canvas_size / 2);
floor_number = 1;
enemy_defeated = 0;
score = ((floor_number - 1) * 20) + (enemy_defeated * 10);

% initial combat variables 
damage_bonuses = 0;
health_bonuses = 0;

image = zeros(canvas_size, canvas_size);


while true 
    % Variables that get reloaded when each floor is completed
    score = ((floor_number - 1) * 20) + (enemy_defeated * 10);
    clf;
    pos = [0,0];
    x_vals = pos(1);
    y_vals = pos(2); 
    image = zeros(canvas_size, canvas_size);

    % Initial player health/damage
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
        rectangle('position', [(pos(1) - .5), (pos(2) - .5), 1, 1])
        %plot(pos(1), pos(2), 'ko'); 
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
        
        x_vals = [x_vals, pos(1)];
        y_vals = [y_vals, pos(2)];
    
        scatter(pos(1), pos(2), 250, 'black.')
        %plot(pos(1), pos(2), 'ko'); 
        %pause(0.05);  
        end
    end
        
    for i = 1:length(x_vals)
        grid_x = x_vals(i) + offset;  
        grid_y = y_vals(i) + offset;  
        image((grid_y + 1), (grid_x + 1)) = 1;
    end
    
 
    grid on
    plot(x_vals, y_vals, 'b-', 'LineWidth', 2);
    title(sprintf('Level: %d      Score: %d', floor_number, score), ...
      'FontSize', 14, 'FontWeight', 'bold', 'Color', 'red');

    
    % Generate goal
    goal_pos = [x_vals(end), y_vals(end)];
    goal_grid = goal_pos + offset;
    image(goal_grid(1), goal_grid(2)) = 3;
    
    % generate player
    player_pos = [0, 0];
    player_grid = player_pos + offset;
    image(player_grid(1), player_grid(2)) = 2;
    
    fprintf("\nLevel %d: Try to find the end of the path!\nUse 'w', 'a', 's', 'd' to move. You can only walk on the path.\n", floor_number);
    
    % player plot
    player_marker = plot(player_pos(1), player_pos(2), 'bo', ...
        'MarkerSize', 12, 'LineWidth', 2);
    
    
    while true
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
    
        grid_x = next_pos(1) + offset + 1;
        grid_y = next_pos(2) + offset + 1;
    
        if grid_x < 1 || grid_x > canvas_size || grid_y < 1 || grid_y > canvas_size
            fprintf("Out of bounds!\n");
            continue;
        end
    
        if image(grid_y, grid_x) ~= 1 && image(grid_y, grid_x) ~= 2
            fprintf("You can't move there — it's off the path!\n");
            continue;
        end
    
        player_pos = next_pos;
    
        set(player_marker, 'XData', player_pos(1), 'YData', player_pos(2));
        drawnow;

        %enemy encounter?
        if rand() < encounter_chance
            pause(1)
            disp("An enemy appears!")
            combat_system(floor_number, player_health, player_damage, health_bonuses, damage_bonuses, score);

            enemy_defeated = enemy_defeated + 1;
            bonus = randi([1 2]);
            switch bonus
                case 1
                    disp("You got a health bonus!")
                    health_bonuses = health_bonuses + 1;
                case 2 
                    disp("you got a damage bonus!")
                    damage_bonuses = damage_bonuses + 1;
            end
            
                player_health = player_health_reference + health_bonuses;
                player_damage = player_damage_reference + damage_bonuses;
        
            score = ((floor_number - 1) * 20) + (enemy_defeated * 10);
        
        end
    
       
        if all(player_pos == goal_pos)
            fprintf("\n🎉 YOU FOUND THE GOAL at (%d, %d)!\n", goal_pos(1), goal_pos(2));
            floor_number = floor_number + 1;
            pause(1);
            break;
        end
    end
end



%%


function [floor_number, player_health, player_damage, health_bonuses, damage_bonuses] = combat_system(floor_number, player_health, player_damage, health_bonuses, damage_bonuses)

enemy_health = randi([5 10] + (floor_number - 1)); 
enemy_damage = randi([1 3]);

    while enemy_health > 0 && player_health > 0
        player_turn = input("Your Turn: Attack or Heal ('A' or 'H'): ",'s');
        fprintf('\n')
    
        if strcmp(player_turn, 'A')
            enemy_health = enemy_health - player_damage;
            fprintf("You deal %d damage to enemy. Enemy health is now %d.\n", player_damage, enemy_health)
        elseif strcmp(player_turn, 'H')
            player_health = player_health + 2;
            fprintf("You heal yourself for 2 damage. Your health is now %d.\n", player_health)
        else
            fprintf("Invalid command, Turn will be skipped\n")
        end 
    
        if enemy_health <= 0
            disp("You defeated the enemy!")
            return;
        end 
        fprintf("Enemys Turn:\n");
        player_health = player_health - enemy_damage;
        fprintf("The enemy deals %d damage to you. Your health is now %d.\n", enemy_damage, player_health);
    
        if player_health <= 0
            disp("You were defeated by the enemy...");
            error("Game over")
        end
    
    
    
    
        pause(0.5);
        
    end 
end