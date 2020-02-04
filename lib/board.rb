require_relative 'board_generator.rb'

class Board
  attr_reader :cells
  def initialize
    @cells = BoardGenerator.new(4, 4).board
  end

  def valid_coordinate?(coordinate)
    @cells.keys.any? {|key| key == coordinate.upcase}
  end
end
