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

class SlidingPiece < Piece
  DIAGONALS = [[1,1],[1,-1],[-1,-1],[-1,1]]
  HORIZONTALS = [[1,0],[0,1],[-1,0],[0,-1]]

  def initialize(pos,board,color)
    super
  end

  def enemy?(pos)
    @color != @board[*pos].color
  end

  def moves(directions)
    valid_moves = []

    directions.each do |dir|
      current = add_vector(@pos,dir)
      while in_bounds?(current) && @board[*current] == NullPiece.instance
        valid_moves << current
        current = add_vector(current,dir)
      end
      if in_bounds?(current) && enemy?(current)
        valid_moves << current
      end
    end

    valid_moves
  end
end

class Bishop < SlidingPiece
  def initialize(pos,board,color)
    super
  end

  def moves
    super(DIAGONALS)
  end
end

class Rook < SlidingPiece
  def initialize(pos,board,color)
    super
  end

  def moves
    super(HORIZONTALS)
  end
end

class Queen < SlidingPiece
  def initialize(pos,board,color)
    super
  end

  def moves
    super(DIAGONALS+HORIZONTALS)
  end
end

class SteppablePiece
  def initialize(pos,board,color)
    super
  end

  def moves(directions)
    valid_moves = []

    directions.each do |dir|
      current = add_vector(@pos,dir)
      if in_bounds?(current) && (@board[*current] == NullPiece.instance || enemy?(current))
        valid_moves << current
      end
    end
    valid_moves
  end

end

class King < SteppablePiece
  DIRECTIONS = [[1,1], [1,0], [1,-1], [0,1], [0,-1], [-1,1], [-1,0], [-1,-1]]

  def initialize(pos,board,color)
    super
  end

  def moves
    super(DIRECTIONS)
  end

end

class NullPiece
  include Singleton

  def to_s
    "_"
  end
end
