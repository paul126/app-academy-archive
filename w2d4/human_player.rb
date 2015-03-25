class HumanPlayer

  POSITION_CONVERSION = {
      "A" => 0,
      "B" => 1,
      "C" => 2,
      "D" => 3,
      "E" => 4,
      "F" => 5,
      "G" => 6,
      "H" => 7,
      "8" => 0,
      "7" => 1,
      "6" => 2,
      "5" => 3,
      "4" => 4,
      "3" => 5,
      "2" => 6,
      "1" => 7,
    }

  attr_accessor :color, :name

  def initialize(color)
    @color = color
  end

  def get_name
    puts " enter your name: "
    @name = gets.chomp
  end

  def get_starting_piece

    begin
      puts "Enter the starting position."
      start = gets.chomp.upcase.split('')
    check_input(start)
    rescue ArgumentError => e
      puts "#{e.message}"
      retry
    end

      start.map! { |i| POSITION_CONVERSION[i] }
      start.reverse
  end

  def get_moves
    moves_arr = []
    thinking = true
    until !thinking
      moves_arr << get_next_position
      thinking = another_move?
    end
    moves_arr
  end

  def get_next_position
    begin
      puts "Enter next position."
      move = gets.chomp.upcase.split('')
      check_input(move)
    rescue ArgumentError => e
      puts "#{e.message}"
      retry
    end

    move.map! { |i| POSITION_CONVERSION[i] }
    move.reverse

  end

  def another_move?
    puts "Make another move? (y/n)"
    response = gets.chomp.upcase
    return true if response == "Y"
    false
  end

  def check_input(start)
    unless start.length == 2
      raise InvalidMoveError.new "Too many characters."
    end
    unless start[0].between?("A", "H")
      raise InvalidMoveError.new "Invalid letter input."
    end
    unless start[1].between?("1", "8")
      raise InvalidMoveError.new "Invalid number input."
    end
  end


end
