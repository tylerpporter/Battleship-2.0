require_relative 'test_helper.rb'
require 'stringio'
require 'o_stream_catcher'
require './lib/game.rb'

class GameTest < Minitest::Test

  def setup
    @new_game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @new_game
  end

end
