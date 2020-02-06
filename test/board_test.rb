require_relative "test_helper.rb"
require "./lib/board.rb"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
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

end
