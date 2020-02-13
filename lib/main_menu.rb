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
      puts invalid_messages[:try_again]
      puts '.'
      sleep(0.5)
      puts '.'
      sleep(0.5)
      puts '.'
      sleep(0.5)
      puts '.'
      sleep(0.5)
      puts '.'
      sleep(1)
      puts ''
    end
    if @user_decision == 'q'
      quit_display()
    else
      puts ''
      puts setup_messages[:begin]
      puts ''
    end
  end

end
