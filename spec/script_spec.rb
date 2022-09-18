# frozen_string_literal: true

require './script'

# Create seven arrays of six elements each (every array) is a column, starting from the left.
# At each turn, players put their chip (red or yellow) on one of the arrays and the board is displayed.
# Every turn, the game checks if there is a 4 chip row in either a single array, 4 different arrays but the same index, or a diagonal.
# If this is true, then the game ends and a message is displayed