require_relative "lib/tic_tac_toe.rb"

 
puts "Welcome to tic tac toe"

TicTacToe::Game.new(@players).play
