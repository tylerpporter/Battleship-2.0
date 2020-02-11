require './lib/main_menu.rb'
require './lib/game_setup.rb'
require './lib/display_module.rb'

class Game
  include Display
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

        turn_display()

        loop do
          puts @@text[20]
          player_shot = gets.chomp().upcase
          if !@game_setup.comp_board.valid_coordinate?(player_shot) &&
            player_shot != 'EXIT' && player_shot != 'UPDOWNABA'
            print @@text[21]
            puts "try #{@game_setup.comp_board.cells.keys.sample}."
            puts @@text[22]
          elsif all_player_shots.any? {|shot| shot == player_shot}
            puts @@text[23]
            puts @@text[22]
          elsif player_shot == 'UPDOWNABA'
            comp_board_display()
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

        thinking_display()

        if @game_setup.comp_board.cells[player_shot].ship.nil?
          puts @@text[24] + " #{player_shot} " + @@text[25]
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          !@game_setup.comp_board.cells[player_shot].ship.sunk? &&
          comp_ships.any? {|ship| ship.health == 1}
          puts @@text[26]
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          !@game_setup.comp_board.cells[player_shot].ship.sunk?
          puts @@text[27] + " #{player_shot} " + @@text[28]
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          @game_setup.comp_board.cells[player_shot].ship.sunk?
          puts @@text[29]
        end

        puts ''

        if @game_setup.player_board.cells[comp_shot].ship.nil?
          puts @@text[30] + " #{comp_shot} " + @@text[25]
        elsif !@game_setup.player_board.cells[comp_shot].ship.nil? &&
          !game_setup.player_board.cells[comp_shot].ship.sunk?
          puts @@text[31] + " #{comp_shot} " + @@text[28]
        elsif !@game_setup.player_board.cells[comp_shot].ship.nil? &&
          game_setup.player_board.cells[comp_shot].ship.sunk?
          puts @@text[32]
        end

        break if player_ships.all?(&:sunk?) || comp_ships.all?(&:sunk?)

      end

      if player_ships.all?(&:sunk?) && comp_ships.all?(&:sunk?)
        tie_display()
      elsif comp_ships.all?(&:sunk?)
        winner_display()
      elsif player_ships.all?(&:sunk?)
        loser_display()
      end

      start()

    elsif @menu.user_decision == 'q'
    end
  end

end
