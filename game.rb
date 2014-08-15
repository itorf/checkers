# -*- coding: utf-8 -*-

require_relative 'board'
require_relative 'piece'
require_relative 'player'

class Game
  attr_accessor :board
  
  def initialize
    @board = Board.new
    @red_player = HumanPlayer.new(:r)
    @black_player = HumanPlayer.new(:b)
  end
  
  def play
    current_turn = @black_player
    until game_over?
      current_turn.play_turn(@board)
      current_turn = (current_turn == @red_player) ? @black_player : @red_player
    end
    
    if self.lost?(:r)
      puts "Black player won!"
    elsif self.lost?(:b)
      puts "Red player won!"
    else
      puts "No one won.."
    end
    @board.render_grid
  end

  def lost?(color)
    lost = true
    @board.grid.each do |row|
      lost = false if row.any? do |space| 
        next if space.nil?
        space.color == color
      end
    end   
    lost 
  end

  def game_over?
    self.lost?(:r) || self.lost?(:b)
  end
end