require_relative "test_helper.rb"
require "./lib/board.rb"
require "./lib/ship.rb"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @ship = Ship.new("cruiser", 2)
    @ship2 = Ship.new("Submarine", 3)
  end

  def test_it_exists_with_cells
    assert_instance_of Board, @board
    assert_equal 16, @board.cells.size
    assert_equal Hash, @board.cells.class
  end

  def test_each_cell_is_a_cell_object
    assert_equal Cell, @board.cells["A1"].class

  end

  def test_it_can_validate_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("Z1")

  end

  def test_ships_cannot_be_placed_if_length_and_coordinate_length_are_not_equal
    assert @board.valid_placement?(@ship, ["A1", "A2"])
    assert @board.valid_placement?(@ship2, ["C1", "C2", "C3"])
    assert_equal false, @board.valid_placement?(@ship, ["C1", "C2", "C3"])

  end

  def test_ships_cannot_be_placed_diagonally
    assert_equal false, @board.valid_placement?(@ship2,
     ["A2", "B3", "C4"])
  end
  def test_ships_can_only_be_placed_in_consecutive_coordinates
    assert @board.valid_placement?(@ship2, ["B1", "C1",
      "D1"])
    assert_equal false, @board.valid_placement?(@ship2, ["A1", "A3", "A4"])
  end

end
