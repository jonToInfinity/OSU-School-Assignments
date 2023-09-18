
fprintf('************ Jonathan G., Diana V., Sevonne G., Gabriella Q, *********\n')
fprintf('************ ENG 1181 12:40 *********\n')
fprintf('************ Parris  L 4-16-21*******\n')

% board display
board = zeros(6, 7);

% Ask for Game type
fashion = 0;
while fashion ~= 1 && fashion ~= 2
    fprintf('Would you like to challenge a Player (enter 1), or against a AI (enter 2)?\n');
    fashion = input('Enter: ');
end

% Assign the colored chips and ask for user names
if fashion == 1
    user1_chip = '1';
    user2_chip = '2';
    user1_name = input('Player 1: What is your name? ', 's');
    user2_name = input('Player 2: What is your name? ', 's');
else
    user1_chip = '1';
    user2_chip = 'c';
    user1_name = input('What is your name? ', 's');
    user2_name = 'COMPUTER';
end

% Player toggle
player = 2;

% Init result
result = 0;

% while loop while result is 0
while ~result
    % Toggle player
    if player == 1
        player = 2;
        name = user2_name;
    else
        player = 1;
        name = user1_name;
    end
    
    % Space between turns
    fprintf('\n');
        
    if fashion == 2 && player == 2
        % Have computer make move is mode is 2 and it's the comp's turn
        board = makeMove(board);
    else
        % Otherwise, show board and ask player to play
        Board_display(board, user1_chip, user2_chip);
        board = play(player, name, board);
    end
    
    % Check if a user won
    result = evaluateBoard(board);
end

% If there was a winner
if result == 1 || result == 2
    % Display winner and final board to users
    fprintf('\n____________________\nWINNER...%s!!!\n\n', name);
else
    % It was a draw.
    fprintf('\n____________________\nIt''s a draw!\n\n');
end

fprintf('Final board:\n');

function Board_display(board, player1_char, player2_char)
    % Display col header labels with divider
    fprintf('  1  2  3  4  5  6  7\n');
    fprintf('_______________________\n');
    
    % Loop rows and columns
    for row = 1:6
        % Two spaces before first col
        fprintf('  ');
        
        for col = 1:7
            % Determine character to use for position
            value = board(row, col);
            
            if value == 0
                char = '0';
            elseif value == 1
                char = player1_char;
            else
                char = player2_char;
            end
            
            % Print character in position with spaces to right
            fprintf('%s', char);
            fprintf('  ');
        end
        
        % Display row labels with left divider
        fprintf('|  %.0f\n', 7-row);
    end
end

function result = evaluateBoard(board)
    % Init result flag
    result = 0;
    
    % Search for horizontal connect-4
    for row = 1:6
        for col = 1:4
            % Grab these four
            fourinrow = board(row, col:(col+3));
            
            % If they all equal 1 or 2, set flag
            if fourinrow == 1
                result = 1;
                break;
            elseif fourinrow == 2
                result = 2;
                break;
            end
        end
    end
    
    % If no result, check for vertical connect-4
    if ~result
        for row = 1:3
            for col = 1:7
                % Grab these four
                fourincol = board(row:(row+3), col);

                % If they all equal 1 or 2, set flag
                if fourincol == 1
                    result = 1;
                    break;
                elseif fourincol == 2
                    result = 2;
                    break;
                end
            end
        end
    end

    % If no result, check for diagonal connect-4
    if ~result
        for row = 1:3
            for col = 1:4
                % Get this diagonal
                diagonal = [board(row, col), board(row+1, col+1), board(row+2, col+2), board(row+3, col+3)];
                
                % If they all equal 1 or 2, set flag
                if diagonal == 1
                    result = 1;
                    break;
                elseif diagonal == 2
                    result = 2;
                    break;
                end
                
                % Get inverse diagonal
                diagonal = [board(7-row, col), board(6-row, col+1), board(5-row, col+2), board(4-row, col+3)];
                
                % If they all equal 1 or 2, set flag
                if diagonal == 1
                    result = 1;
                    break;
                elseif diagonal == 2
                    result = 2;
                    break;
                end
            end
        end
    end
    
    % If no result, check for draw (full board)
    if ~result
        % Check if number of zeros is zero
        if sum(histc(board, 0)) == 0
            result = 3;
        end
    end
end

function board = makeMove(board)

    % Check if there is a winning move
    
    % Keep track of potential connect-4s
    potentials = [];
    
    % Potential horizontal connect-4
    for row = 1:6
        for col = 1:4
            % Grab these four
            four = board(row, col:(col+3));
            
            % Count zeros, ones, and twos
            equalzero = histc(four, 0);
            equalone = histc(four, 1);
            equaltwo = histc(four, 2);
            
            % If three equal 1 or 2 and one equals 0...
            if equalzero == 1 && (equalone == 3 || equaltwo == 3)
                % 3 of four are filled, attempt to block/win
                for subcol = 1:4
                    % Check if move is valid
                    if validPlay(board, row, col+subcol-1)
                        % Pot. connect-4, add to list (row, col, win bool)
                        potentials = [potentials; row, col+subcol-1, (equaltwo == 3)];
                    end
                end
            end
        end
    end
    
    % Potential vertical connect-4
    for row = 1:3
        for col = 1:7
            % Grab these four
            four = board(row:(row+3), col);
            
            % Count zeros, ones, and twos
            equalzero = histc(four, 0);
            equalone = histc(four, 1);
            equaltwo = histc(four, 2);
            
            % If three equal 1 or 2 and one equals 0...
            if equalzero == 1 && (equalone == 3 || equaltwo == 3)
                % 3 of four are filled, attempt to block/win
                for subrow = 1:4
                    % Check if move is valid
                    if validPlay(board, row+subrow-1, col)
                        % Pot. connect-4, add to list (row, col, win bool)
                        potentials = [potentials; row+subrow-1, col, (equaltwo == 3)];
                    end
                end
            end
        end
    end
    
    % Potential diagonal connect-4
    for row = 1:3
        for col = 1:4
            % Get this diagonal
            four = [board(row, col), board(row+1, col+1), board(row+2, col+2), board(row+3, col+3)];

            % Count zeros, ones, and twos
            equalzero = histc(four, 0);
            equalone = histc(four, 1);
            equaltwo = histc(four, 2);
            
            % If three equal 1 or 2 and one equals 0...
            if equalzero == 1 && (equalone == 3 || equaltwo == 3)
                % 3 of four are filled, attempt to block/win
                for sub = 1:4
                    % Check if move is valid
                    if validPlay(board, row+sub-1, col+sub-1)
                        % Pot. connect-4, add to list (row, col, win bool)
                        potentials = [potentials; row+sub-1, col+sub-1, (equaltwo == 3)];
                    end
                end
            end

            % Get inverse diagonal
            four = [board(7-row, col), board(6-row, col+1), board(5-row, col+2), board(4-row, col+3)];

            % Count zeros, ones, and twos
            equalzero = histc(four, 0);
            equalone = histc(four, 1);
            equaltwo = histc(four, 2);
            
            % If three equal 1 or 2 and one equals 0...
            if equalzero == 1 && (equalone == 3 || equaltwo == 3)
                % 3 of four are filled, attempt to block/win
                for sub = 1:4
                    % Check if move is valid
                    if validPlay(board, 8-row-sub, col+sub-1)
                        % Pot. connect-4, add to list (row, col, win bool)
                        potentials = [potentials; 8-row-sub, col+sub-1, (equaltwo == 3)];
                    end
                end
            end
        end
    end
    
    % Get size of potentials list
    [poty,potx] = size(potentials);
    i = 1;
    for pot = potentials'
        pot = pot';
        
        % If this potential connect-4 is a win or it the last on the list
        if pot(3) == 1 || poty == i
            % Place chip
            board(pot(1), pot(2)) = 2;
            % Return function
            return;
        end
        i = i + 1;
    end
            
    % *** If no block/win is possible, play random move
    
    % Pick random column (as long as column is not full)
    col = randperm(7, 1);
    while board(1, col)
        col = randperm(7, 1);
    end
    
    % Determine row to play
    for row = 1:6
        if row == 6 || board(row+1, col)
            break;
        end
    end
    
    % Place chip as 2
    board(row, col) = 2;
end

function board = play(player, name, board)
    % Display player name
    fprintf('Turn: %s (player %.0f)\n', name, player);
    
    % Loop to check input validity
    valid = 0;
    while ~valid
        % Ask player for position to play
        fprintf('whats your next move?\n');
        col = input('Column: ');
        row = input('Row: ');
        
        % Convert player-perspective row to actual
        row = 7-row;
        
        % Check if valid play
        if validPlay(board, row, col)
            valid = 1;
            break;
        end
        
        fprintf('Bad choice, go again!\n');
    end
    
    % Place chip on board
    board(row, col) = player;
end
function valid = validPlay(board, row, col)
    valid = 0;

    % Check if there integers
    if rem(row, 1) == 0 && rem(col, 1) == 0
        % Check if there in range of board
        if row > 0 && col > 0 && row <= 6 && col <= 7
            % Check if position is not already existing
            if ~board(row, col)
                % Check if position is on bottom or on top of other position
                if row == 6 || board(row+1, col)
                    valid = 1;
                end
            end
        end
    end
end
