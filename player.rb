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
    puts "#{color} Player's turn. Enter "
    input = gets.chomp.split(" ")
    coords = []
    input.each do |coord|
      coord_arr = coord.split('')
      x, y = convert_input(coord_arr)
      coords << [x,y]
    end
    
    p coords
    
    board[coords.shift].perform_moves(coords)
  end
  
  def convert_input(letter_number)
    [(letter_number[1].to_i - 1), (letter_number[0].ord - 97)]
  end
end