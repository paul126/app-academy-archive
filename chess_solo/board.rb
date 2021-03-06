class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def generate_board(color1, color2)
    color_arr = [color1, color2]
    color_arr.each do |color|
      color == color1 ? (row = 0) : (row = 7)
      @board[row].each_index do |i|
        @board[row][i] = Rook.new([row, i], color, @board) if i == 0 || i == 7
        @board[row][i] = Knight.new([row, i], color, @board) if i == 1 || i == 6
        @board[row][i] = Bishop.new([row, i], color, @board) if i == 2 || i == 5
        @board[row][i] = Queen.new([row, i], color, @board) if i == 3 && color == color1
        @board[row][i] = Queen.new([row, i], color, @board) if i == 4 && color == color2
        @board[row][i] = King.new([row, i], color, @board) if i == 4 && color == color1
        @board[row][i] = King.new([row, i], color, @board) if i == 3 && color == color2
      end
      color == color1 ? (row = 1) : (row = 6)
      @board[row].each_index do |i|
        @board[row][i] = Pawn.new([row, i], color, @board)
      end
    end
    nil
  end

end
