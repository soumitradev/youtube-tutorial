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


function ai_move!(board)
    pos = rand(check_available(board))
    make_move!(board, player2, pos)
end

print_board(board)

while true
    print_board(board)

    print("Enter: ")
    txt = split(readline())
    make_move!(board, player1, (parse(Int, txt[1]), parse(Int, txt[2])))

    if check_win(board) == player1_win
        println(1)
        break
    elseif check_win(board) == player2_win
        println(2)
        break
    end

    ai_move!(board)
    print_board(board)

    if check_win(board) == player1_win
        println(1)
        break
    elseif check_win(board) == player2_win
        println(2)
        break
    end
end