
require_relative 'board_generator.rb'

class Board
  attr_reader :cells,
              :new_board

  def initialize(height = 4, width = 4)
    @height = height
    @width = width
    @new_board = BoardGenerator.new(@height, @width)
    @cells = @new_board.board
  end

  def valid_coordinate?(coordinate)
    @cells.keys.any? {|key| key == coordinate.upcase}
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.size
    return false if coordinates.any? {|key| @cells[key].ship != nil}
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

  def render(ship = false)
    columns = @new_board.columns
    rows = @new_board.rows.map {|letter| letter + " "}
    columns.unshift(" ") unless columns[0] == " "
    str_columns = columns.join(" ") + " \n"
    key_grid = @cells.keys.group_by {|key| key[0]}.values
    render_grid = key_grid.map {|row| row.map {|key| @cells[key].render(ship)}}
    render_string = render_grid.map {|arr| arr.join(" ") + " \n"}
    str_columns + rows.zip(render_string).flatten.join
  end

end
