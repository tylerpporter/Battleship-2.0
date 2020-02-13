require_relative 'test_helper.rb'
require './lib/board_generator.rb'

class BoardGeneratorTest < Minitest::Test

  def setup
    @board = BoardGenerator.new(6, 4)
  end

  def test_it_exists
    assert_instance_of BoardGenerator, @board
  end

  def test_it_returns_a_board_as_a_hash
    assert_equal Hash, @board.board.class
  end

  def test_it_returns_correct_board_size
    assert_equal 24, @board.board.size
    board2 = BoardGenerator.new(3, 3)
    assert_equal 9, board2.board.size
  end

  def test_its_keys_are_correct_format
    board = BoardGenerator.new(3, 3)
    keys = "A1, A2, A3, B1, B2, B3, C1, C2, C3".split(', ')
    assert_equal keys, board.board.keys
  end

end
