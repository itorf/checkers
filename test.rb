require_relative 'board'
require_relative 'piece'
require_relative 'game'
require_relative 'player'

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  puts
  b.render_grid
  puts
  
  move_sequence = [[3,0]]
  b[[2,1]].perform_moves!(move_sequence)
  puts"move black"
  b.render_grid
  puts
  move_sequence = [[3,2]]
  b[[5,4]].perform_moves!(move_sequence)
  puts "move red"
  b.render_grid
  
  puts "move red"
  move_sequence = [[5,4]]
  b[[6,3]].perform_moves!(move_sequence)
  b.render_grid
  
  puts "jump black"
  move_sequence = [[4,1], [6,3], [7,4]]
  b[[2,3]].perform_moves(move_sequence)
  b.render_grid
  
  
  # #black jumping red sitch
 #  b.place_piece([0,1], :b)
 #  b.place_piece([1,2], :r)
 #  b.place_piece([0,5], :b)
 #  b.place_piece([1,4], :r)
 #  b.render_grid
 #  # p b[[0,1]].valid_jumping_moves
 #  # p b[[0,5]].valid_jumping_moves # expect [2,3]
 #  puts
 #  b[[0,5]].move([2,3])
 #  b.render_grid
 #  puts
 #  b[[2,3]].move([6,7])
 #  b.render_grid
 #  puts
 #  b[[0,1]].move([2,3])
 #  b.render_grid
  #
  # #red jumping black sitch
  # b.place_piece([7,1], :r)
  # b.place_piece([6,2], :b)
  # b.place_piece([7,5], :r)
  # b.place_piece([6,4], :b)
  # b.render_grid
  # puts
  # b[[7,5]].move([5,3])
  # b.render_grid
  # puts
  # b[[5,3]].move([1,7])
  # b.render_grid
  # puts
  # b[[7,1]].move([5,3])
  # b.render_grid
  # puts

end