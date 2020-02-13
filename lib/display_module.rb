require 'pastel'
require 'tty-font'

module Display

  def invalid_messages
    {
      try_again: "Invalid Option!!! Try again...",
      height: "Invalid height",
      width: "Invalid width",
      ships: "Invalid number of ships. You can have 2.",
      length: "Invalid length. The ship needs to be able to fit on the board.",
      coordinate1: "Invalid coordinate.",
      coordinates: "Invalid coordinates. Coordinates cannot be diagonal or skip cells.",
      coordinate2: "Invalid coordinate... "
    }
  end

  def setup_messages
    {
      begin: "Let's begin...",
      grid_h: "Enter grid height (3 - 26):",
      grid_w: "Enter grid width (3 - 9):",
      ship_num: "How many ships do you want?",
      ship_name: "Enter name for ship ",
      ship_length: "Enter length of the ",
      placement: "Now, pick where you want to place your ships.",
      first_coord: "Enter first coordinate for the ",
      next_coord: "Enter next coordinate for the ",
      shot: "Enter coordinate for your shot:",
    }
  end

  def helpful_error_messages
    {
      no_fun: "That won't be any fun. You can have 2.",
      existing_space: "Must be an existing space on the board in format 'A1'.",
      other_ships: "They also can't be placed on top of other ships.",
      exit: "(Type 'exit' to return to Main Menu)",
      cell_shot: "You've already fired on this cell!"
    }
  end

  def feedback_messages
    {
      taunt: "Ha! Your shot on",
      miss: "was a miss...",
      one_more: "Shoot! One more hit and you've sunk that one...",
      damn: "Damn! Your shot on",
      hit: "was a hit!!!",
      shot_on1: "Looks like my shot on",
      shot_on2: "Aha! My shot on"
    }
  end

  def sunk_messages
    {
      comp_sunk: "*** YOU SUNK MY BATTLESHIP!!! ***",
      player_sunk: "*** I SUNK YOUR BATTLESHIP!!! ***"
    }
  end

  def upper_boarder_display
    puts ''
    puts ''
    puts "-" * 20
  end

  def lower_boarder_display
    puts "-" * 20
    puts ''
    puts ''
  end

  def menu_display
    puts "-" * 50
    puts "Welcome to BATTLESHIP"
    puts "Enter 'p' to play. Enter 'q' to quit."
    puts "-" * 50
  end

  def quit_display
    print "We could've made some memories"
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(1.2)
    print " oh well."
    puts ''
  end

  def player_board_display
    puts "* PLAYER BOARD *"
    puts "-" * 20
  end

  def comp_board_display
    puts ("=" * 10) + "COMPUTER BOARD" + ("=" * 10)
  end

  def comp_turn_display
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(1)
    puts ''
    comp_board_display()
  end

  def player_turn_display
    puts ''
    puts ("=" * 10) + "PLAYER BOARD" + ("=" * 12)
  end

  def loser_display
    puts ''
    puts '-' * 50
    puts "You lose... better luck next time!"
    puts '-' * 50
    puts ''
  end

  def winner_display
    puts ''
    puts '*' * 50
    puts "You win!!!"
    puts '*' * 50
    puts ''
  end

  def tie_display
    puts ''
    puts '-' * 50
    print "You tied"
    sleep(0.3)
    print " ."
    sleep(0.3)
    print " ."
    sleep(0.3)
    print " ."
    sleep(1)
    puts " how unsatisfying."
    puts '-' * 50
    puts ''
  end

  def thinking_display
    sleep(0.3)
    print ''
    print '.'
    sleep(0.3)
    print '.'
    sleep(0.3)
    print '.'
  end

end
