require_relative 'test_helper.rb'
require './lib/game_setup.rb'

class GameSetupTest < Minitest::Test

  def setup
    @game = GameSetup.new
  end

  def test_it_exists_with_two_boards

    assert_instance_of GameSetup, @game
    assert_equal Board, @game.computer_board.class
    assert_equal Board, @game.player_board.class
  end

  def test_it_can_create_an_array_of_ships
    @game.create_ships

    assert_equal Array, @game.player_ships.class
    assert_equal Ship, @game.player_ships[1].class   
  end

end
