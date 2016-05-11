require "spec_helper"
describe Player do

  describe Human do
   
    it "is initialized with default name of 'human'" do
        @board = GameBoard.new
        frank = Human.new(@board)
        expect(frank.name).to eq("human")
    end

    it "is initialized with a default character of 'x'" do
       @board = GameBoard.new
       annie = Human.new(@board)
       expect(annie.char).to eq('x')
    end

    it "can have its name changed upon user input" do
      @board = GameBoard.new
      bobbo = Human.new(@board)
      bobbo.name = "Bob"
      expect(bobbo.name).to eq("Bob")
    end
  end

  describe Computer do 
    it "is initialized with default name of 'Computer'" do
        @board = GameBoard.new
        computer = Computer.new(@board)
        expect(computer.name).to eq("computer")
    end
    it "is initialized with a default character of 'o'" do
       @board = GameBoard.new
       computer = Computer.new(@board)
       expect(computer.char).to eq('o')
    end
  end

   describe "#computer_move" do
    it "should choose to block row wins" do
    @game = Game.new
    @game.board.grid[0][0].val = "x"
    @game.board.grid[0][1].val = "x"
    computer_move = @game.board.grid_hash[@game.computer.computer_move]
    expect(computer_move).to eq([0,2])
    end
    it "should choose to block colum wins" do
      @game = Game.new
      @game.board.grid[0][0].val = "x"
      @game.board.grid[1][0].val = "x"
      computer_move = @game.board.grid_hash[@game.computer.computer_move]

      expect(computer_move).to eq([2,0])
    end
    it "should choose to block diagonal wins" do
      @game = Game.new
      @game.board.grid[0][0].val = "x"
      @game.board.grid[1][1].val = "x"
      computer_move = @game.board.grid_hash[@game.computer.computer_move]
      expect(computer_move).to eq([2,2])
    end
    it "should choose to block anti-diagonal wins" do
      @game = Game.new
      @game.board.grid[2][0].val = "x"
      @game.board.grid[1][1].val = "x"
      computer_move = @game.board.grid_hash[@game.computer.computer_move]

      expect(computer_move).to eq([0,2])
    end
  end

end
