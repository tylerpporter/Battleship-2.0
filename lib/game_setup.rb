require './lib/board.rb'
require './lib/ship.rb'

class GameSetup
  attr_reader :comp_board, :player_board, :player_ships, :comp_ships

  def start
    @height = nil
    @width = nil
    loop do
      puts "Enter grid height (2 - 9):"
      @height = gets.chomp().to_i
      break if (2..9) === @height
      puts "Invalid height"
    end
    loop do
      puts "Enter grid width (2 - 9):"
      @width = gets.chomp().to_i
      break if (2..9) === @width
      puts "Invalid width"
    end
    @comp_board = Board.new(@height, @width)
    @player_board = Board.new(@height, @width)
    @player_ships = []
    @comp_ships = []
  end

  def create_ships
    puts "How many ships do you want?"
    num_player_ships = gets.chomp().to_i
    if num_player_ships > @comp_board.new_board.height ||
      num_player_ships > @comp_board.new_board.width
      puts "Invalid number of ships. You can have 2."
      num_player_ships = 2
    end
# generates player ships
    ship_nums = (1..num_player_ships)
    player_ships_hsh = {}
    ship_nums.each do |ship|
      puts "Enter name for ship #{ship}:"
      name = gets.chomp().to_s
      length = nil
      loop do
        puts "Enter length of the #{name}:"
        length = gets.chomp().to_i
        break if length > 0 && (length <= @comp_board.new_board.height ||
        length <= @comp_board.new_board.height)
        puts "Invalid length. The ship needs to be able to fit on the board."
      end
      player_ships_hsh[name] = length
    end

    player_ships_hsh.each do |ship_name, ship_length|
      @player_ships << ship_name = Ship.new(ship_name, ship_length)
    end
# generates computer ships
    comp_ships_hsh = {}
    ship_nums.each do |ship|
      name = "Ship" + ship.to_s
      length = rand(2..@comp_board.new_board.width)
      comp_ships_hsh[name] = length
    end

    comp_ships_hsh.each do |ship_name, ship_length|
      @comp_ships << ship_name = Ship.new(ship_name, ship_length)
    end

  end
end
