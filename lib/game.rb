require 'require_all'
require_all './lib'

class Game
  attr_reader :menu, :game_setup

  def initialize
    @menu = MainMenu.new
    @game_setup = GameSetup.new
  end

  def start
    @menu.start
    if @menu.user_decision == 'p'
      @game_setup.start
      @game_setup.create_ships
    elsif @menu.user_decision == 'q'
    end
  end

end
