board = [[" ", " ", " "],
         [" ", " ", " "],
         [" ", " ", " "]]

player1 = "X"
player2 = "O"

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

while true
    print_board(board)
    print("Enter: ")
    txt = split(readline())
    make_move!(board, player1, (parse(Int, txt[1]), parse(Int, txt[2])))
end