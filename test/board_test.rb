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

end
