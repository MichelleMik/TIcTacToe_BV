require "spec_helper"
module TicTacToe
  describe Game  do
    it "should be initialized with 2 players" do
      @game = Game.new
      expect(@game.players.size).to eq(2)
    end
      
    it "should be initialized with a gameboard" do
      @game = Game.new
      expect(@game.board).to be_a(GameBoard)
    end
  end

  describe "#next_player" do
    it "should switch the current player to next player" do
    @game = Game.new
    @game.current_player = @computer
    expect(@game.next_player).to eq(@game.player)
    end
  end

  describe "#computer_move" do
    it "should choose to block row wins" do
    @game = Game.new
    #binding.pry
    @game.board.grid[0][0].val = "x"
    @game.board.grid[0][1].val = "x"
    computer_move = @game.computer_move
    expect(computer_move).to eq([0,2])
    end
    it "should choose to block colum wins" do
      @game = Game.new
      @game.board.grid[0][0].val = "x"
      @game.board.grid[1][0].val = "x"
      computer_move = @game.computer_move
      expect(computer_move).to eq([2,0])
    end
    it "should choose to block diagonal wins" do
      @game = Game.new
      @game.board.grid[0][0].val = "x"
      @game.board.grid[1][1].val = "x"
      computer_move = @game.computer_move
      expect(computer_move).to eq([2,2])
    end
    it "should choose to block anti-diagonal wins" do
      @game = Game.new
      @game.board.grid[2][0].val = "x"
      @game.board.grid[1][1].val = "x"
      computer_move = @game.computer_move
      expect(computer_move).to eq([0,2])
    end
  end

  describe "#convert_move" do
    it "it should convert an available numbered move from 1-9 on grid to grid position" do
      @game = Game.new
      @game.board.available_spaces = [1,2,3,5,6,7,9]
      my_move = 6
      expect(@game.convert_move(my_move)).to eq([1,2])
    end
  end
  
end 


