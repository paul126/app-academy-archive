class Array
  def my_uniq
    return self if self.count <= 1

    self.each_with_object([]) do |element, uniq_arr|
      uniq_arr << element unless uniq_arr.include?(element)
      uniq_arr
    end

  end

  def two_sum
    return [] if self.empty?
    sum_arr = []
    sorted = self.sort
    self.each_index do |i|
      next if i + 1 == self.size
      (i + 1...self.count).each do |j|
        sum_arr << [i,j] if self[i] + self[j] == 0
      end
    end
    sum_arr
  end

end

class Hanoi

  attr_accessor :board

  def initialize
    @board = [[3,2,1],[],[]]
  end

  def won?
    x, y = [[],[3,2,1],[]], [[],[],[3,2,1]]
    @board == x || @board == y
  end

  def move(start, finish)
    if @board[start].empty?
      raise IllegalMoveError.new("No disc there.")
    elsif !@board[finish].empty?
      raise IllegalMoveError.new("Illegal move.") if @board[start].last > @board[finish].last
    end
    @board[finish] << @board[start].pop
  end

  def render
    @board.map{|tower| tower.join}.join("\n")
  end

  def display
    puts render
  end

  def play

    until won?
      display
      prompt_user
      move(0,1)
    end

  end

  def prompt_user

  end

end

class IllegalMoveError < StandardError
end


def my_transpose(arr)
  transpose_arr = Array.new(arr.size){Array.new}

  arr.each_with_index do |row, row_i|
    row.each_with_index do |num, col_i|
      transpose_arr[col_i] << num
    end
  end

  transpose_arr
end

def stock_picker(days)
  best_profit = 0
  best_pair = []

  days.each_index do |buy|
    (buy...days.size).each do |sell|
      profit = days[sell] - days[buy]
      if profit > 0 && profit > best_profit
        best_profit = profit
        best_pair = [buy,sell]
      end
    end
  end

  best_pair
end
