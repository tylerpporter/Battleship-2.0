require './lib/display_module.rb'

class MainMenu
  include Display
  attr_reader :user_decision
  def start
    @user_decision = nil
    loop do
      menu_display()
      @user_decision = gets.chomp().downcase
      break if  @user_decision == 'p' || @user_decision == 'q'
      puts @@text[1]
    end
    if @user_decision == 'q'
      quit_display()
    else
      puts @@text[2]
      puts ''
    end
  end

end
