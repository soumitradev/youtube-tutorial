board = [[" ", " ", " "],
         [" ", " ", " "],
         [" ", " ", " "]]

player1 = "X"
player2 = "O"

player1_win = -1
tie = 0
player2_win = 1

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
    ai_move!(board)
    print_board(board)
end