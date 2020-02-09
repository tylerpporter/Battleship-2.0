require './lib/board.rb'
require './lib/ship.rb'
require './lib/smart_comp.rb'

class GameSetup
  attr_reader :comp_board, :player_board, :player_ships, :comp_ships

  def start
    @height = nil
    @width = nil
    loop do
      puts "Enter grid height (2 - 26):"
      @height = gets.chomp().to_i
      break if (2..26) === @height
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
    elsif num_player_ships.zero?
      puts "That won't be any fun. You can have 2."
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
        break if length > 0 && length <= @comp_board.new_board.height ||
        length <= @comp_board.new_board.width
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

  def place_comp_ships
    @comp_ships.each do |ship|
      root_key = SmartComp.new(@comp_board.cells.keys.sample)
      coordinates = [root_key.current_key]
      current_key = root_key
      (ship.length - 1).times do
        if !@comp_board.valid_coordinate?(current_key.left_key)
          current_key = root_key
          if @comp_board.valid_coordinate?(current_key.right_key) &&
            !coordinates.include?(current_key.right_key)

            coordinates << current_key.right_key
            current_key = SmartComp.new(current_key.right_key)
          end
        elsif !@comp_board.valid_coordinate?(current_key.right_key)
          current_key = root_key
          if @comp_board.valid_coordinate?(current_key.left_key) &&
            !coordinates.include?(current_key.left_key)
          end

        elsif @comp_board.valid_coordinate?(current_key.left_key) &&
          !coordinates.include?(current_key.left_key)

          coordinates << current_key.left_key
          current_key = SmartComp.new(current_key.left_key)

        elsif @comp_board.valid_coordinate?(current_key.right_key) &&
          !coordinates.include?(current_key.right_key)

          coordinates << current_key.right_key
          current_key = SmartComp.new(current_key.right_key)
        end
      end

      if coordinates.size == ship.length
        @comp_board.place(ship, coordinates.sort)
      end
    end
  end


# This method is the problem. It's taking too long to find a valid placement for
# larger grids.
  # def place_comp_ships
  #   @comp_ships.each do |ship|
  #     coordinates = []
  #     loop do
  #       coordinates = []
  #       (ship.length).times do
  #         coordinates << @comp_board.cells.keys.sample
  #       end
  #       break if @comp_board.valid_placement?(ship, coordinates.sort) ||
  #       @comp_board.valid_placement?(ship, coordinates.sort_by {|key| key[1]})
  #     end
  #     @comp_board.place(ship, coordinates)
  #   end
  # end

  def place_player_ships
    puts "Now, pick where you want to place your ships. "
    @player_ships.each do |ship|
      puts ''
      puts ''
      puts "-" * 20
      puts "* PLAYER BOARD *"
      puts "-" * 20
      puts @player_board.render(true)
      puts "-" * 20
      puts ''
      puts ''
      coordinates = []
      (loop do
        coordinates = []
        (ship.length).times do
          if coordinates == []
            puts "Enter first coordinate for the #{ship.name}:"
          elsif coordinates.size >= 1
            puts "Enter next coordinate for the #{ship.name}:"
          end

          user_coordinate = gets.chomp().upcase

          if !@player_board.valid_coordinate?(user_coordinate)
            puts "Invalid coordinate."
            puts "Must be an existing space on the board in format 'A1'."
          elsif @player_board.valid_coordinate?(user_coordinate)
            coordinates << user_coordinate
          end
          break if !@player_board.valid_coordinate?(user_coordinate)
        end
        break if @player_board.valid_placement?(ship, coordinates)
        if coordinates.size == ship.length
          puts "Invalid coordinates. Coordinates cannot be diagonal or skip cells."
          puts "They also can't be placed on top of other ships."
        end
      end)
      @player_board.place(ship, coordinates)
    end
  end

end
