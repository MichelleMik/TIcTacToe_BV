require "spec_helper"
module TicTacToe
  describe Player do
   
    it "can be initialized with valid input: name and character" do
      input = {name: "Bob", char: 'x'}
        expect{Player.new(input)}.to_not raise_error
    end
    
    it "cannot be initialized without a complete input hash" do
      input = {}
      expect{Player.new(input)}.to raise_error
    end

  end
end