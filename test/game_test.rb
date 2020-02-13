require_relative 'test_helper.rb'
require 'stringio'
require 'o_stream_catcher'
require './lib/game.rb'

class GameTest < Minitest::Test

  def setup
    @new_game = Game.new
    @string_io = StringIO.new

  end

  def test_it_exists
    assert_instance_of Game, @new_game
  end

  def test_it_starts_a_game
    @new_game.start
    @string_io.puts 'p'
    @string_io.puts 4
    @string_io.puts 4
    @string_io.puts 2
    @string_io.puts "Cruiser"
    @string_io.puts 2
    @string_io.puts "Medusa"
    @string_io.puts 3
    @string_io.puts "a1"
    @string_io.puts "a2"
    @string_io.puts "b1"
    @string_io.puts "b2"
    @string_io.puts "b3"
    @string_io.puts "g9"
    @string_io.puts "b1"
    @string_io.puts "b1"
    @string_io.puts "exit"
    @string_io.puts "q"
    @string_io.rewind
    $stdin = @string_io
    OStreamCatcher.catch do
      @new_game.start
    end
    $stdin = STDIN
    assert !@new_game.game_setup.player_board.cells["A1"].ship.nil?
  end

end
