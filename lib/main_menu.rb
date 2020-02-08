class MainMenu
  attr_reader :user_decision
  def start
    @user_decision = nil
    loop do
      puts "-" * 50
      puts "Welcome to BATTLESHIP"
      puts "Enter 'p' to play. Enter 'q' to quit."
      puts "-" * 50
      @user_decision = gets.chomp().downcase
      break if  @user_decision == 'p' || @user_decision == 'q'
      puts "Invalid Option!!! Try again..."
    end
    if @user_decision == 'q'
      print "We could've made some memories"
      sleep(0.3)
      print "."
      sleep(0.3)
      print "."
      sleep(0.3)
      print "."
      sleep(1.7)
      print " oh well."
      sleep(1)
      puts ''
    else
      puts "Let's begin..."
      puts ''
    end
  end

end
