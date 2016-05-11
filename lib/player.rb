require_relative 'game.rb'
require_relative 'gameboard.rb'
require_relative 'cell.rb'
require 'pry'

class Player

  attr_reader  :char 
  attr_accessor :name

  def initialize(board)
    @board = board
  end

end

