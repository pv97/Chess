require_relative 'display'
require_relative 'cursor'

class Game
  def initialize(player1,player2)
    @board = Board.new
    @display = Display.new(@board)
    @player1 = player1
    @player2 = player2
    @player1.color = :white
    @player2.color = :blue
    @player1.display = @display
    @player2.display = @display
    @current_player = @player1
  end

  def swap_players
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def play_turn
    start_pos, end_pos = @current_player.get_move
    @board.move(start_pos, end_pos)
  end

  def play
    until @board.checkmate?(:white) || @board.checkmate?(:blue)
      play_turn
      swap_players
    end
    swap_players
    puts "#{@current_player.name} wins!"
  end
end

class HumanPlayer
  attr_accessor :name, :color,  :display

  def initialize(name)
    @name = name
  end

  def get_input(message)
    input = nil
    while input.nil?
      puts message
      @display.render
      input = @display.cursor.get_input
    end
    input
  end

  def get_move
    pos = nil
    piece = nil
    until pos && piece != NullPiece.instance && piece.color == @color && !piece.moves.empty?
      pos = get_input("#{name}, select a piece to move")
      piece = @display.board[*pos]
    end
    move_pos = nil
    valid_moves = piece.moves
    until move_pos && valid_moves.include?(move_pos)
      move_pos = get_input("#{name}, select a spot to move to")
    end
    [pos,move_pos]
  end
end

one = HumanPlayer.new("one")
two = HumanPlayer.new("two")
g = Game.new(one,two).play
