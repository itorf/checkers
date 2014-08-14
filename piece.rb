require_relative 'board'
require_relative 'game'
require_relative 'player'

class Piece
  attr_accessor :pos, :color, :board

  def initialize(pos, color, board)
    @color = color
    @pos = pos
    @board = board
    @king = false
  end
  
  def move(pos)
    if sliding_move?(pos)
      perform_slide(pos)
      return true
    elsif jumping_move?(pos)
      perform_jump(pos)
      return true
    end
    false
  end
  
  def sliding_move?(pos)
    self.valid_sliding_moves.include?(pos)
  end
  
  def jumping_move?(pos)
    self.valid_jumping_moves.include?(pos)
  end
  
  def valid_sliding_moves
    valid_slides = []
    cur_x, cur_y = @pos
    
    8.times do |i|
      move_diffs.each do |direction|
        new_x, new_y = direction[0] * i + cur_x, direction[1] * i + cur_y
        if @board.valid_pos?([new_x, new_y]) 
          prev_x, prev_y = (new_x-direction[0]), new_y-direction[1]
           if valid_slides.empty?
             valid_slides << [new_x, new_y] unless i > 1
           else
             if @board.valid_pos?([prev_x, prev_y]) 
               valid_slides << [new_x, new_y]
             elsif prev_x == cur_x && prev_y == cur_y
               valid_slides << [new_x, new_y]
             end
           end
        end
      end
    end
    valid_slides
  end
  
  def valid_jumping_moves
    valid_jumps = []
    cur_x, cur_y = @pos  
    move_diffs.each do |direction|
      new_x = direction[0] + cur_x
      new_y = direction[1] + cur_y
      next if board[[new_x,new_y]].nil?
      if board[[new_x,new_y]].color == @color 
        next
      else
        if board.valid_pos?([new_x + direction[0], new_y + direction[1]])
          valid_jumps << [new_x + direction[0], new_y + direction[1]]
        end
      end
    end
    valid_jumps
  end
  
  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    end
  end
  
  def perform_moves!(move_sequence)
    move_sequence.each do |possible_move|
      if !move(possible_move)
        raise "Can't execute that move"
      end
      if sliding_move?(possible_move)
        break
      end
    end
  end
  
  def valid_move_seq?(move_sequence)
    duped_board = Board.new(false)
    current_piece = @pos
    board.grid.each_with_index do |row, idx1|
      row.each_with_index do |element, idx2|
        next if element.nil?
        duped_board.grid[idx1][idx2] = Piece.new([idx1,idx2], element.color, duped_board)
      end
    end
    
    begin
      duped_board[current_piece].perform_moves!(move_sequence)
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
        
    
  
  #methods for single move
  def perform_slide(end_pos)
    board[@pos] = nil
    @pos = end_pos
    board[@pos] = self
  end
  
  #refactor
  def perform_jump(end_pos)
    if end_pos[1] > @pos[1]
      jumped_pos = [end_pos[0]-self.dir, end_pos[1]-1]
    else
      jumped_pos = [@pos[0]+self.dir, @pos[1]-1] 
    end   
    
    board[self.pos] = nil
    @pos = end_pos
    board[self.pos] = self
    board[jumped_pos] = nil
  end
  
  def move_diffs
    directions = [
      [self.dir, 1],
      [self.dir, -1]
    ]
    if @king
      directions << [self.dir * -1, 1] 
      directions << [self.dir * -1, -1] 
    end
    directions
  end
  
  
  def dir
    @color == :r ? -1 : 1
  end
  
  def maybe_promote
    #see if piece reached back row
  end
end

class InvalidMoveError < StandardError
end