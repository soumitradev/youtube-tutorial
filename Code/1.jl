board = [[" ", " ", " "],
         [" ", " ", " "],
         [" ", " ", " "]]

function print_board(board)
    println(" ", join(board[1], " | "))
    println(" ——┼———┼——")
    println(" ", join(board[2], " | "))
    println(" ——┼———┼——")
    println(" ", join(board[3], " | "))
end

print_board(board)