require_relative 'board'
require_relative 'piece'
require_relative 'game'
require_relative 'player'

if __FILE__ == $PROGRAM_NAME
 
 
  game = Game.new
  game.play

end