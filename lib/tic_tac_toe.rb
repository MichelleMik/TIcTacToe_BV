
module TicTacToe
  class Cell
    attr_accessor :val, :char

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
    def initialize(input = {})
      @grid = input.fetch(:grid, default)
    end

    def get_cell_coordinates(x,y)
      grid[x][y]
    end

    def set_cell(x,y, char)
      get_cell_coordinates(x,y).val = char
    end

    def game_done
      case grid
      when winner?
       :winner
      when tie?
        :tie
      else
        false
      end
    end

    private
 
    def default
      Array.new(3) { Array.new(3) { Cell.new } }
    end

    def tie?
      !(grid.flatten.find{|cell| cell.val == " "})
    end

    def winner?
      win_type ? true : false  
    end

    def win_type
      if diagonal_wins
        diagonal_wins
      elsif row_wins
        row_wins
      elsif column_wins
        column_wins
      else
        false
      end
    end

    def diagonal_wins
      right_diag = [@grid[0,0], @grid[1,1], @grid[2,2]].uniq
      left_diag = [@grid[0,2], @grid[1,1], @grid[3,0]].uniq
      if right_diag.size  == 1
        return right_diag.to_s
      elsif left_diag.size == 1
        return left_diag.to_s
      else
       return false
      end
    end

    def row_wins
      rows = []
      x = 0
      while x < 3
        rows << [@grid[x][0], @grid[x][1], @grid[x][2]]
        x+=1
      end
      rows_unique = rows.find{|row|row.uniq == 1} ? rows_unique.to_s : false
    end


    def column_wins
      columns = []
      y = 0
      while y < 3
        columns << [@grid[0][y], @grid[1][y], @grid[2][y]]
        y += 1
      end
      columns_unique = columns.find{|row|row.uniq == 1} ? columns_unique.to_s : false
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
      moves =  {
      1 => [0, 0],
      2 => [0,1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1],
      6 => [1, 2],
      7 => [2, 0],
      8 => [2, 1],
      9 => [2, 2]
      }
      moves[get_current_players_move]
    end

    def game_over
      return "#{@current_player.name}" if board.winner?
      return "Its a tie!" if board.tie?
    end

    def show_board                    
    puts " #{@board.grid[0][0].val} | #{@board.grid[0][1].val} | #{@board.grid[0][2].val}"
    puts "-----------"
    puts " #{@board.grid[1][0].val} | #{@board.grid[1][1].val} | #{@board.grid[1][2].val}"
    puts "-----------"
    puts " #{@board.grid[2][0].val} | #{@board.grid[2][1].val} | #{@board.grid[2][2].val}"
    end

    def play
    puts "#{current_player.name} has randomly been selected as the first player"
      while true
        #board.formatted_grid
        show_board
        ask_current_player_move
        moves_convert = convert_move
        board.set_cell(moves_convert[0],moves_convert[1], @current_player.char)
          if board.game_done
            game_over
            board.show_board
            return
          else
            next_player
          end
      end
    end

  end 

end

  


