require "spec_helper"
module TicTacToe
  describe Cell  do
    it "is initialized with ' ' by default" do
      cell = Cell.new
      expect(cell.val).to eq(" ")
    end

    it "can be initialized with a value of 'x' " do
      cell = Cell.new('x')
      expect(cell.val).to eq('x')
    end

    it "can be initialized with a value of 'o'" do
      cell = Cell.new('o')
      expect(cell.val).to eq('o')
    end

  end
end