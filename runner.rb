require 'require_all'
require_all './lib'

menu = MainMenu.new
menu 
if menu.user_decision == 'p'
  #placeholder for a Setup class
  puts Board.new.render
end
