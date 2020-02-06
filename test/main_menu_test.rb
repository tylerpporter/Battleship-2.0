require_relative 'test_helper.rb'
require './lib/main_menu.rb'

class MainMenuTest < Minitest::Test

  def setup
    @menu = MainMenu.new
  end

  def test_it_exists

    assert_instance_of MainMenu, @menu
  end

  def test_it_can_store_user_decision

    assert_match /(p|q)/, @menu.user_decision
  end

end
