class Piece

  DELTAS = [ [1, -1], [1,  1] ]

  attr_accessor :current_position, :color, :king, :board_reference

  def initialize(position, color, board_object)
    @current_position = position
    @color = color
    @board_object = board_object
    @board_reference = board_object.board
    @king = false
  end

  def perform_move(position)
    old_position = current_position
    @current_position = position
    update_position(old_position)
  end

  def perform_moves!(move_sequence)
    if !possible_slides.include?(move_sequence[0]) &&
       !possible_jumps.include?(move_sequence[0]) ||
       move_sequence.count < 1
      return false
    elsif move_sequence.count == 1 && possible_slides.include?(move_sequence[0])
      perform_slide(move_sequence[0])
      return true
    else
      perform_jumps!(move_sequence)
    end

  end

  def perform_jumps!(move_sequence)
    move_sequence.each do |move|
      if !perform_jump(move)
        return false
      end
    end
    true
  end

  def valid_move_sequence?(start, move_sequence)
    board_copy = @board_object.deep_dup
    board_copy.board[start[0]][start[1]].perform_moves!(move_sequence)
  end

  def deep_dup
   duped_piece = self.dup
   duped_piece.current_position = current_position
   duped_piece
  end

  def perform_slide(position)
    return false unless possible_slides.include?(position)
    perform_move(position)
    check_promote
    true
  end

  def perform_jump(position)
    return false unless possible_jumps.include?(position)
    capture_piece(between_position(position))
    perform_move(position)
    check_promote
    true
  end

  def capture_piece(position)
    @board_reference[position[0]][position[1]] = nil
  end

  def update_position(old_position)
    old_x, old_y = old_position[0], old_position[1]
    new_x, new_y = @current_position[0], @current_position[1]

    @board_reference[old_x][old_y] = nil
    @board_reference[new_x][new_y] = self

  end

  def possible_slides
    slides_arr = []

    slides_arr += up_moves
    slides_arr += down_moves

    slides_arr
  end

  def perform_moves(move_sequence)
    if !valid_move_sequence?(current_position, move_sequence)
      raise InvalidMoveError.new "Invalid move."
    else
      perform_moves!(move_sequence)
    end
  end

  def possible_jumps
    poss_jumps = []

    poss_jumps += up_moves(2)
    poss_jumps += down_moves(2)

    return poss_jumps if poss_jumps.empty?
    poss_jumps.select! { |pos| valid_jump?(pos) }

    poss_jumps
  end

  def up_moves(multiplier = 1)
    @king || @color == :black ? generate_moves(multiplier, 1) : []
  end

  def generate_moves(multiplier, up_or_down)
    move = [0,0]
    moves_arr = []

    2.times do |i|
      move[0] = current_position[0] + (DELTAS[i][0] * multiplier * up_or_down)
      move[1] = current_position[1] + (DELTAS[i][1] * multiplier * up_or_down)
      moves_arr << move if is_empty?(move)
      move = [0,0]
    end

    moves_arr
  end

  def down_moves(multiplier = 1)
    @king || @color == :red ? generate_moves(multiplier, -1) : []
  end

  def is_empty?(move)
    on_board?(move) && !has_piece?(move)
  end

  def on_board?(position)
    position[0].between?(0,7) && position[1].between?(0,7)
  end

  def has_piece?(position)
    !@board_reference[position[0]][position[1]].nil?
  end

  def valid_jump?(move)
    between_pos = between_position(move)
    return false if !has_piece?(between_pos)
    return false if @board_reference[between_pos[0]][between_pos[1]].color == @color
    true
  end

  def between_position(move)
    [(move[0] + current_position[0]) / 2, (move[1] + current_position[1]) / 2]
  end

  def check_promote
    if @color == :black && @current_position[0] == 7
      @king = true
    elsif @color == :red && @current_position[0] == 0
      @king = true
    end
    nil
  end

  def render
    if @color == :black && !@king
      "\u267B"
    elsif @color == :red && !@king
      "\u267B".colorize(:red)
    elsif @color == :black && @king
      "\u267C"
    elsif @color == :red && @king
      "\u267C".colorize(:red)
    end
  end

end

class InvalidMoveError < StandardError
end
