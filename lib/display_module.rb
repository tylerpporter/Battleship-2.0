require 'pastel'
require 'tty-font'

module Display



  @@text =
      {
        1 =>"Invalid Option!!! Try again...",
        2 =>"Let's begin...",
        3 =>"Enter grid height (3 - 26):",
        4 =>"Invalid height",
        5 =>"Enter grid width (3 - 9):",
        6 =>"Invalid width",
        7 =>"How many ships do you want?",
        8 =>"Invalid number of ships. You can have 2.",
        9 =>"That won't be any fun. You can have 2.",
        10 =>"Enter name for ship ",
        11 =>"Enter length of the ",
        12 =>"Invalid length. The ship needs to be able to fit on the board.",
        13 =>"Now, pick where you want to place your ships.",
        14 =>"Enter first coordinate for the ",
        15 =>"Enter next coordinate for the ",
        16 =>"Invalid coordinate.",
        17 =>"Must be an existing space on the board in format 'A1'.",
        18 =>"Invalid coordinates. Coordinates cannot be diagonal or skip cells.",
        19 =>"They also can't be placed on top of other ships.",
        20 =>"Enter coordinate for your shot:",
        21 =>"Invalid coordinate... ",
        22 =>"(Type 'exit' to return to Main Menu)",
        23 =>"You've already fired on this cell!",
        24 =>"Ha! Your shot on",
        25 =>"was a miss...",
        26 =>"Shoot! One more hit and you've sunk that one...",
        27 =>"Damn! Your shot on",
        28 =>"was a hit!!!",
        29 =>"*** YOU SUNK MY BATTLESHIP!!! ***",
        30 =>"Looks like my shot on",
        31 =>"Aha! My shot on",
        32 =>"*** I SUNK YOUR BATTLESHIP!!! ***",
      }

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
    puts ''
    puts ''
    puts "-" * 20
    puts "* PLAYER BOARD *"
    puts "-" * 20
    puts @player_board.render(true)
    puts "-" * 20
    puts ''
    puts ''
  end

  def comp_board_display
    puts ''
    puts ("=" * 10) + "COMPUTER BOARD" + ("=" * 10)
    puts @game_setup.comp_board.render(true)
    puts ''
  end

  def turn_display
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(1)
    puts ''
    puts ("=" * 10) + "COMPUTER BOARD" + ("=" * 10)
    puts @game_setup.comp_board.render
    puts ''
    puts ("=" * 10) + "PLAYER BOARD" + ("=" * 12)
    puts @game_setup.player_board.render(true)
    puts ''
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
