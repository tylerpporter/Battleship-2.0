
require_relative 'test_helper.rb'
require './lib/ship.rb'
require './lib/board.rb'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists_with_16_cell_objects
    assert_instance_of Board, @board
    assert_equal 16, @board.cells.size
    assert_equal Hash, @board.cells.class
    assert_equal Cell, @board.cells["A1"].class
  end

  def test_it_can_validate_a_coordinate
    assert @board.valid_coordinate?("A2")
    assert @board.valid_coordinate?("c3")
    refute @board.valid_coordinate?("G9")
  end

  def test_ships_cannot_be_placed_if_length_and_coordinate_length_are_not_equal
    assert @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert @board.valid_placement?(@submarine, ["A1", "B1"])
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
  end

  def test_ships_cannot_be_placed_diagonally
    assert_equal false,  @board.valid_placement?(@cruiser, ["A2", "B3", "C4"])
    assert_equal false,  @board.valid_placement?(@submarine, ["B2", "C1"])
  end

  def test_ships_can_only_be_placed_with_consecutive_coordinates
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert @board.valid_placement?(@submarine, ["D1", "D2"])
    refute @board.valid_placement?(@cruiser, ["A1", "A3", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
  end

  def test_it_can_place_a_ship_in_its_cells
    assert_equal "Invalid coordinates", @board.place(@submarine, ["A1", "C1"])
    @board.place(@cruiser, ["B1", "C1", "D1"])
    assert_equal "Cruiser", @board.cells["B1"].ship.name
    assert_equal "Cruiser", @board.cells["C1"].ship.name
    assert_equal "Cruiser", @board.cells["D1"].ship.name
    assert @board.cells["C1"].ship == @board.cells["D1"].ship
    refute @board.cells["A1"].ship == @board.cells["B1"].ship
  end

  def test_ships_cannot_be_placed_in_cell_that_has_a_ship
    @board.place(@cruiser, ["B1", "C1", "D1"])
    assert_equal false, @board.valid_placement?(@submarine, ["B1", "B2"])
  end

  def test_it_can_render_an_empty_board
    rendered = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal rendered, @board.render
  end

  def test_it_can_render_a_board_and_show_a_placed_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    rendered = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal rendered, @board.render(true)
  end

  def test_it_can_render_an_accurate_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.cells["A1"].fire_upon
    rendered = "  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal rendered, @board.render
    @board.cells["B2"].fire_upon
    rendered2 = "  1 2 3 4 \nA H . . . \nB . M . . \nC . . . . \nD . . . . \n"
    rendered2_reveal = "  1 2 3 4 \nA H S S . \nB . M . . \nC . . . . \nD . . . . \n"
    assert_equal rendered2, @board.render
    assert_equal rendered2_reveal, @board.render(true)
    @board.cells["A2"].fire_upon
    @board.cells["A3"].fire_upon
    rendered3 = "  1 2 3 4 \nA X X X . \nB . M . . \nC . . . . \nD . . . . \n"
    assert_equal rendered3, @board.render
  end

end
