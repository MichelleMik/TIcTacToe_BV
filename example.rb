require_relative "lib/tic_tac_toe.rb"

 
puts "Welcome to tic tac toe"
bob = TicTacToe::Player.new("bob", "x")
frank = TicTacToe::Player.new("frank", "o")
players = [bob, frank]
TicTacToe::Game.new(players).play
