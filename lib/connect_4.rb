class Game
    attr_accessor :board

    def initialize()
        @board = Array.new(6).map {Array.new(7)}
    end

    def full_game()
        until winner?('X') || winner?('O') do
            player_turn('X')
            player_turn('O')
        end
        
    end

    def player_turn(piece) 
        display_board()
        player_move = verify_input(user_input)
        while player_move.nil? do
            print "Invalid Move, try again: "
            player_move = verify_input(user_input)
        end
        place_piece(player_move, piece)
        if winner?(piece)
            display_board()
            puts "#{piece} Wins!"
        end
    end

    def place_piece(column, piece)
        5.downto(0) do |row|
            if board[row][column] == nil
                board[row][column] = piece
                return piece
            end
        end
    end

    def verify_input(column)
        return nil if  column.to_s.match?(/[^0-9]/) || column.to_i < 0 || column.to_i > 6
        return column.to_i
    end

    def display_board() 
        display = ""
        board.each do |row|
            display += "|"
            row.each do |column|
                if column == nil
                    display += " |"
                else
                    display += "#{column}|"
                end
            end
            display += "\n"
        end
        puts display
    end

    def winner?(piece)
        #horizontal checker
        board.each do |row|
            count = 0
            row.each do |column|

                if column == piece
                    count += 1
                else
                    count = 0
                end

                return true if count == 4
            end
        end
   
        #vertical checker
        for column in 0..6 do
            count = 0
            for row in 0..5 do
                if board[row][column] == piece
                    count += 1
                else
                    count = 0
                end

                return true if count == 4
            end
        end

        #decending diagonal checker
        0.upto(3) do |x|
            0.upto(2) do |y|
                if board[y][x] == piece && board[y+1][x+1] == piece && board[y+2][x+2] == piece && board[y+3][x+3] == piece
                    return true
                end
            end
        end
        6.downto(3) do |x|
            0.upto(2) do |y|
                if board[y][x] == piece && board[y+1][x-1] == piece && board[y+2][x-2] == piece && board[y+3][x-3] == piece
                    return true
                end
            end
        end

        return false
    end

    private
    def user_input
        print 'Enter column (0-6) '
        answer = gets.chomp
    end

    def intro
        puts 'Connect 4'
        puts 'Place piece into desired column'
        puts 'Match 4 pieces vertically, horizontally, or diagonally to win!'
    end

end

#game = Game.new()
#game.full_game