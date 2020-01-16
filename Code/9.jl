board = [[" ", " ", " "],
         [" ", " ", " "],
         [" ", " ", " "]]

player1 = "X"
player2 = "O"

player1_win = -1
tie = 0
player2_win = 1

function check_win(board)

    # Rows
    for i in 1:3
        if (board[i][1] == board[i][2] == board[i][3]) && (board[i][1] in [player1, player2])
            if (board[i][1] == player1)
                return player1_win
            end
            return player2_win
        end
    end

    # Column
    for i in 1:3
        if (board[1][i] == board[2][i] == board[3][i]) && (board[1][i] in [player1, player2])
            if (board[1][i] == player1)
                return player1_win
            end
            return player2_win
        end
    end

    # Principal diagonal
    if (board[1][1] == board[2][2] == board[3][3]) && (board[1][1] in [player1, player2])
        if (board[1][1] == player1)
            return player1_win
        end
        return player2_win
    end

    # Other diag
    if (board[1][3] == board[2][2] == board[3][1]) && (board[1][3] in [player1, player2])
        if (board[1][3] == player1)
            return player1_win
        end
        return player2_win
    end

    # Tie
    if length(check_available(board)) == 0
        return tie
    end

    # No one wins, game still goes on
    return nothing
end

function minimax(board, depth, is_maximising)
    result = check_win(board)

    if result !== nothing
        return result
    elseif is_maximising

        best_score = -Inf

        for i in 1:3, j in 1:3
            if board[i][j] == " "

                board[i][j] = player2

                score = minimax(board, depth + 1, false)
                
                board[i][j] = " "

                best_score = max(score, best_score)
            end
        end

        return best_score        
    else        
        best_score = Inf

        for i in 1:3, j in 1:3
            if board[i][j] == " "

                board[i][j] = player1

                score = minimax(board, depth + 1, true)
                
                board[i][j] = " "

                best_score = min(score, best_score)
            end
        end

        return best_score   
    end

end

function worst_move(board)
    worst_score = Inf

    worst_pos = (0, 0)

    for i in 1:3, j in 1:3
        if board[i][j] == " "

            board[i][j] = player2
            
            score = minimax(board, 0, true)

            
            board[i][j] = " "

            if score < worst_score
                worst_score = score
                worst_pos = (i, j)
            end
        end
    end
    return worst_pos
end

function best_move(board)
    best_score = -Inf

    best_pos = (0, 0)

    for i in 1:3, j in 1:3
        if board[i][j] == " "

            board[i][j] = player2
            
            score = minimax(board, 0, false)

            
            board[i][j] = " "

            if score > best_score
                best_score = score
                best_pos = (i, j)
            end
        end
    end
    return best_pos
end

function print_board(board)
    println("    1   2   3")
    println(" 1  ", join(board[1], " | "))
    println("   ———┼———┼———")
    println(" 2  ", join(board[2], " | "))
    println("   ———┼———┼———")
    println(" 3  ", join(board[3], " | "))
end

function make_move!(board, player, (x, y))
    board[x][y] = player
end

function check_available(board)
    available_cells = []
    for i in 1:3, j in 1:3
        if board[i][j] == " "
            push!(available_cells, (i, j))
        end
    end
    return available_cells
end


function ai_move!(board, difficulty)
    if difficulty == "loser"
        make_move!(board, player2, worst_move(board))
    elseif difficulty == "easy"
        pos = rand(check_available(board))
        make_move!(board, player2, pos)
    elseif difficulty == "medium"
        if rand() < 0.3
            make_move!(board, player2, best_move(board))
        else            
            pos = rand(check_available(board))
            make_move!(board, player2, pos)
        end
    elseif difficulty == "hard"
        if rand() < 0.7
            make_move!(board, player2, best_move(board))
        else            
            pos = rand(check_available(board))
            make_move!(board, player2, pos)
        end
    elseif difficulty == "impossible"
        make_move!(board, player2, best_move(board))
    end
end

function move_input(prompt, params)

    println(prompt)
    txt = split(readline())

    if txt == ["exit"]
        exit()
    end

    if length(txt) == params && txt[1] in string.(collect(1:3)) && txt[2] in string.(collect(1:3))
        return txt
    else
        println("Please enter a valid command (See README)")
        move_input(prompt, params)
    end
end

function generalised_input(prompt, same_line, choices, params)
    same_line ? print(prompt) : println(prompt)

    txt = split(lowercase(readline()))

    if txt == ["exit"]
        exit()
    end

    if length(txt) == params && txt[1] in choices
        return txt
    else
        println("Please enter a valid command (See README)")
        generalised_input(prompt, same_line, choices, params)
    end
end

print_board(board)

diff_levels = """
loser - human always wins
easy - AI is random
medium - AI makes some mistakes
hard - AI makes less mistakes
impossible - AI is perfect
"""

println(diff_levels)
difficulty = generalised_input("Difficulty: ", true, ["loser", "easy", "medium", "hard", "impossible"], 1)[1]

while true
    print_board(board)

    txt = move_input("Enter: ", 2)
    make_move!(board, player1, (parse(Int, txt[1]), parse(Int, txt[2])))

    if check_win(board) == player1_win
        println(1)
        break
    elseif check_win(board) == player2_win
        println(2)
        break
    elseif check_win(board) == tie
        println("Tie!")
        break
    end

    ai_move!(board, difficulty)
    print_board(board)

    if check_win(board) == player1_win
        println(1)
        break
    elseif check_win(board) == player2_win
        println(2)
        break
    elseif check_win(board) == tie
        println("Tie!")
        break
    end
end