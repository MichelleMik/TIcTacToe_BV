require "spec_helper"
module TicTacToe
  describe Player do
   
    it "is initialized with default name of 'human'" do
        frank = Player.new
        expect frank.name.to eq("human")
    end

    it "is initialized with a default character of 'x'" do
       annie = Player.new
       expect annie.char.to eq('x')
    end

    it "can have its name changed upon user input" do
      bobbo = Player.new
      bobbo.name = "Bob"
      expect bobbo.name.to eq("Bob")
    end

  end
end