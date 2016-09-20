require_relative 'sliding_pieces'
require_relative 'stepping_pieces'
require_relative 'pawn'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance} }
    populate
  end

  def populate
    (0..7).each do |i|
      self[1,i] = Pawn.new([1,i],self,:blue)
      self[6,i] = Pawn.new([6,i],self,:white)
    end

    [0,7].each do |i|
      self[0,i] = Rook.new([0,i],self,:blue)
      self[7,i] = Rook.new([7,i],self,:white)
    end

    [1,6].each do |i|
      self[0,i] = Knight.new([0,i],self,:blue)
      self[7,i] = Knight.new([7,i],self,:white)
    end

    [2,5].each do |i|
      self[0,i] = Bishop.new([0,i],self,:blue)
      self[7,i] = Bishop.new([7,i],self,:white)
    end

    self[0,4] = King.new([0,4],self,:blue)
    self[7,4] = King.new([7,4],self,:white)

    self[0,3] = Queen.new([0,3],self,:blue)
    self[7,3] = Queen.new([7,3],self,:white)
  end

  def move(start_pos, end_pos)
    raise "No piece at start_pos" if self[*start_pos] == NullPiece.instance
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

  def in_check?(colorr, pos=nil)
    pos ||= find_king(colorr)
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece != NullPiece.instance && piece.color != colorr
          return true if piece.moves(false).include?(pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    possible_moves = []
    @grid.each_with_index do |row,i|
      row.each_with_index do |piece,j|
        unless piece == NullPiece.instance || piece.color != color
          possible_moves += piece.moves(true)
        end
      end
    end

    p "poss: #{possible_moves}"
    possible_moves.empty?

    # king_pos = find_king(color)
    # moves = self[*king_pos].moves(false) << king_pos
    # return moves.all? { |move| in_check?(color, move) }
  end

  def convert_pawn
    (0..7).each do |i|
      self[0,i] = Queen.new([0,i],self,:white) if self[0,i].is_a? Pawn
      self[7,i] = Queen.new([7,i],self,:white) if self[0,i].is_a? Pawn
    end
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
#
# b = Board.new
# b[0,0] = Queen.new([0,0],b,:white)
# b[4,4] = King.new([4,4],b,:white)
# p b[0,0].moves
