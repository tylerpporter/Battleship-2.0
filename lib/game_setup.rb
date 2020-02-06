require './lib/board.rb'

class GameSetup
  attr_reader :computer_board, :player_board
  def initialize
    puts "Enter grid height (1 - 9):"
    height = gets.chomp().to_i
    puts "Enter grid width (1 - 9):"
    width = gets.chomp().to_i
    @computer_board = Board.new(height, width)
    @player_board = Board.new(height, width)
  end

end
