require './lib/board.rb'
require './lib/ship.rb'

class GameSetup
  attr_reader :computer_board, :player_board, :player_ships
  def initialize
    @height = nil
    @width = nil

    loop do
      puts "Enter grid height (1 - 9):"
      @height = gets.chomp().to_i
      break if (1..9) === @height
      puts "Invalid height"
    end
    loop do
      puts "Enter grid width (1 - 9):"
      @width = gets.chomp().to_i
      break if (1..9) === @width
      puts "Invalid width"
    end
    @computer_board = Board.new(@height, @width)
    @player_board = Board.new(@height, @width)
    @player_ships = []
  end

  def create_ships
    puts "How many ships do you want? (Up to 5)"
    num_player_ships = gets.chomp().to_i
    if num_player_ships > 5
      puts "Invalid number of ships. You can have 2."
      num_player_ships = 2
    end

    ship_nums = (1..num_player_ships)
    player_ships_hsh = {}
    ship_nums.each do |ship|
      puts "Enter name for ship #{ship}:"
      name = gets.chomp().to_s
      length = nil
      loop do
        puts "Enter length of the #{name} (2 or 3):"
        length = gets.chomp().to_i
        break if length == 2 || length == 3
        puts 'ONLY 2 OR 3!!!!'
      end
      player_ships_hsh[name] = length
    end

    player_ships_hsh.each do |ship_name, ship_length|
      @player_ships << ship_name = Ship.new(ship_name, ship_length)
    end

  end
end
