require 'singleton'

class Piece
  def to_s
    "P"
  end
end

class NullPiece
  include Singleton

  def to_s
    "_"
  end
end
