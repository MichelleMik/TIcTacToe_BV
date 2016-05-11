require "spec_helper"

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
  
  describe "#convert_move" do
    it "it should convert an available numbered move from 1-9 on grid to grid position" do
      @game = Game.new
      @game.board.available_spaces = [1,2,3,5,6,7,9]
      my_move = 6
      expect(@game.convert_move(my_move)).to eq([1,2])
    end
  end

  describe "#send_computer_move_to_convert" do
    it "should call the convert move method with the computer move" do
      @game = Game.new
      @game.board.grid[0][0].val = "x"
      @game.board.grid[1][0].val = 'x'
      move = @game.send_computer_move_to_convert
      expect(move).to eq([2,0])
    end
  end
  



