% This functions reads the scores file and returns the highest score
function score = readScores(scoreFile)

    % Reads each line independantly 
    scoreText = fileread(scoreFile);
    scoreLines = splitlines(scoreText);

    % Puts each score in a vector
    numericScore = [];
    for i = 1:length(scoreLines)
        if ~isempty(scoreLines{i})
            numericScore(end+1) = str2double(scoreLines{i});
        end
    end
    
    % Sets score to max score
    score = max(numericScore);
end 