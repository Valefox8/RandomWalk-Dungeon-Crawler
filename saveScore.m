% This file is used to save each score to scores.txt
function saveScore(scoreFile, newScore)

    % Opens file
    fileID = fopen(scoreFile, 'a'); %'a' is used as appending allows for editing at end of file 
    
    % Gives a response in the terminal if the file cannot be opened
    if fileID == -1 
        disp("Scores file cannot be opned.")
        return
    end 
    
    % Saves score
    fprintf(fileID, '%d\n', newScore);

    % Closes file
    fclose(fileID);

end 
