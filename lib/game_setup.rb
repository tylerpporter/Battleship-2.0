require './lib/board.rb'
require './lib/ship.rb'
require './lib/display_module.rb'

class GameSetup
  include Display
  attr_reader :comp_board, :player_board, :player_ships, :comp_ships

  def start
    @height = nil
    @width = nil
    loop do
      puts @@text[3]
      @height = gets.chomp().to_i
      break if (3..26) === @height
      puts @@text[4]
    end
    loop do
      puts @@text[5]
      @width = gets.chomp().to_i
      break if (3..9) === @width
      puts @@text[6]
    end
    @comp_board = Board.new(@height, @width)
    @player_board = Board.new(@height, @width)
    @player_ships = []
    @comp_ships = []
  end

  def create_ships
    puts @@text[7]
    num_player_ships = gets.chomp().to_i
    if num_player_ships > @comp_board.new_board.height ||
      num_player_ships > @comp_board.new_board.width
      puts @@text[8]
      num_player_ships = 2
    elsif num_player_ships.zero?
      puts @@text[9]
      num_player_ships = 2
    end
# generates player ships
    ship_nums = (1..num_player_ships)
    player_ships_hsh = {}
    ship_nums.each do |ship|
      puts @@text[10] + "#{ship}:"
      name = gets.chomp().to_s
      length = nil
      loop do
        puts @@text[11] + "#{name}:"
        length = gets.chomp().to_i
        break if length > 0 && (length <= @comp_board.new_board.height ||
        length <= @comp_board.new_board.width)
        puts @@text[12]
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
      length = rand(2..3)
      comp_ships_hsh[name] = length
    end

    comp_ships_hsh.each do |ship_name, ship_length|
      @comp_ships << ship_name = Ship.new(ship_name, ship_length)
    end
  end

  def place_comp_ships
    @comp_ships.each do |ship|
      coordinates = []
      loop do
        coordinates = []
        (ship.length).times do
          coordinates << @comp_board.cells.keys.sample
        end
        break if @comp_board.valid_placement?(ship, coordinates)
      end
      @comp_board.place(ship, coordinates)
    end
  end

  def place_player_ships
    puts @@text[13]
    @player_ships.each do |ship|
      player_board_display()
      coordinates = []
      (loop do
        coordinates = []
        (ship.length).times do
          if coordinates == []
            puts @@text[14] + "#{ship.name}:"
          elsif coordinates.size >= 1
            puts @@text[15] + "#{ship.name}:"
          end

          user_coordinate = gets.chomp().upcase

          if !@player_board.valid_coordinate?(user_coordinate)
            puts @@text[16]
            puts @@text[17]
          elsif @player_board.valid_coordinate?(user_coordinate)
            coordinates << user_coordinate
          end
          break if !@player_board.valid_coordinate?(user_coordinate)
        end
        break if @player_board.valid_placement?(ship, coordinates)
        if coordinates.size == ship.length
          puts @@text[18]
          puts @@text[19]
        end
      end)
      @player_board.place(ship, coordinates)
    end
  end

end
