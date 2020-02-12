require './lib/main_menu.rb'
require './lib/game_setup.rb'
require './lib/display_module.rb'

class Game
  include Display
  attr_reader :menu, :game_setup

  def initialize
    @menu = MainMenu.new
    @game_setup = GameSetup.new
    @comp_ships = []
    @player_ships = []
    @player_shot = nil
    @comp_shot = nil
    @all_player_shots = []
    @all_comp_shots = []
  end

  def player_shot_coordinate
    loop do
      puts @@text[20]
      @player_shot = gets.chomp().upcase
      if !@game_setup.comp_board.valid_coordinate?(@player_shot) &&
        @player_shot != 'EXIT' && @player_shot != 'UPDOWNABA'
        print @@text[21]
        puts "try #{@game_setup.comp_board.cells.keys.sample}."
        puts @@text[22]
      elsif @all_player_shots.any? {|shot| shot == @player_shot}
        puts @@text[23]
        puts @@text[22]
      elsif @player_shot == 'UPDOWNABA'
        comp_board_display()
      end
      break if @game_setup.comp_board.valid_coordinate?(@player_shot) &&
      @all_player_shots.none? {|shot| shot == @player_shot} ||
      @player_shot == "EXIT"
    end
  end

  def player_fire
    @game_setup.comp_board.cells[@player_shot].fire_upon
    @all_player_shots << @player_shot
  end

  def cells_with_ships
    @game_setup.player_board.cells.values.select do |cells|
      !cells.ship.nil?
    end
  end

  def cells_with_hit_ships
    cells_with_ships().select do |cells|
      (cells.ship.health < cells.ship.length) && !cells.ship.sunk?
    end
  end

  def comp_shot_coordinates
    if cells_with_hit_ships().empty?
      loop do
        @comp_shot = @game_setup.player_board.cells.keys.sample
        break if @all_comp_shots.none? {|shot| shot == @comp_shot}
      end
    elsif !cells_with_hit_ships().empty?
      hit_cells = cells_with_ships().select do |cell|
        cell.ship.health < cell.ship.length
      end
      hit_cells_hsh = hit_cells.group_by(&:coordinate)
      loop do
        @comp_shot = hit_cells_hsh.keys.sample
        break if @all_comp_shots.none? {|shot| shot == @comp_shot}
      end
    end
  end

  def comp_fire
    @game_setup.player_board.cells[@comp_shot].fire_upon
    @all_comp_shots << @comp_shot
  end

  def player_feedback
    if @game_setup.comp_board.cells[@player_shot].ship.nil?
      puts @@text[24] + " #{@player_shot} " + @@text[25]
    elsif !@game_setup.comp_board.cells[@player_shot].ship.nil? &&
      !@game_setup.comp_board.cells[@player_shot].ship.sunk? &&
      @comp_ships.any? {|ship| ship.health == 1}
      puts @@text[26]
    elsif !@game_setup.comp_board.cells[@player_shot].ship.nil? &&
      !@game_setup.comp_board.cells[@player_shot].ship.sunk?
      puts @@text[27] + " #{@player_shot} " + @@text[28]
    elsif !@game_setup.comp_board.cells[@player_shot].ship.nil? &&
      @game_setup.comp_board.cells[@player_shot].ship.sunk?
      puts @@text[29]
    end
  end

  def comp_feedback
    if @game_setup.player_board.cells[@comp_shot].ship.nil?
      puts @@text[30] + " #{@comp_shot} " + @@text[25]
    elsif !@game_setup.player_board.cells[@comp_shot].ship.nil? &&
      !@game_setup.player_board.cells[@comp_shot].ship.sunk?
      puts @@text[31] + " #{@comp_shot} " + @@text[28]
    elsif !@game_setup.player_board.cells[@comp_shot].ship.nil? &&
      @game_setup.player_board.cells[@comp_shot].ship.sunk?
      puts @@text[32]
    end
  end

  def end_game
    if @player_ships.all?(&:sunk?) && @comp_ships.all?(&:sunk?)
      tie_display()
    elsif @comp_ships.all?(&:sunk?)
      winner_display()
    elsif @player_ships.all?(&:sunk?)
      loser_display()
    end
  end

  def turn
    loop do
      @player_shot = nil
      @comp_shot = nil
      turn_display()
      player_shot_coordinate()
      break if @player_shot == 'EXIT'
      player_fire()
      comp_shot_coordinates()
      comp_fire()
      thinking_display()
      player_feedback()
      puts ''
      comp_feedback()
      break if @player_ships.all?(&:sunk?) || @comp_ships.all?(&:sunk?)
    end
  end

  def start
    @menu.start
    if @menu.user_decision == 'p'
      @game_setup.start
      @game_setup.create_ships
      @game_setup.place_comp_ships
      @game_setup.place_player_ships
      @comp_ships = @game_setup.comp_ships
      @player_ships = @game_setup.player_ships
      @all_player_shots = []
      @all_comp_shots = []
      turn()
      end_game()
      start()
    elsif @menu.user_decision == 'q'
    end
  end

end
