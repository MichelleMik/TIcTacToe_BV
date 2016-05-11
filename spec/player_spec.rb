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

end
