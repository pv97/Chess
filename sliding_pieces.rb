require_relative 'piece'

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
