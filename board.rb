# -*- coding: utf-8 -*-
require_relative 'piece'
require_relative 'game'
require_relative 'player'
require 'colorize'

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
    system 'clear'
    print " a  b  c  d  e  f  g  h \n"
    @grid.each_with_index do |row, idx1|
      row.each_with_index do |space, idx2|
        if space.nil?
          print "   ".colorize(:background => :red) if (idx1 + idx2).even?
          print "   ".colorize(:background => :grey) if (idx1 + idx2).odd?
        else
          unless  @grid[idx1][idx2].king == true
            print " \u{25CF} " if @grid[idx1][idx2].color == :b
          else
            print " \u{26AB} " if @grid[idx1][idx2].color == :b
          end
          
          unless  @grid[idx1][idx2].king == true
            print " \u{26AC} " if @grid[idx1][idx2].color == :r
          else
            print " \u{26AA} " if @grid[idx1][idx2].color == :r
          end
        end
      end
      print " #{idx1+1}\n"
    end
  end   
  
  def valid_pos?(pos)
    (pos[0].between?(0,7) && pos[1].between?(0,7)) && @grid[pos[0]][pos[1]].nil?
  end
end