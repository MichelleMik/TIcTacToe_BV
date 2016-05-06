#require 'pry'
module TicTacToe
  class Cell
    attr_accessor :val

    def initialize(value = " ")
      @val = value
    end
  end

  class Player
    attr_reader :name, :char

    def initialize(name, char)
      @name = name
      @char = char
    end
 

end

  class GameBoard

  attr_reader :grid

    def initialize
      @grid =  default
    end

    def get_cell_coordinates(x,y)
      @grid[x][y]
    end

    def set_cell(x,y, char)
      get_cell_coordinates(x,y).val = char
    end

    def available_spaces
        @grid.select do |row|
    end

    def winner?
      #binding.pry
      diagonal_wins? || row_wins? || column_wins?
    end

     def tie?
      !(@grid.flatten.find{|cell| cell.val == " "})
    end


    def game_done?
      winner? || tie? ? true : false
    end

    def reset_board
      @grid = default
    end
    
 
    def default
      Array.new(3){ Array.new(3) { Cell.new}}
      # n = 1
      # row_size = 0
      # column_size = 0
      # grid = []
      # while row_size < 3
      #   arr = []
      #   while column_size < 3
      #     arr << Cell.new(n)
      #     n+=1
      #     column_size +=1
      #   end
      #   grid << arr
      # row_size += 1
      # end
      # grid
    end
         
   
    def diagonal_wins?

      diagonals = []
      right_diag = [@grid[0][0].val, @grid[1][1].val, @grid[2][2].val]
   
      left_diag = [@grid[0][2].val, @grid[1][1].val, @grid[2][0].val]
      diagonals << right_diag
      diagonals << left_diag
      diags_new = diagonals.map{|diag| diag.reject{|item| item == ' '}.compact}
  
      diag_wins = diags_new.find{|diag| diag.size == 3 && diag.uniq.size == 1}
      diag_wins ? true : false
    end

    def row_wins?

      rows = []
      x = 0
      while x < 3
        rows << [@grid[x][0].val, @grid[x][1].val, @grid[x][2].val]
        x+=1
      end
      rows_unique = rows.map do |row|
      row.reject{|item| item == ' '}
      end
      
      row_wins = rows_unique.find{|row| row.size == 3 && row.uniq.size == 1}

      row_wins ? true : false
      end


    def column_wins?
      columns = []
      y = 0
      while y < 3
        columns << [@grid[0][y].val, @grid[1][y].val, @grid[2][y].val]
        y += 1
      end
      columns_unique = columns.map do |column|
        column.reject{|item| item == ' '}.compact
      end
      column_wins = columns_unique.find{|row| row.size == 3 && row.uniq.size == 1}

      column_wins ? true : false
    end

  end

  class Game
    attr_accessor :players, :board, :current_player, :next_player

    def initialize(players, board = GameBoard.new)
      @players = players
      @board = board
      @current_player, @next_player = players.shuffle
    end

    def next_player
      @current_player, @next_player = @next_player, @current_player
    end

    def ask_current_player_move
      puts "#{@current_player.name}, choose a number from the grid to make your turn"
    end

    def get_current_players_move
      move = gets.chomp.to_i
    end

    def convert_move
      the_move = get_current_players_move
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
      moves[the_move]
    end

    def game_over
      
       puts "#{@current_player.name} won" if @board.winner?
        puts "Its a tie!" if @board.tie?
    end

    def show_board                    
    puts " #{@board.grid[0][0].val} | #{@board.grid[0][1].val} | #{@board.grid[0][2].val}"
    puts "-----------"
    puts " #{@board.grid[1][0].val} | #{@board.grid[1][1].val} | #{@board.grid[1][2].val}"
    puts "-----------"
    puts " #{@board.grid[2][0].val} | #{@board.grid[2][1].val} | #{@board.grid[2][2].val}"
    end

    def play_again
      puts "Would like to play again? y/n"
      play_again_input
    end

    def play_again_input
      input = gets.chomp.downcase
      if input == 'y'
        true
      elsif input == 'n'
        return
      else
        puts "Please enter valid response : y/n"
        play_again_input
      end
    end

    


    def play
      puts "#{@current_player.name} has randomly been selected as the first player"
        keep_playing = true
        while keep_playing
          show_board
          ask_current_player_move
          moves_convert = convert_move
          @board.set_cell(moves_convert[0],moves_convert[1], @current_player.char)
            if @board.game_done?
              game_over
              show_board
              sleep 0.5
              keep_playing = play_again
              @board.reset_board
            else
              next_player
            end
        end
      end

  end 
end

  


