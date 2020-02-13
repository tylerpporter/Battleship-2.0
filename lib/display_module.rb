require 'pastel'
require 'tty-font'

module Display

  def pastel
    Pastel.new
  end

  def font(style)
    TTY::Font.new(style)
  end

  def invalid_messages
   {
      try_again: pastel.bold.magenta("Invalid Option!!! Try again..."),
      height: pastel.bold.magenta("Invalid height"),
      width: pastel.bold.magenta("Invalid width"),
      ships: pastel.bold.magenta("Invalid number of ships. You can have 2."),
      length: pastel.bold.magenta("Invalid length. The ship needs to be able to fit on the board."),
      coordinate1: pastel.bold.magenta("Invalid coordinate."),
      coordinates: pastel.bold.magenta("Invalid coordinates. Coordinates cannot be diagonal or skip cells."),
      coordinate2: pastel.bold.magenta("Invalid coordinate... ")
    }
  end

  def setup_messages
    {
      begin: pastel.italic.cyan("Let's begin..."),
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
      no_fun: pastel.italic.magenta("That won't be any fun. You can have 2."),
      existing_space: pastel.italic.magenta("Must be an existing space on the board in format 'A1'."),
      other_ships: pastel.italic.magenta("They also can't be placed on top of other ships."),
      exit: pastel.italic.magenta("(Type 'exit' to return to Main Menu)"),
      cell_shot: pastel.italic.magenta("You've already fired on this cell!")
    }
  end

  def feedback_messages
    {
      taunt: pastel.italic("Ha! Your shot on"),
      miss: pastel.italic.magenta("was a miss..."),
      one_more: pastel.bold("Shoot! One more"),
      that_one: pastel.bold(" and you've sunk that one..."),
      hit1: pastel.bold.magenta(" HIT"),
      damn: pastel.bold("Damn! Your shot on"),
      hit2: pastel.bold.bright_blue("was a hit!!!"),
      shot_on1: ("Looks like my shot on"),
      shot_on2: pastel.bold("Aha! My shot on")
    }
  end

  def sunk_messages
    {
      comp_sunk: pastel.bold.cyan("*** YOU SUNK MY BATTLESHIP!!! ***"),
      player_sunk: pastel.bold.magenta("*** I SUNK YOUR BATTLESHIP!!! ***")
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
    puts pastel.bright_blue("-" * 125)
    puts pastel.magenta(font(:straight).write("welcome    to"))
    puts ''
    puts pastel.bold.cyan(font("3d").write("BATTLESHIP"))
    puts ''
    p = pastel.cyan("P")
    q = pastel.cyan("Q")
    puts "Enter #{p} to play. Enter #{q} to quit."
    puts pastel.bright_blue("-" * 125)
  end

  def quit_display
    puts ''
    puts ''
    print "We could've made some memories"
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(1.2)
    puts ''
    puts ''
    print pastel.bright_blue(font(:standard).write(" OH    WELL."))
    puts ''
    puts ''
  end

  def player_board_display
    puts pastel.cyan("* PLAYER BOARD *")
    puts "-" * 20
  end

  def comp_board_display
    puts pastel.bright_blue("=" * 10) + pastel.magenta("COMPUTER BOARD") + pastel.bright_blue("=" * 10)
  end

  def comp_turn_display
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(1)
    puts ''
    comp_board_display()
  end

  def player_turn_display
    puts ''
    puts pastel.bright_blue("=" * 10) + pastel.cyan("PLAYER BOARD") + pastel.bright_blue("=" * 12)
  end

  def loser_display
    puts ''
    puts pastel.bright_blue('*' * 125)
    puts ''
    puts pastel.italic.magenta(font(:standard).write("YOU LOSE... BETTER LUCK NEXT TIME!"))
    puts ''
    puts pastel.bright_blue('*' * 125)
    puts ''
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(1)
    puts ''
  end

  def winner_display
    puts ''
    puts pastel.bright_blue('*' * 125)
    puts ''
    puts pastel.cyan(font(:standard).write("YOU WIN!!!"))
    puts ''
    puts pastel.bright_blue('*' * 125)
    puts ''
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(0.5)
    puts pastel.bright_blue('.')
    sleep(1)
    puts ''
  end

  def tie_display
    puts ''
    puts '-' * 50
    print pastel.italic("You tied")
    sleep(0.3)
    print " ."
    sleep(0.3)
    print " ."
    sleep(0.3)
    print " ."
    sleep(1)
    puts pastel.italic.bright_blue(" how unsatisfying.")
    puts '-' * 50
    puts ''
  end

  def thinking_display
    sleep(0.3)
    print ''
    print pastel.bright_blue('.')
    sleep(0.3)
    print pastel.bright_blue('.')
    sleep(0.3)
    print pastel.bright_blue('.')
  end

end
