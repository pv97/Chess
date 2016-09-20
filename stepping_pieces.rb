require_relative 'piece'

class SteppingPiece < Piece
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

class King < SteppingPiece
  DIRECTIONS = [[1,1], [1,0], [1,-1], [0,1], [0,-1], [-1,1], [-1,0], [-1,-1]]

  def initialize(pos,board,color)
    super
  end

  def moves
    super(DIRECTIONS)
  end

  def to_s
    "K"
  end
end

class Knight < SteppingPiece
  DIRECTIONS = [[2,1], [2,-1], [-2, 1], [-2, -1],
                [1,2], [1, -2], [-1, 2], [-1,-2]]
  def initialize(pos,board,color)
    super
  end

  def moves
    super(DIRECTIONS)
  end

  def to_s
    "N"
  end
end
