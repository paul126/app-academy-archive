# encoding: utf-8

class Chess

  attr_accessor :game_board, :player1_turn

  def initialize
    @game_board = Board.new
    @player1 = HumanPlayer.new("black")
    @player2 = HumanPlayer.new("white")
    @game_board.generate_board(@player1.color, @player2.color)
    @player1_turn = false
  end

  def play
    print_welcome
    get_player_names
    until @game_board.checkmate?(@player1.color) ||
          @game_board.checkmate?(@player2.color)
      switch_turn
      print_current_board
      puts "Current Turn: #{current_turn}"
      begin
        move_arr = ask_for_move
        @game_board.move(move_arr[0], move_arr[1], current_color)
      rescue ArgumentError => e
        puts "#{e.message}"
        retry
      end
    end

    print_win_message

  end

  def print_welcome
    puts "Welcome to Chess. Player 1 will be black, Player 2 will be white."
  end

  def print_win_message
    print_current_board
    puts "Congratulations #{current_turn}, you won!"
  end

  def get_player_names
    puts "Please enter Player 1's name: "
    @player1.name = gets.chomp
    puts "Please enter Player 2's name: "
    @player2.name = gets.chomp
  end

  def current_color
    @player1_turn ? @player1.color : @player2.color
  end

  def current_turn
    @player1_turn ? @player1.name : @player2.name
  end

  def ask_for_move
    @player1_turn ? @player1.play_turn : @player2.play_turn
  end

  def switch_turn
    @player1_turn = !@player1_turn
  end

  def print_current_board
    print " abcdefgh \n"
    @game_board.board.each_with_index do |row, x|
      print "#{8 - x}"
      row.each_with_index do |tile, y|
        if tile.nil?
          if (x.even? && y.even?) || (x.odd? && y.odd?)
            print " "
          else
            print " ".on_light_white
          end
        else
          if (x.even? && y.even?) || (x.odd? && y.odd?)
            print tile.display.encode('utf-8')
          else
            print tile.display.encode('utf-8').on_light_white
          end
        end
      end
      print "\n"
    end
    nil
  end



end
