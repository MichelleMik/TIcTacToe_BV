require_relative 'gameboard.rb'
require_relative 'game.rb'
require_relative 'player.rb'
require 'pry'

class Cell
  attr_accessor :val

  def initialize(value = " ")
    @val = value
  end

end