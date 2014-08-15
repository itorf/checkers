require_relative 'piece'
require_relative 'game'
require_relative 'player'

class Board
  attr_accessor :grid
  
  def initialize(fill_board = true)
    @grid = Array.new(8) { Array.new(8) }
    populate_grid if fill_board
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end
  
  #can make private
  def populate_grid
    @grid.each_with_index do |row, idx1|
      next if (idx1 > 2 && idx1 < 5)
      idx1 < 3 ? color = :b : color = :r
      row.each_with_index do |space, idx2|
        if (idx1 + idx2).odd? 
          @grid[idx1][idx2] = Piece.new([idx1,idx2], color, self)
        end
      end
    end    
  end
  
  def render_grid
    @grid.each_with_index do |row, idx1|
      row.each_with_index do |space, idx2|
        if space.nil?
          print "_"
        else
          print "#{@grid[idx1][idx2].color}"
        end
        print "|"
      end
      print "\n"
    end
  end   
  
  def valid_pos?(pos)
    (pos[0].between?(0,7) && pos[1].between?(0,7)) && @grid[pos[0]][pos[1]].nil?
  end
end