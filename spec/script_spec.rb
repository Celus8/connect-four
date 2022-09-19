# frozen_string_literal: true

require './script'

# Create seven arrays of six elements each (every array) is a column, starting from the left.
# At each turn, players put their chip (red or blue) on one of the arrays and the board is displayed.
# Every turn, the game checks if there is a 4 chip row in either a single array, 4 different arrays but the same index
# or a diagonal.
# If this is true, then the game ends and a message is displayed

RSpec.describe Game do
  describe '#play_round' do
    context 'when red player plays column number 3' do
      it 'adds a "red" chip to array number 3' do
        col = 3
        player = 'red'
        subject.play_round(col, player)
        expect(subject.board[3][0]).to eq('red')
      end
    end

    context 'when blue player plays column number 5' do
      it 'adds a "blue" chip to array number 5' do
        col = 5
        player = 'blue'
        subject.play_round(col, player)
        expect(subject.board[5][0]).to eq('blue')
      end
    end

    context 'when a player tries to play an invalid column' do
      it 'raises an error' do
        col = 7
        player = 'red'
        error_message = 'Invalid column!'
        expect(subject).to receive(:puts).with(error_message)
        subject.play_round(col, player)
      end
    end
  end

  describe '#check_input' do
    context "when input isn't a number" do
      it 'raises an error' do
        error_message = 'Please input a number'
        expect(subject).to receive(:puts).with(error_message).once
        subject.check_input('b')
      end

      it 'returns false' do
        expect(subject.check_input('b')).to be false
      end
    end

    context 'when input is an invalid number' do
      it 'raises an error' do
        error_message = 'Invalid column!'
        expect(subject).to receive(:puts).with(error_message)
        subject.check_input('15')
      end

      it 'returns false' do
        expect(subject.check_input('15')).to be false
      end
    end

    context 'when input is a valid number' do
      it 'does not raise an error' do
        error_message = 'Invalid column!'
        expect(subject).not_to receive(:puts).with(error_message)
        subject.check_input('4')
      end

      it 'returns true' do
        expect(subject.check_input('4')).to be true
      end
    end
  end

  describe '#player_input' do
    context 'when a valid number is inputted' do
      it 'plays round' do
        allow(subject).to receive(:gets).and_return('3')
        expect(subject).to receive(:play_round)
        subject.player_input
      end
    end
  end

  describe '#player_turn' do
    context 'when turn is blue' do
      it 'makes turn be red' do
        subject.instance_variable_set(:@turn, 'blue')
        subject.player_turn
        expect(subject.turn).to eq('red')
      end

      it 'returns blue' do
        subject.instance_variable_set(:@turn, 'blue')
        expect(subject.player_turn).to eq('blue')
      end
    end
  end

  describe '#col_game_over?' do
    context 'when a player has a column of 4' do
      it 'returns true' do
        win_board = [%w[red red red red], [], [], [], [], [], []]
        subject.instance_variable_set(:@board, win_board)
        expect(subject).to be_col_game_over
      end
    end

    context 'when no player has a column of 4' do
      it 'returns false with 3 reds' do
        lose_board = [%w[red red red], [], [], [], [], [], []]
        subject.instance_variable_set(:@board, lose_board)
        expect(subject).not_to be_col_game_over
      end

      it 'returns false with 2 reds and 2 blues' do
        lose_board = [%w[red red blue blue], [], [], [], [], [], []]
        subject.instance_variable_set(:@board, lose_board)
        expect(subject).not_to be_col_game_over
      end
    end
  end

  describe '#row_game_over?' do
    context 'when a player has a row of 4' do
      it 'returns true' do
        win_board = [['blue'], ['blue'], ['blue'], ['blue'], [], [], []]
        subject.instance_variable_set(:@board, win_board)
        expect(subject).to be_row_game_over
      end
    end

    context 'when no player has a row of 4' do
      it 'returns true with 2 blues and 2 reds' do
        lose_board = [['blue'], ['red'], ['blue'], ['red'], [], [], []]
        subject.instance_variable_set(:@board, lose_board)
        expect(subject).not_to be_row_game_over
      end
    end
  end

  describe '#diag_game_over?' do
    context 'when a player has a diagonal of 4' do
      it 'returns true with an ascending diaognal' do
        win_board = [%w[blue], %w[red blue], %w[blue red blue], %w[red red blue blue], [], [], []]
        subject.instance_variable_set(:@board, win_board)
        expect(subject).to be_diag_game_over
      end

      it 'returns true with a descending diagonal' do
        win_board = [%w[red red blue blue], %w[blue red blue], %w[red blue], %w[blue], [], [], []]
        subject.instance_variable_set(:@board, win_board)
        expect(subject).to be_diag_game_over
      end
    end

    context 'when no player has a diagonal of 4' do
      it 'returns false with 2 reds and 2 blues, ascending diagonal' do
        lose_board = [%w[blue], %w[red red], %w[blue red red], %w[red red blue blue], [], [], []]
        subject.instance_variable_set(:@board, lose_board)
        expect(subject).not_to be_diag_game_over
      end

      it 'returns false with 2 reds and 2 blues, descending diagonal' do
        lose_board = [%w[red red blue red], %w[blue red red], %w[red blue], %w[blue], [], [], []]
        subject.instance_variable_set(:@board, lose_board)
        expect(subject).not_to be_diag_game_over
      end
    end
  end
end
