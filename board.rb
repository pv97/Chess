require_relative 'piece'

class Board

  attr_reader :grid

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
