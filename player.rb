# -*- coding: utf-8 -*-
require_relative 'board'
require_relative 'piece'
require_relative 'game'

class HumanPlayer
  
  def initialize(color)
    @color = color
  end
  
  def play_turn(board)
    board.render_grid
    color = @color == :b ? "Black" : "Red"
    begin
      puts "#{color} Player's turn. (e.g b3 a4)"
      input = gets.chomp.split(" ")
      coords = []
      input.each do |coord|
        coord_arr = coord.split('')
        x, y = convert_input(coord_arr)
        coords << [x,y]
      end
    
      board[coords.shift].perform_moves(coords)
    rescue InvalidMoveError => e
      puts "Error: {#{e.message}}"
      retry
    end
  end
  
  def convert_input(letter_number)
    [(letter_number[1].to_i - 1), (letter_number[0].ord - 97)]
  end
end