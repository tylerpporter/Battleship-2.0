require_relative 'test_helper.rb'
require 'stringio'
require 'o_stream_catcher'
require './lib/main_menu.rb'

class MainMenuTest < Minitest::Test

  def setup
    @menu = MainMenu.new
    @string_io = StringIO.new
  end

  def test_it_stores_user_quit_decision
    @string_io.puts 'q'
    @string_io.rewind
    $stdin = @string_io
    OStreamCatcher.catch do
    @menu.start
    end
    $stdin = STDIN

    assert_equal 'q', @menu.user_decision
  end

  def test_it_stores_user_play_decision
    @string_io.puts 'p'
    @string_io.rewind
    $stdin = @string_io
    OStreamCatcher.catch do
    @menu.start
    end
    $stdin = STDIN

    assert_equal 'p', @menu.user_decision
  end

  def test_it_knows_what_to_do_with_invalid_input
    @string_io.puts "lkj"
    @string_io.puts "q"
    @string_io.rewind
    $stdin = @string_io
    OStreamCatcher.catch do
    @menu.start
    end
    $stdin = STDIN

    assert_equal 'q', @menu.user_decision
  end

end
