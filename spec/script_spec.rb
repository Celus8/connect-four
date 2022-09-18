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
        expect(subject).to receive(:puts).with('Invalid column!')
        subject.play_round(col, player)
      end
    end
  end

  describe '#game_over?' do
    context 'when a player has a column of 4' do
      it 'returns true' do
        win_board = [['red', 'red', 'red', 'red'], [], [], [], [], [], []]
        subject.instance_variable_set(:@board, win_board)
        expect(subject).to be_game_over
      end
    end

    context 'when no player has a column of 4' do
      it 'returns false' do
        lose_board = [['red', 'red', 'red'], [], [], [], [], [], []]
        subject.instance_variable_set(:@board, lose_board)
        expect(subject).not_to be_game_over
      end
    end
  end
end
