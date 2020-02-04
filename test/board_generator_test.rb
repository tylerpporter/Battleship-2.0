require_relative 'test_helper.rb'
require './lib/board_generator.rb'

class BoardGeneratorTest < Minitest::Test

  def setup
    @board = BoardGenerator.new(6, 4)
  end

  def test_it_exists
    assert_instance_of BoardGenerator, @board
  end

end
