# frozen_string_literal: true

class Game
  attr_reader :board, :turn

  def initialize(board = [[], [], [], [], [], [], []])
    @board = board
    @turn = '🔵'
    @quit = false
  end

  def play
    puts 'Welcome to connect four! Blue player starts'
    play_loop
  end

  def play_loop
    until game_over? || @quit
      puts "It's #{@turn} player's turn!"
      print_board
      puts 'Enter a column number from 1 to 7'
      player_input
    end
    player_turn
    if @quit
      puts 'You quit the game!'
    else
      print_board
      puts "Congrats! #{@turn} won!"
    end
  end

  def player_input
    input = gets.chomp
    input = gets.chomp until check_input(input)
    input.to_i
    play_round(input.to_i - 1, player_turn)
  end

  def player_turn
    turn = @turn
    @turn = (@turn == '🔵' ? '🔴' : '🔵')
    turn
  end

  def play_round(col, player)
    @board[col].push(player)
  end

  def check_input(input)
    if input == 'quit'
      @quit = true
      return true
    end
    if input.to_i.zero?
      puts 'Please input a number'
      return false
    end
    if input.to_i < 1 || input.to_i > 7
      puts 'Invalid column!'
      return false
    end
    true
  end

  def print_board
    board_to_print = Array.new(6) { Array.new(7) }
    6.times do |i|
      @board.each_with_index do |col, j|
        board_to_print[5 - i][j] = col[i] || '--'
      end
    end
    board_to_print.each do |row|
      puts row.join('  ')
    end
  end

  def transpose(board, size)
    transpose_board = []
    size.times do |i|
      transpose_board << []
      board.each do |col|
        col[i].nil? || transpose_board[i] << col[i]
      end
    end
    transpose_board
  end

  def game_over?
    col_game_over? || row_game_over? || diag_game_over?
  end

  def col_game_over?(board = @board)
    board.each do |col|
      col.each_cons(4) do |a|
        return true if a.size == 4 && a.uniq.size == 1
      end
    end
    false
  end

  def row_game_over?
    col_game_over?(transpose(@board, 6))
  end

  def diag_game_over?
    diag_board = []
    24.times { diag_board << [] }
    6.times do |i|
      @board.each_with_index do |col, j|
        col[i + j].nil? || diag_board[i] << col[i + j]
      end
    end
    6.times do |i|
      @board.each_with_index do |col, j|
        col[-i + j].nil? || diag_board[i + 6] << col[-i + j]
      end
    end
    6.times do |i|
      @board.each_with_index do |col, j|
        col[i - j].nil? || diag_board[i + 12] << col[i - j]
      end
    end
    6.times do |i|
      @board.each_with_index do |col, j|
        col[-i - j].nil? || diag_board[i + 18] << col[-i - j]
      end
    end
    col_game_over?(diag_board)
  end
end

game = Game.new
game.play
