require 'require_all'
require_all './lib'

class Game
  attr_reader :menu, :game_setup

  def initialize
    @menu = MainMenu.new
    @game_setup = GameSetup.new
    @turn = Turn.new
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

      loop do
        sleep(0.3)
        print "."
        sleep(0.3)
        print "."
        sleep(0.3)
        print "."
        sleep(1)
        all_player_shots = []
        all_comp_shots = []
        player_shot = nil
        comp_shot = nil
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
          break if @game_setup.comp_board.valid_coordinate?(player_shot)
          puts "Invalid coordinate... try #{@game_setup.comp_board.cells.keys.sample}."
        end
        @game_setup.comp_board.cells[player_shot].fire_upon
        all_player_shots << player_shot
        loop do
          comp_shot = @game_setup.player_board.cells.keys.sample
          break if all_comp_shots.none? {|shot| shot == comp_shot}
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
          puts "Shit! One more hit and you've sunk that one..."
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          !@game_setup.comp_board.cells[player_shot].ship.sunk?
          puts "Damn! Your shot on #{player_shot} was a hit!!!"
        elsif !@game_setup.comp_board.cells[player_shot].ship.nil? &&
          @game_setup.comp_board.cells[player_shot].ship.sunk?
          puts "*** YOU SUNK MY BATTLESHIP!!! ***"
        end
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
        break if player_ships.all?(&:sunk?) || comp_ships.all?(&:sunk?)
      end
    elsif @menu.user_decision == 'q'
    end
  end

end
