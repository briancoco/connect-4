require './lib/connect_4'

describe Game do
    describe '#place_piece' do
        subject(:game_pieces) {described_class.new()}
        context 'when placing piece at marked column' do
            it 'appears in that column' do
                piece = 'X'
                column = 3
                board = game_pieces.board
                result = false
                game_pieces.place_piece(column, piece)
                6.times do |row|
                    if board[row][column] == 'X'
                        result = true
                    end
                end
                expect(result).to eq(true)
            end

            it 'stacks on top of already present pieces' do
                first_piece = 'X'
                second_piece = 'O'
                column = 3
                board = game_pieces.board
                game_pieces.place_piece(column, first_piece)
                game_pieces.place_piece(column, second_piece)
                result = board[4][3]
                expect(result).to eq(second_piece)
            end
        end
    end

    describe '#verify_input' do
        subject(:game_input) {described_class.new()}

        context 'when given invalid column' do
            it 'returns nil' do
                invalid_column = 7
                result = game_input.verify_input(invalid_column)
                expect(result).to be_nil
            end
        end

        context 'when given valid column' do
            it 'returns that column' do
                valid_column = 3
                result = game_input.verify_input(valid_column)
                expect(result).to eq(valid_column)
            end
        end

        context 'when given non-numeric input' do
            it 'returns nil' do
                invalid_column = 'AbC1'
                result = game_input.verify_input(invalid_column)
                expect(result).to be_nil
            end
        end

    end

    describe '#winner?' do
        subject(:game_winner) {described_class.new()}

        context 'when there is a winner horizontally' do

            it 'returns true' do
                piece = 'X'
                game_winner.place_piece(0, piece)
                game_winner.place_piece(1, piece)
                game_winner.place_piece(2, piece)
                game_winner.place_piece(3, piece)
                expect(game_winner).to be_winner(piece)
            end
        end

        context 'when there is a winner vertically' do
            it 'returns true' do
                piece = 'X'
                column = 3
                game_winner.place_piece(column, piece)
                game_winner.place_piece(column, piece)
                game_winner.place_piece(column, piece)
                game_winner.place_piece(column, piece)
                expect(game_winner).to be_winner(piece)
            end
        end

        context 'when there is a winner diagonally to the left' do
            it 'returns true' do
                piece = 'X'
                game_winner.board[0][3] = piece
                game_winner.board[1][2] = piece
                game_winner.board[2][1] = piece
                game_winner.board[3][0] = piece
                expect(game_winner).to be_winner(piece)
            end
        end

        context 'when there is a winner diagonally to the right' do
            it 'returns true' do
                piece = 'X'
                game_winner.board[0][3] = piece
                game_winner.board[1][4] = piece
                game_winner.board[2][5] = piece
                game_winner.board[3][6] = piece
                expect(game_winner).to be_winner(piece)
            end
        end

        context 'when there are no winners' do
            it 'returns false' do
                piece = 'X'
                game_winner.board[0][1] = piece
                game_winner.board[0][0] = piece
                game_winner.board[0][2] = piece
                game_winner.board[0][3] = 'O'
                expect(game_winner).to_not be_winner(piece)
            end
        end
    end
end
