# frozen_string_literal: true

class Game
  attr_reader :board

  def initialize(board = [[], [], [], [], [], [], []])
    @board = board
  end

  def play_round(col, player)
    if col.negative? || col > 6
      puts 'Invalid column!'
      return
    end
    @board[col].push(player)
    print "#{@board}\n"
  end

  def game_over?
    print "#{@board}\n"
    over = false
    @board.each do |col|
      col.each_cons(4) do |a|
        over = (a.size == 4 && a.uniq.size == 1)
      end
    end
    over
  end
end
