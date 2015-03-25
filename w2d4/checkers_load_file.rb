require 'colorize'
require 'byebug'

require_relative("piece.rb")
require_relative("board.rb")
require_relative("human_player.rb")
require_relative("checkers.rb")

if $PROGRAM_NAME == __FILE__
  Checkers.new.play
end
