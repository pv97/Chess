require_relative 'piece'

class Pawn < Piece

  attr_accessor :moved

  def initialize(pos,board,color)
    super
    @moved = false
    @sym = @color == :white ? "\u2659".encode('utf-8') : "\u265F".encode('utf-8')
  end

  def add_vector(vec1,vec2)
    if @color == :white
      x = vec1[0] - vec2[0]
    else
      x = vec1[0] + vec2[0]
    end
    y = vec1[1] + vec2[1]
    [x,y]
  end

  def to_s
    "P"
  end

  def moves(moving)
    valid_moves = []

    front = add_vector(@pos,[1,0])
    if @board[*front] == NullPiece.instance
      valid_moves << front if in_bounds?(front)
      unless @moved
        double = add_vector(@pos,[2,0])
        valid_moves << double if @board[*double] == NullPiece.instance
      end
    end

    [[1,-1],[1,1]].each do |dir|
      current = add_vector(@pos, dir)
      if in_bounds?(current) && @board[*current]!= NullPiece.instance
        valid_moves << current if enemy?(current)
      end
    end

    moving ? valid_moves.reject { |move| move_into_check?(move) } : valid_moves
  end
end
