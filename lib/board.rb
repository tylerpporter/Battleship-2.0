require_relative 'board_generator.rb'

class Board
  attr_reader :cells
  def initialize
    @cells = BoardGenerator.new(4, 4).board
  end

  def valid_coordinate?(coordinate)
    @cells.keys.any? {|key| key == coordinate.upcase}
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.size
    rows = coordinates.map(&:chars).map {|arr| arr[0]}
    columns = coordinates.map(&:chars).map {|arr| arr[1]}
    if rows.uniq.size == 1 &&
      columns.map(&:to_i).each_cons(2).all? {|num1, num2| num2 == num1 + 1}
      true
    elsif
      columns.uniq.size == 1 &&
      rows.map(&:ord).each_cons(2).all? {|num1, num2| num2 == num1 + 1}
      true
    else
      false
    end
  end

  def place(ship, coordinates)
    return "Invalid coordinates" if !valid_placement?(ship, coordinates)
    coordinates.each {|key| @cells[key].place_ship(ship)}
  end

end
