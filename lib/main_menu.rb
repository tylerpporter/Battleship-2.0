class MainMenu
  attr_reader :user_decision
  def initialize
    @user_decision = nil
    loop do
      puts "Welcome to BATTLESHIP"
      puts "Enter 'p' to play. Enter 'q' to quit."
      @user_decision = gets.chomp().downcase
      break if  @user_decision == 'p' || @user_decision == 'q'
      puts "Invalid Option!!! Try again..."
      sleep(1)
    end
    if @user_decision == 'q'
      print "We could've made some memories..."
      sleep(1)
      puts "oh well."
    else
      puts "Let's begin..."
      sleep(1)
    end
  end

end