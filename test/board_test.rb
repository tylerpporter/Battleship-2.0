require_relative 'test_helper.rb'
require './lib/board.rb'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
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

end
