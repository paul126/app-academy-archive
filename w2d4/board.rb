class Board

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def pieces
    @board.flatten.compact
  end


  def fill_board

    @board.each_with_index do |row, i|
      row.each_index do |j|
        if (i + j) % 2 == 1 && i < 3
          @board[i][j] = Piece.new([i, j], :black, self)
        elsif (i + j) % 2 == 1 && i > 4
          @board[i][j] = Piece.new([i, j], :red, self)
        end
      end
    end
  end

  def deep_dup
    duped_board = Board.new
    @board.each_with_index do |rows, i|
      rows.each_with_index do |tile, j|
        next if tile.nil?
        duped_board.board[i][j] = tile.deep_dup
        duped_board.board[i][j].board_reference = duped_board.board
      end
    end
    duped_board
  end

end
