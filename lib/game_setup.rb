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
      puts setup_messages[:grid_h]
      @height = gets.chomp().to_i
      break if (3..26) === @height
      puts invalid_messages[:height]
    end
    loop do
      puts setup_messages[:grid_w]
      @width = gets.chomp().to_i
      break if (3..9) === @width
      puts invalid_messages[:width]
    end
    @comp_board = Board.new(@height, @width)
    @player_board = Board.new(@height, @width)
    @player_ships = []
    @comp_ships = []
  end

  def create_ships
    puts setup_messages[:ship_num]
    num_player_ships = gets.chomp().to_i
    if num_player_ships > @comp_board.new_board.height ||
      num_player_ships > @comp_board.new_board.width
      puts invalid_messages[:ships]
      num_player_ships = 2
    elsif num_player_ships.zero?
      puts helpful_error_messages[:no_fun]
      num_player_ships = 2
    end
# generates player ships
    ship_nums = (1..num_player_ships)
    player_ships_hsh = {}
    ship_nums.each do |ship|
      puts setup_messages[:ship_name] + "#{ship}:"
      name = gets.chomp().to_s
      length = nil
      loop do
        puts setup_messages[:ship_length] + "#{name}:"
        length = gets.chomp().to_i
        break if length > 0 && (length <= @comp_board.new_board.height ||
        length <= @comp_board.new_board.width)
        puts invalid_messages[:length]
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
    puts setup_messages[:placement]
    @player_ships.each do |ship|

      upper_boarder_display()
      player_board_display()
      puts @player_board.render(true)
      lower_boarder_display()

      coordinates = []
      (loop do
        coordinates = []
        (ship.length).times do
          if coordinates == []
            puts setup_messages[:first_coord] + "#{ship.name}:"
          elsif coordinates.size >= 1
            puts setup_messages[:next_coord] + "#{ship.name}:"
          end

          user_coordinate = gets.chomp().upcase

          if !@player_board.valid_coordinate?(user_coordinate)
            puts invalid_messages[:coordinate1]
            puts helpful_error_messages[:existing_space]
          elsif @player_board.valid_coordinate?(user_coordinate)
            coordinates << user_coordinate
          end
          break if !@player_board.valid_coordinate?(user_coordinate)
        end
        break if @player_board.valid_placement?(ship, coordinates)
        if coordinates.size == ship.length
          puts invalid_messages[:coordinates]
          puts helpful_error_messages[:other_ships]
        end
      end)
      @player_board.place(ship, coordinates)
    end
  end

end
