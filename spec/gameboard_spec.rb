require "spec_helper"
module TicTacToe
  describe GameBoard  do
    it "should have three rows" do
    gameboard = GameBoard.new
    expect(gameboard.grid.size).to eq(3)
    end
  

    it "should have three columns" do
      gameboard = GameBoard.new
      gameboard.grid.each do |row|
        expect(row.size).to eq(3)
      end
    end
  end

  describe "#get_cell_coordinates" do
    it "should return a cell object when given grid coordinates" do
      @board = GameBoard.new
      x = 1
      y = 1
      expect(@board.get_cell_coordinates(x,y)).to be_a(Cell)
    end
  end
  describe "#set_cell" do
    it "should set cell location using x and y coordinages and player character" do
    @board = GameBoard.new
      x = 0
      y = 2
      char = 'x'
      @board.set_cell(x,y, char)
      expect(@board.grid[x][y].val).to eq(char)
    end
  end

  describe "#reset_board" do
    it "should return the grid to its default state with all cells set to a number : 1-9" do
      @board = GameBoard.new
      @board.available_spaces = [] 
      @board.reset_board
      expect(@board.available_spaces.size).to eq(9)
    end
  end

  describe "#diagonal_wins?" do
    it "should detect a win on the diagonal and return true when this occurs" do
      @board = GameBoard.new
      @board.set_cell(0,0, 'x')
      @board.set_cell(1,1,'x')
      @board.set_cell(2,2,'x')
      expect(@board.diagonal_wins?).to eq(true)
    end

    it "should not return true if there is no win on the diagonal" do
      @board = GameBoard.new
      @board.set_cell(0,0, 'x')
      @board.set_cell(1,1,'x')
      @board.set_cell(2,2,'o') 
      expect(@board.diagonal_wins?).to eq(false)
    end
  end

  describe "#column_or_row_wins?" do
    it "should detect a row win and return true when it occurs" do
      @board = GameBoard.new
      @board.set_cell(0,0, 'x')
      @board.set_cell(0,1,'x')
      @board.set_cell(0,2,'x') 
      expect(@board.column_or_row_wins?("row")).to eq(true)
    end

    it "should return false if no row wins are detected" do
      @board = GameBoard.new
      @board.set_cell(0,0, 'x')
      @board.set_cell(1,1,'o')
      @board.set_cell(2,2,'9') 
      expect(@board.column_or_row_wins?("row")).to eq(false)
    end
  end
  
  describe "#column_wins?" do
    it "should detect a column win and return true when it occurs" do
      @board = GameBoard.new
      @board.set_cell(0,1, 'x')
      @board.set_cell(1,1,'x')
      @board.set_cell(2,1,'x') 
      expect(@board.column_or_row_wins?("column")).to eq(true)
    end

    it "should return false if no column wins are detected" do
      @board = GameBoard.new
      @board.set_cell(0,0,'o')
      @board.set_cell(1,1,'o')
      @board.set_cell(2,2,'x') 
      expect(@board.column_or_row_wins?("column")).to eq(false)
    end
  end

end
