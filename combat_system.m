% This function houses the simple, text based combat system
function [floor_number, player_health, player_damage, health_bonuses, damage_bonuses, score] = combat_system(floor_number, player_health, player_damage, health_bonuses, damage_bonuses, score)

% Generates enemy stats randomly
enemy_health = randi([5 10] + (floor_number - 1)); % (floor_number - 1) used to scale health
enemy_damage = randi([1 3]);
disp(enemy_health)

% Combat loop
while enemy_health > 0 && player_health > 0

    % Player input
    player_turn = input("Your Turn: Attack or Heal ('A' or 'H'): ",'s');
    fprintf('\n')

    % Ensures input corresponds to an action and does that action
    % Attacks enemy
    if strcmp(player_turn, 'A') % Attacks enemy
        enemy_health = enemy_health - player_damage;
        fprintf("You deal %d damage to enemy. Enemy health is now %d.\n", player_damage, enemy_health)

    elseif strcmp(player_turn, 'H')% Heals Player
        player_health = player_health + 2;
        fprintf("You heal yourself for 2 damage. Your health is now %d.\n", player_health)

    else
        fprintf("Invalid command, Turn will be skipped\n")
    end 
    
    % Player win condition
    if enemy_health <= 0
        disp("You defeated the enemy!")
        return;
    end 

    % Enemy attack
    fprintf("Enemys Turn:\n");
    player_health = player_health - enemy_damage;
    fprintf("The enemy deals %d damage to you. Your health is now %d.\n", enemy_damage, player_health);

    % Lose condition
    if player_health <= 0
        disp("You were defeated by the enemy...");
        saveScore('scores.txt', score);
        error("Game over")
    end

    pause(0.5);
    
end 