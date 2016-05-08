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
    it "should convert x, and y grid coordinates to grid position" do
    @board = GameBoard.new
    x = 0
    y = 2
    expect(@board.get_cell_coordinates(x,y)).to eq([0,2])
    end
  end
end
