require_relative 'player.rb'
class Computer < Player
  def initialize(board)
    super(board)
    @name = "computer"
    @char = 'o'
  end

  def computer_about_to_lose_row_or_column(type)
    method = @board.send("block_#{type}_wins")
    keys = method.find{|item|item.uniq.size == 2 && item.any?{|item|item.is_a? Integer}}
  end

  def computer_about_to_lose_a_diag(type)
    method = @board.send("#{type}_wins")
    method.uniq.size == 2  &&  method.find{|item| item.is_a? Integer}  
  end

  def computer_move_to_block_row_or_column_win(type)
      method = computer_about_to_lose_row_or_column(type)
      move = method.find{|char| char.is_a? Integer}
  end

  def computer_move
    puts "Computer's turn"
    sleep 0.5
    if computer_about_to_lose_row_or_column("row")
      move = computer_move_to_block_row_or_column_win("row")
    elsif computer_about_to_lose_row_or_column("column")
      move = computer_move_to_block_row_or_column_win("column")
    elsif computer_about_to_lose_a_diag("diagonal")
      move = computer_about_to_lose_a_diag("diagonal")
    elsif computer_about_to_lose_a_diag("anti_diagonal")
      move = computer_about_to_lose_a_diag("anti_diagonal")
    else
     move = @board.available_spaces.sample
    end
    move
  end
end