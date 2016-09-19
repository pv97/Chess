require_relative 'sliding_pieces'
require_relative 'stepping_pieces'
require_relative 'pawn'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance} }
  end

  def move(start_pos, end_pos)
    raise "No piece at start_pos" if self[*start_pos] == NullPiece.instance
    # raise "Invalid move" unless valid_move?(start_pos,end_pos)
    self[*start_pos].pos = end_pos
    self[*end_pos] = self[*start_pos]
    self[*start_pos] = NullPiece.instance
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row,col,val)
    @grid[row][col] = val
  end

  def find_king(color)
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.class == King && piece.color == color
          return [i,j]
        end
      end
    end
  end

  def in_check?(color, pos=nil)
    pos ||= find_king(color)
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece != NullPiece.instance && piece.color == !color
          return true if piece.moves.include?(pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    king_pos = find_king(color)
    moves = self[*king_pos].moves
    return moves.all? { |move|in_check?(color, move) }
  end

  def deep_dup
    copy = Board.new
    @grid.each_with_index do |row,i|
      row.each_with_index do |piece,j|
        if piece == NullPiece.instance
          copy[i,j] = NullPiece.instance
        else
          copy[i,j] = piece.class.new([i,j],copy,piece.color)
        end
      end
    end
    copy
  end
end

b = Board.new
b[0,0] = Queen.new([0,0],b,:white)
b[4,4] = King.new([4,4],b,:white)
p b[0,0].moves
