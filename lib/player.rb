require_relative 'game.rb'
require_relative 'gameboard.rb'
require_relative 'cell.rb'
require 'pry'

class Player

  attr_reader  :char 
  attr_accessor :name

  def initialize(board)
    @board = board
  end

end

# class Human < Player
#   def initialize(board)
#     super(board)
#     @name = "human"
#     @char = 'x'
#   end
#   def get_player_details
#     name = gets.chomp
#   end

#   def play_again_input
#     input = gets.chomp.downcase
#     if input == 'y'
#       true
#     elsif input == 'n'
#       false
#     else
#       puts "Please enter valid response : y/n"
#       play_again_input
#     end
#   end

#   def get_current_players_move
#     move = gets.chomp.to_i
#     if @board.available_spaces.include?(move)
#     else
#       "Try again, this space is taken!"
#       get_current_players_move
#     end
#     move
#   end

# end

# class Computer < Player
#   def initialize(board)
#     super(board)
#     @name = "computer"
#     @char = 'o'
#   end

#   def computer_about_to_lose_row_or_column(type)
#     method = @board.send("block_#{type}_wins")
#     keys = method.find{|item|item.uniq.size == 2 && item.any?{|item|item.is_a? Integer}}
#   end

#   def computer_about_to_lose_a_diag(type)
#     method = @board.send("#{type}_wins")
#     method.uniq.size == 2  &&  method.find{|item| item.is_a? Integer}  
#   end

#   def computer_move_to_block_row_or_column_win(type)
#       method = computer_about_to_lose_row_or_column(type)
#       move = method.find{|char| char.is_a? Integer}
#   end

#   def computer_move
#     puts "Computer's turn"
#     sleep 0.5
#     if computer_about_to_lose_row_or_column("row")
#       move = computer_move_to_block_row_or_column_win("row")
#     elsif computer_about_to_lose_row_or_column("column")
#       move = computer_move_to_block_row_or_column_win("column")
#     elsif computer_about_to_lose_a_diag("diagonal")
#       move = computer_about_to_lose_a_diag("diagonal")
#     elsif computer_about_to_lose_a_diag("anti_diagonal")
#       move = computer_about_to_lose_a_diag("anti_diagonal")
#     else
#      move = @board.available_spaces.sample
#     end
#     move
#   end
# end