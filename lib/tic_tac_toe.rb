require 'pry'
module TicTacToe
  class Cell
    attr_accessor :val

    def initialize(value = " ")
      @val = value
    end
  end

  class Player

    attr_reader  :char
    attr_accessor :name

    def initialize(name = "human", char = 'x')
     
      @name = name
      @char = char
    end

  end

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
      get_cell_coordinates(x,y).val = char
    end



    def winner?
      diagonal_wins? || anti_diagonal_wins? || row_wins? || column_wins?
    end

     def tie?
      @available_spaces.size == 0
    end


    def game_done?
      winner? || tie? ? true : false
    end

    def reset_board
      @grid = default
      @available_spaces = [1,2,3,4,5,6,7,8,9]
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

         
    #refactored with enumerable
    def diagonal_wins?
      chars = Array.new(@length)
      diag_chars = chars.each_with_index.map{|char, i| @grid[i][i].val}.reject{|item| item == ' '}
      diag_chars.size == @length && diag_chars.uniq.size == 1
    end
    #old version
      #i = 0
      #chars = []
      # while i < @length
      #   chars << @grid[i][i].val
      #   i+=1
      # end
      # diag_chars = chars.reject{|item| item == ' '}
     
      #refactored with emumerable
    def anti_diagonal_wins?
      anti_diag_chars = Array.new(@length).each_with_index.map{|char, i| @grid[i][(@length-1)-i].val}.reject{|item| item == ' '}
      anti_diag_chars.size == @length && anti_diag_chars.uniq.size == 1 
    end 
      # binding.pry
      # num == @length - 1
      # anti_diag_chars = Array.new(@length).each_with_index.map{|char, i| @grid[i][(@length-1)-i]}
      #   if anti_diag_chars.reject{|item| item.val == " "}.length == num
      #     next_move = anti_diag_chars.reject{|item| item.val != " "}.first
      #   end
      #anti_diag_chars.size == @length && anti_diag_chars.uniq.size == 1  
    
      #end
    #end

    #old version
    # i = 0
      # chars = []
      # while i < @length
      #   chars << @grid[i][(@length-1)-i].val
      #   i+=1
      # end
      # anti_diag_chars = chars.reject{|item| item == ' '}

      #wotk in progress
    def smart_computer_diag
      n = @length - 1
      i = 0
      chars = []
      while i < @length
        chars << @grid[i][(@length-1)-i]
        i+=1
      end
      binding.pry
      if chars.reject{|item| item.val == ' '} .length == n
        pos = chars.find{|item| item.val == ' '}
        return pos
      else
        false
      end
      end

    def row_wins?
      i = 0
      while i < @length
        y = 0
        while y < @length
          break if (@grid[i][y].val == " " ||   (@grid[i][y].val != @grid[i][y+1].val))
          y+=1
          return true if (y == @length - 1)
        end
        i+=1
      end
      false
    end
    
    

    def column_wins?
      y = 0
      while y < @length
        i = 0
        while i < @length
         break if (@grid[i][y].val == " " ||  @grid[i][y].val != @grid[i +1][y].val)
          i+=1
          return true if(i == @length - 1)
        end
         y+=1
      end
      false
    end

  end

  class Game
    attr_accessor :player,:computer, :players, :board, :current_player, :next_player

    def initialize(players, board = GameBoard.new)
      @computer = Player.new("Computer", "o")
      @player = Player.new
      @players = [@player, @computer]
      @board = board
      @current_player = @players.sample
    end

    def next_player
      @current_player == @player ? @current_player = @computer : @current_player = @player
    end

    def ask_current_player_move
      puts "#{@current_player.name}, choose a number from the grid to make your turn"
    end

    def computer_move
      puts "Computer's turn!"
      sleep 1.0
      if @board.smart_computer_diag
        @board.smart_computer_diag
      else
      @board.available_spaces.sample
      end
    end


    def get_current_players_move
      move = gets.chomp.to_i
    end
    

    def convert_move
      @current_player == @player ? the_move = get_current_players_move : the_move = computer_move
      if @board.available_spaces.include?(the_move)
        @board.available_spaces -= [the_move]
        return @board.grid_hash[the_move]
      else
        puts"please choose an available space"
        convert_move
      end
    end
    

    def game_over
      if (@board.winner? && @board.tie?) || @board.winner?
        puts "#{@current_player.name} won"
      else
       puts "Its a tie!"
      end 
    end

    def show_board                    
    puts "   #{@board.grid[0][0].val} |   #{@board.grid[0][1].val} |  #{@board.grid[0][2].val}"
    puts "--------------------"
    puts "   #{@board.grid[1][0].val} |   #{@board.grid[1][1].val} |   #{@board.grid[1][2].val}"
    puts "----------------"
    puts "   #{@board.grid[2][0].val} |  #{@board.grid[2][1].val}  |   #{@board.grid[2][2].val}"
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
        false
      else
        puts "Please enter valid response : y/n"
        play_again_input
      end
    end

    def prompt_for_player_name
      puts "please enter your name"
      get_player_details
    end

    def get_player_details
      @player.name = gets.chomp
    end

    def play_sequence
      show_board
      @current_player == @player ? ask_current_player_move : computer_move
      moves_convert = convert_move
      @board.set_cell(moves_convert[0],moves_convert[1], @current_player.char)
    end

    def game_over_sequence
      game_over
      show_board
      sleep 1.0    
      @board.reset_board 
    end


    def play
      prompt_for_player_name
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
end

  


