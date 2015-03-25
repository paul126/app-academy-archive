require 'array_tdd'

describe "Our special Array methods" do
  describe '#my_uniq' do

    let(:x) { x = Array.new}

    it "should only return unique elements for more complex array" do
      expect([1,1,2,2,2,3,4,4,5,5,5,6].my_uniq).to eq([1,2,3,4,5,6])
    end

    it "should return [] when called on []" do
      expect([].my_uniq).to eq([])
    end

    it "should return an array of 1 element to return itself" do
      a = [rand(100)]

      expect(a.my_uniq).to eq(a)
    end

    it "should return unique elements in the order they first appeared" do
      expect([5,4,4,3,6,6].my_uniq).to eq([5,4,3,6])
    end

    it "should not use Array#uniq to find answer" do
      a = [1,1,2]
      expect(a).not_to receive(:uniq)
      a.my_uniq
    end
  end

  describe '#two_sum' do

    it "should return positions of pairs that sum to zero" do
      expect([2,1,0,-1,-2].two_sum).to eq([[0,4], [1,3]])
    end

    it "should return an [] when called on []" do
      expect([].two_sum).to eq([])
    end

    it "should return [] if there are no pairs that sum to 0" do
      expect([1,2,3,4,5].two_sum).to eq([])
    end

    it "should return the index pairs sorted dictionary-style" do
      expect([-1,2,4,0,-2,1,-4,4].two_sum).to eq([[0,5], [1,4], [2,6], [6,7]])
    end

  end

end

describe "Towers of Hanoi" do

  let(:hanoi) {hanoi = Hanoi.new}

  describe "#initialize" do

    it "should initialize the game board correctly" do
      expect(hanoi.board).to eq([[3,2,1],[],[]])
    end

  end

  describe "#won?" do
    it "should return true if all the discs are in a new tower" do
      b = [[[3],[2,1],[]], [[],[],[3,2,1]]]

      hanoi.board = b[0]
      expect(hanoi.won?).to be(false)
      hanoi.board = b[1]
      expect(hanoi.won?).to be(true)
    end

    it "should return false if the discs are in the wrong order" do
      b = [[],[1,2,3],[]]
      hanoi.board = b

      expect(hanoi.won?).to be(false)
    end
  end

  describe "#move" do
    it "should move a disc from one tower to another" do
      hanoi.move(0,1)
      expect(hanoi.board).to eq([[3,2],[1],[]])
    end

    it "should raise an error if an illegal move" do
      b = [[3,2],[1],[]]
      hanoi.board = b

      expect { hanoi.move(2,1) }.to raise_error(IllegalMoveError, "No disc there.")
      expect { hanoi.move(0,1) }.to raise_error(IllegalMoveError, "Illegal move.")
    end
  end

  describe "#render" do
    it "should return the board as a string" do
      expect(hanoi.render).to eq("321\n\n")
    end
  end
end

describe "my_transpose" do
  it "should transpose an array of rows to an array of columns" do
    row_arr = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    col_arr = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]

    expect(my_transpose(row_arr)).to eq(col_arr)
    expect(my_transpose(col_arr)).to eq(row_arr)

  end

  it "should return an [] if the the array is empty" do
    expect(my_transpose([])).to eq([])
  end

  it "should work on arrays of different dimensions" do
    a = [[1,2],[3,4]]
    b = [[1,3],[2,4]]

    expect(my_transpose(a)).to eq(b)
  end
end

describe "stock_picker" do
  it "should return most profitable pair of days" do
    a = [50, 2, 5, 100, 50]

    expect(stock_picker(a)).to eq([1,3])
  end

  it "should return [] if one or no days given" do
    expect(stock_picker([1])).to eq([])
    expect(stock_picker([])).to eq([])
  end

  it "should return an [] if no pair yields profit" do
    a = [5,4,3,2,1]
    expect(stock_picker(a)).to eq([])
  end

end
