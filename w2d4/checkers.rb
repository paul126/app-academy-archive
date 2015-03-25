# encoding: utf-8
require 'colorize'
require 'byebug'

String.disable_colorization = false

class Checkers

  attr_accessor :game_board, :player1, :player2

  def initialize
    @game_board = Board.new
    @player1 = HumanPlayer.new(:black)
    @player2 = HumanPlayer.new(:red)
    @player1_turn = false
  end

  def play

    display_welcome_message
    get_player_names
    place_pieces

    until game_over?
      switch_player_turn
      print_current_board
      print_player_turn
      begin
        start = get_player_starting_piece
        check_start_position(start)
        moves = get_player_moves
        perform_player_moves(start, moves)
      rescue InvalidMoveError => e
        puts "#{e.message}"
        retry
      end
    end

    display_end_message

  end

  def display_welcome_message
    puts "Welcome to Checkers."
  end

  def display_end_message
    puts "Game over."
    puts "#{@player1_turn ? @player1.name : @player2.name} wins."
  end

  def get_player_names
    print "Player 1 (black)"
    @player1.get_name
    print "Player 2 (red)"
    @player2.get_name
  end

  def place_pieces
    @game_board.fill_board
  end

  def game_over?
    color_arr = []
    @game_board.pieces.each do |piece|
      color_arr << piece.color
    end
    !color_arr.include?(:black) || !color_arr.include?(:red)
  end

  def switch_player_turn
    @player1_turn = !@player1_turn
  end

  def print_player_turn
    puts "#{@player1_turn ? @player1.name : @player2.name} is up."
  end

  def get_player_starting_piece
    @player1_turn ? @player1.get_starting_piece : @player2.get_starting_piece
  end

  def get_player_moves
    @player1_turn ? @player1.get_moves : @player2.get_moves
  end

  def start_position(position)
    @game_board.board[position[0]][position[1]]
  end

  def perform_player_moves(start, moves)
    start_position(start).perform_moves(moves)
  end

  def check_start_position(start)
    if start_position(start).nil?
      raise InvalidMoveError.new "There's no piece there."
    elsif start_position(start).color != get_current_player_color
      raise InvalidMoveError.new "That's not your color."
    end
  end

  def get_current_player_color
    @player1_turn ? @player1.color : @player2.color
  end

  def print_current_board
    print " ABCDEFGH \n"
    @game_board.board.each_with_index do |rows, row|
      print "#{8 - row}"
      rows.each_with_index do |tile, col|
        if tile.nil?
          if (row.even? && col.even?) || (row.odd? && col.odd?)
            print " "
          else
            print " ".on_light_white
          end
        else
          if (row.even? && col.even?) || (row.odd? && col.odd?)
            print tile.render
          else
            print tile.render.on_light_white
          end
        end
      end
      print "\n"
    end
    print "\n"
    nil
  end

end
