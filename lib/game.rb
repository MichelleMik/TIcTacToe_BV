require_relative 'player.rb'
require_relative 'gameboard.rb'
require_relative 'cell.rb'
require 'pry'

class Game
  attr_accessor :player,:computer, :players, :board, :current_player, :next_player

  def initialize(board = GameBoard.new)
    @board = board
    @player = Human.new(@board)
    @computer = Computer.new(@board)
    @players = [@player, @computer]
    random_first_player
  end

  def random_first_player
    @current_player = @players.sample
  end

  def next_player
    @current_player == @player ? @current_player = @computer : @current_player = @player
  end


  def send_computer_move_to_convert
    convert_move(@current_player.computer_move)
  end

  def ask_current_players_move
    puts "#{@current_player.name}, choose a number from the grid to make your turn" 
    move = @current_player.get_current_players_move
    convert_move(move)
  end 


  def prompt_for_player_name
    puts "please enter your name"
    @player.get_player_details
  end


  def convert_move(move)
    @board.available_spaces -= [move]
    return @board.grid_hash[move]
  end
    

  def game_over
    if (@board.winner? && @board.tie?) || @board.winner?
      puts "#{@current_player.name} won"
    else
     puts "Its a tie!"
    end 
  end

  def show_board                    
    puts "   #{@board.grid[0][0].val} |  #{@board.grid[0][1].val} |   #{@board.grid[0][2].val}"
    puts "--------------------"
    puts "   #{@board.grid[1][0].val} |  #{@board.grid[1][1].val} |   #{@board.grid[1][2].val}"
    puts "----------------"
    puts "   #{@board.grid[2][0].val} |  #{@board.grid[2][1].val} |   #{@board.grid[2][2].val}"
  end

  def play_again
    puts "Would like to play again? y/n"
    input = @player.play_again_input
  end

 

   
  def play_sequence
    show_board
    @current_player == @player ? move = ask_current_players_move : move = send_computer_move_to_convert
    @board.set_cell(move[0],move[1], @current_player.char)
  end

  def game_over_sequence
    game_over
    show_board
    sleep 1.0    
    @board.reset_board 
  end

  def setup_game
    menu
    @player.name = prompt_for_player_name
  end

  def menu
    puts "Welcome to Tic-Tac-Toe"
  end


  def play 
    setup_game
    puts "#{@current_player.name} has randomly been selected as the first player"
    keep_playing = true
    while keep_playing
      play_sequence
      if @board.game_done? 
        game_over_sequence
        keep_playing = play_again
      else
        sleep 1.0
        next_player
      end
    end
  end
end