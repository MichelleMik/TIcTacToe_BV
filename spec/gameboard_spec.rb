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
end