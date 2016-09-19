require_relative 'piece'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance} }
  end

  def move(start_pos, end_pos)
    raise "No piece at start_pos" if @grid[*start_pos] == NullPiece.instance
    raise "Invalid move" unless valid_move?(start_pos,end_pos)
    @grid[*end_pos] = @grid[*start_pos]
    @grid[*start_pos] = NullPiece.instance
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row,col,val)
    @grid[row][col] = val
  end

  
end

b = Board.new
b[0,0] = Rook.new([0,0],b,:white)
p b[0,0].moves
