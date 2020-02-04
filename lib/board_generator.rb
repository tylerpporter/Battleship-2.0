require_relative 'cell.rb'

class BoardGenerator
  attr_reader :board
  def initialize(height, width)
    @height = height
    @width = width

    columns = (1..@width).to_a.map(&:to_s)
    rows = (65..65 + (@height -1)).to_a.map(&:chr)
    keys = rows.zip(columns).map(&:join)
    arr_board = keys.map {|coordinate| Cell.new(coordinate)}
    values = keys.map do |key|
      arr_board.select {|cell| cell.coordinate == key}
    end
    @board = keys.zip(values).to_h
  end
end
