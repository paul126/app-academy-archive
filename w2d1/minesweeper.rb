require 'yaml'

SAVEFILE = 'saved_games.txt'

class Minesweeper


  def initialize
    @field = MineField.new
    @player = Player.new(prompt_for_player_name)
  end

  def play

    until game_over?
      display_field
      save_game if prompt_for_save == "Y"
      move_type = @player.get_move_type
      position = @player.get_move_position
      handle_move(move_type, position)
    end

    end_game
  end

  def prompt_for_player_name
    puts "Enter your name:"
    gets.chomp
  end

  def prompt_for_save
    puts "Would you like to save? (y/n)"
    response = gets.chomp.upcase
  end

  def save_game
    File.open(SAVEFILE, 'w') { |file| file.write self.to_yaml }
  end

  def handle_move(move_type, position)
    move_pos = @field.board[position[0]][position[1]]
    if move_type == "F"
      move_pos.flag = !move_pos.flag
    elsif move_pos.bombed?
      move_pos.revealed = true
    else
      @field.handle_adjacent_tiles(position)
    end
    nil
  end

  def game_over?
    won? || lost?
  end

  def won?
    @field.board.each_with_index do |row, i|
      row.each_index do |j|
        field_pos = @field.board[i][j]
        return false if !field_pos.revealed? && !field_pos.bombed?
      end
    end
    true
  end

  def lost?
    @field.board.each_with_index do |row, i|
      row.each_index do |j|
        field_pos = @field.board[i][j]
        return true if field_pos.revealed? && field_pos.bombed?
      end
    end
    false
  end

  def end_game
    puts ""
    puts "Game over."
    puts "You win!" if won?
    puts "You lose!" if lost?
    puts ""
    display_revealed_field
    return nil

  end

  def display_field
    @field.board.each do |row|
      row.each do |tile|
        if tile.flagged?
          print "F"
        elsif !tile.revealed?
          print "-"
        elsif tile.bombed?
          print "X"
        else
          print tile.adjacent_bombs.to_s
        end
      end
      puts ""
    end
  end

  def display_revealed_field
    @field.board.each do |row|
      row.each do |tile|
        if tile.flagged?
          print "F"
        elsif tile.bombed?
          print "X"
        else
          print tile.adjacent_bombs.to_s
        end
      end
      puts ""
    end
  end

end

class Player

  def initialize(name)
    @name = name
  end

  def get_move_type
    puts "Would you like to place or remove a flag (f) or check for a mine (m)?"
    response = gets.chomp.upcase
    begin
      if response != "F" && response != "M"
        raise ArgumentError.new "Must choose either m or f."
      end
    rescue ArgumentError
        puts "Invalid input."
        get_move_type
    end
    response
  end

  def get_move_position
    move_arr = []
    puts "Choose your destiny!"
    puts "Enter row index (0 to 8):"
    move_arr << gets.chomp.to_i
    puts "Enter column index (0 to 8):"
    move_arr << gets.chomp.to_i
    move_position_error(move_arr)
    move_arr
  end

  def move_position_error(move_arr)
    begin
      if !move_arr[0].between?(0, 8) || !move_arr[1].between?(0, 8)
        raise ArgumentError.new "Outside range of board."
      end
    rescue ArgumentError
      puts "Invalid position."
      get_move_position
    end
  end

end

class MineField

  attr_accessor :board

  NUMBER_OF_MINES = 10
  ADJACENT_TILE_POSITIONS = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, 1],
    [0, -1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]

  def initialize
    @board = Array.new(9) { Array.new(9) }
    fill_in_board
    place_bombs
    adjacent_to_bombs

  end


  def place_bombs
    mines_placed = 0

    until mines_placed == NUMBER_OF_MINES
      idx1 = rand(0..8)
      idx2 = rand(0..8)
      if !(@board[idx1][idx2]).bomb
        @board[idx1][idx2].bomb = true
        mines_placed += 1
      end
    end
  end

  def adjacent_to_bombs

    @board.each_with_index do |row, i|
      row.each_index do |j|
        adjacent = 0
        ADJACENT_TILE_POSITIONS.each do |pair|
          next if @board[i][j].bomb unless @board[i][j].nil?
          adjacent += 1 if @board[i+pair[0]][j+pair[1]].bomb unless outside_range?(i+pair[0], j+pair[1])
        end
        @board[i][j].adjacent_bombs = adjacent
      end
    end

  end

  def outside_range?(idx1, idx2)
    !idx1.between?(0, 8) || !idx2.between?(0, 8)
  end

  def fill_in_board
    @board.each_with_index do |row, i|
      row.each_index do |j|
        @board[i][j] = Tile.new
      end
    end
  end

  def handle_adjacent_tiles(position)
    move_pos = @board[position[0]][position[1]]
    move_pos.revealed = true
    modify_adjacent_tiles(position) if move_pos.adjacent_bombs == 0
  end

  def modify_adjacent_tiles(position)
    i = position[0]
    j = position[1]
    ADJACENT_TILE_POSITIONS.each do |pair|

      if !outside_range?(i+pair[0], j+pair[1]) && !@board[i+pair[0]][j+pair[1]].revealed?
        handle_adjacent_tiles([i+pair[0], j+pair[1]])
      end
    end
  end

end

class Tile
  attr_accessor :bomb, :flag, :revealed, :adjacent_bombs
  def initialize(bomb=false, adjacent=0)
    @bomb = bomb
    @flag = false
    @revealed = false
    @adjacent_bombs = adjacent
  end

  def bombed?
    @bomb
  end

  def flagged?
    @flag
  end

  def revealed?
    @revealed
  end


end

if __FILE__ == $PROGRAM_NAME
  puts "New game or load game? (N/L)"
  response = gets.chomp.upcase
  if response != "N" && response != "L"
    raise ArgumentError.new "Must choose either N or L."
  end
  if response == "L"
    #puts "Enter saved game name."
    game_name = File.read(SAVEFILE)
    YAML::load(game_name).play
  else
    minesweep = Minesweeper.new
    minesweep.play
  end


end
