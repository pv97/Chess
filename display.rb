require_relative 'board'
require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],@board)

  end

  def render
    @board.grid.each_with_index do |row, i|
      row_string = ""
      row.each_with_index do |piece, j|
        if [i,j] == @cursor.cursor_pos
          row_string << " #{piece.to_s} ".red
        else
          row_string << " #{piece.to_s} "
        end
      end
      puts row_string
    end
  end

  def method_name

  end
end

b = Board.new
d = Display.new(b)
p d.cursor.cursor_pos
while true
  d.cursor.get_input
  p d.cursor.cursor_pos
  d.render
end
