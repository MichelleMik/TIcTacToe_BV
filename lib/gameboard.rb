require_relative 'game.rb'
require_relative 'cell.rb'
require_relative 'player.rb'
require 'pry'

class GameBoard
  attr_reader :grid, :length 
  attr_accessor :available_spaces

  def initialize
    reset_board
    @length = @grid.length
  end

  def get_cell_coordinates(x,y)
    @grid[x][y]
  end

  def set_cell(x,y, char)
    cell = get_cell_coordinates(x,y)
    cell.val = char
  end
    


  def winner?
    diagonal_wins? || anti_diagonal_wins? || column_or_row_wins?("row") || column_or_row_wins?("column")
  end

  def tie?
    @available_spaces.size == 0
  end


  def game_done?
    winner? || tie? ? true : false
  end

  def reset_board
    @grid = default
    @available_spaces = grid_hash.keys
  end
    
  def grid_hash
    moves =  {
    1 => [0,0],
    2 => [0,1],
    3 => [0,2],
    4 => [1,0],
    5 => [1,1],
    6 => [1,2],
    7 => [2,0],
    8 => [2,1],
    9 => [2,2]
    }
  end

  def default
    new_moves = grid_hash.keys.map{|move|Cell.new(move)}
    newest = new_moves.each_slice(3).to_a
  end

  def diagonal_wins
    diag_chars = Array.new(@length).each_with_index.map do |char, i| 
      @grid[i][i].val
    end
    diag_chars
  end

         
  def diagonal_wins?
    if diagonal_wins
      diagonal = diagonal_wins.reject{|item| item.is_a? Integer} 
    end
    diagonal.size == @length && diagonal.uniq.size == 1
  end

  def anti_diagonal_wins
    anti_diag_chars = Array.new(@length).each_with_index.map do |char, i|
      @grid[i][(@length-1)-i].val
    end
    anti_diag_chars
  end
  
  def anti_diagonal_wins?
    if anti_diagonal_wins
      anti_diagonal = anti_diagonal_wins.reject{|item| item.is_a? Integer} 
    end
    anti_diagonal.size == @length && anti_diagonal.uniq.size == 1 
  end

  

  def block_row_wins
    rows = []
    @grid.each_with_index do |row,i|
       char_row = row.map{|item| item.val}
       rows << char_row
    end
    rows
  end
  
 

  def block_column_wins
    columns = []
    (0..@length-1).each do |i|
      char_column = @grid.map{|item|item[i].val}
      columns << char_column
    end
     columns
  end
  

  def column_or_row_wins?(type)
    method = self.send("block_#{type}_wins")
    wins = method.find{|item| item.uniq.size == 1}
    if wins
      non_int_wins = wins.reject{|item|item.is_a? Integer}
      non_int_wins ? true : false
    else
      false
    end
  end

end
