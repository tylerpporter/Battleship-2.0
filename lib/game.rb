require './lib/main_menu.rb'
require './lib/game_setup.rb'

class Game
  attr_reader :menu, :game_setup

  def initialize
    @menu = MainMenu.new
    @game_setup = GameSetup.new
  end

  def start
    @menu.start
    if @menu.user_decision == 'p'
      @game_setup.start
      @game_setup.create_ships
      @game_setup.place_comp_ships
      @game_setup.place_player_ships

      comp_ships = @game_setup.comp_ships
      player_ships = @game_setup.player_ships
      all_player_shots = []
      all_comp_shots = []

      loop do
        player_shot = nil
        comp_shot = nil

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

        loop do
          puts "Enter coordinate for your shot:"
          player_shot = gets.chomp().upcase
          if !@game_setup.comp_board.valid_coordinate?(player_shot) &&
            player_shot != 'EXIT' && player_shot != 'UPDOWNABA'
            print "Invalid coordinate... "
            puts "try #{@game_setup.comp_board.cells.keys.sample}."
            puts "(Type 'exit' to return to Main Menu)"
          elsif all_player_shots.any? {|shot| shot == player_shot}
            puts "You've already fired on this cell!"
            puts "(Type 'exit' to return to Main Menu)"
          elsif player_shot == 'UPDOWNABA'
            puts ''
            puts ("=" * 10) + "COMPUTER BOARD" + ("=" * 10)
            puts @game_setup.comp_board.render(true)
            puts ''
          end
          break if @game_setup.comp_board.valid_coordinate?(player_shot) &&
          all_player_shots.none? {|shot| shot == player_shot} ||
          player_shot == "EXIT"
        end

        break if player_shot == 'EXIT'

        @game_setup.comp_board.cells[player_shot].fire_upon
        all_player_shots << player_shot

        cells_with_ships = @game_setup.player_board.cells.values.select do |cells|
          !cells.ship.nil?
        end

        cells_with_hit_ships = cells_with_ships.select do |cells|
          (cells.ship.health < cells.ship.length) && !cells.ship.sunk?
        end

# require "pry"; binding.pry
        if cells_with_hit_ships.empty?
          loop do
            comp_shot = @game_setup.player_board.cells.keys.sample
            break if all_comp_shots.none? {|shot| shot == comp_shot}
          end
        elsif !cells_with_hit_ships.empty?
          hit_cells = cells_with_ships.select do |cell|
            cell.ship.health < cell.ship.length
          end
          hit_cells_hsh = hit_cells.group_by(&:coordinate)
          loop do
            comp_shot = hit_cells_hsh.keys.sample
            break if all_comp_shots.none? {|shot| shot == comp_shot}
          end
        end

        @game_setup.player_board.cells[comp_shot].fire_upon
        all_comp_shots << comp_shot

        sleep(0.3)
        print ''
        print '.'
        sleep(0.3)
        print '.'
        sleep(0.3)
        print '.'

        if @game_setup.comp_board.cells[player_shot].ship.nil?
          puts "Ha! Your shot on #{player_shot} was a miss..."
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          !@game_setup.comp_board.cells[player_shot].ship.sunk? &&
          comp_ships.any? {|ship| ship.health == 1}
          puts "Shoot! One more hit and you've sunk that one..."
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          !@game_setup.comp_board.cells[player_shot].ship.sunk?
          puts "Damn! Your shot on #{player_shot} was a hit!!!"
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          @game_setup.comp_board.cells[player_shot].ship.sunk?
          puts "*** YOU SUNK MY BATTLESHIP!!! ***"
        end

        break if comp_ships.all?(&:sunk?)

        puts ''

        if @game_setup.player_board.cells[comp_shot].ship.nil?
          puts "Looks like my shot on #{comp_shot} was a miss..."
        elsif !@game_setup.player_board.cells[comp_shot].ship.nil? &&
          !game_setup.player_board.cells[comp_shot].ship.sunk?
          puts "Aha! My shot on #{comp_shot} was a hit!"
        elsif !@game_setup.player_board.cells[comp_shot].ship.nil? &&
          game_setup.player_board.cells[comp_shot].ship.sunk?
          puts "*** I SUNK YOUR BATTLESHIP!!! ***"
        end

        break if player_ships.all?(&:sunk?)

      end

      if player_ships.all?(&:sunk?)
        puts ''
        puts '-' * 50
        puts "You lose... better luck next time!"
        puts '-' * 50
        puts ''
      elsif comp_ships.all?(&:sunk?)
        puts ''
        puts '*' * 50
        puts "You win!!!"
        puts '*' * 50
        puts ''
      end

      start()

    elsif @menu.user_decision == 'q'
    end
  end

end
