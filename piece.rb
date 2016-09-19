require 'singleton'

class Piece
  attr_accessor :pos, :board, :color

  def initialize(pos,board,color)
    @pos = pos
    @board = board
    @color = color
  end

  def in_bounds?(pos)
    if pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7
      false
    else
      true
    end
  end

  def to_s
    "P"
  end

  def add_vector(vec1,vec2)
    x = vec1[0] + vec2[0]
    y = vec1[1] + vec2[1]
    [x,y]
  end
end

class NullPiece
  include Singleton

  def to_s
    "_"
  end
end
