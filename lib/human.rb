require_relative 'player.rb'

class Human < Player

  def initialize(board)
    super(board)
    @name = "human"
    @char = 'x'
  end
  
  def get_player_details
    name = gets.chomp
  end

  def play_again_input
    input = gets.chomp.downcase
    if input == 'y'
      true
    elsif input == 'n'
      false
    else
      puts "Please enter valid response : y/n"
      play_again_input
    end
  end

  def get_current_players_move
    move = gets.chomp.to_i
    if @board.available_spaces.include?(move)
    else
      "Try again, this space is taken!"
      get_current_players_move
    end
    move
  end

end