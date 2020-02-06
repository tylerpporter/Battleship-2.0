require 'require_all'
require_all './lib'

menu = MainMenu.new

if menu.user_decision == 'p'
  game_setup = GameSetup.new
  game_setup.create_ships
  # require "pry"; binding.pry
end
