require_relative 'cell.rb'

class BoardGenerator
  attr_reader :board
  def initialize(height, width)
    @height = height
    @width = width

    columns = (1..@width).to_a.map(&:to_s)
    rows = (65...65 + @height).to_a.map(&:chr)
    keys = (rows.map do |letter|
            columns.map {|num| letter + num}
            end).flatten
    cells = keys.map {|coordinate| Cell.new(coordinate)}

    @board = keys.zip(cells).to_h
  end

end
