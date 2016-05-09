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
      i = 0
       rows = []
      while i < @length
      row = []
      y = 0
        while y < @length
          row.push(@grid[i][y].val)
          y+=1
        end
        rows.push(row)
        i+=1
      end
      rows
    end

    def block_column_wins
      y = 0
      columns = []
      while y < @length
      column = []
      i = 0
        while i < @length
           column.push(@grid[i][y].val)
           i+=1
        end
        columns.push(column)
      y+=1
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

  class Game
    attr_accessor :player,:computer, :players, :board, :current_player, :next_player

    def initialize(board = GameBoard.new)
      @player = Player.new
      @computer = Player.new("Computer", "o")
      @players = [@player, @computer]
      @board = board
      random_first_player
    end

    def random_first_player
      @current_player = @players.sample
    end

    def next_player
      @current_player == @player ? @current_player = @computer : @current_player = @player
    end

    def computer_about_to_lose_row_or_column(type)
      method = self.board.send("block_#{type}_wins")
      keys = method.find{|item|item.uniq.size == 2 && item.any?{|item|item.is_a? Integer}}
    end


    def computer_about_to_lose_a_diag(type)
      method = self.board.send("#{type}_wins")
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
      convert_move(move)
    end

    def ask_current_players_move
      puts "#{@current_player.name}, choose a number from the grid to make your turn" 
      get_current_players_move
    end 

    def get_current_players_move
      move = gets.chomp.to_i
      if @board.available_spaces.include?(move)
          convert_move(move)
      else
        "Try again, this space is taken!"
        get_current_players_move
      end
    end

     def prompt_for_player_name
      puts "please enter your name"
      get_player_details
    end

    def get_player_details
      name = gets.chomp
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
      play_again_input
    end

    def play_again_input
      input = gets.chomp.downcase
      if input == 'y'
        random_first_player
        true
      elsif input == 'n'
        false
      else
        puts "Please enter valid response : y/n"
        play_again_input
      end
    end

   

    def play_sequence
      show_board
      @current_player == @player ? move = ask_current_players_move : move = computer_move
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
end

  


