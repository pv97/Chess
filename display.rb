require_relative 'board'
require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],@board)
  end

  def render(highlight_pos)
    @board.grid.each_with_index do |row, i|
      row_string = ""
      row.each_with_index do |piece, j|
        tile = ""
        if [i,j] == highlight_pos
          tile = " #{piece.to_s} ".yellow
        elsif piece == NullPiece.instance
          tile = " #{piece.to_s} "
        else
          tile = " #{piece.to_s} ".colorize(piece.color)
        end
        back_ground = (i+j)%2 == 0 ? :yellow : :green
        back_ground = :red if [i,j] == @cursor.cursor_pos
        row_string << tile.colorize(:background => back_ground)
      end
      puts row_string
    end
    p
  end

end

# b = Board.new
# d = Display.new(b)
# p d.cursor.cursor_pos
# while true
#   d.cursor.get_input
#   p d.cursor.cursor_pos
#   d.render
# end
