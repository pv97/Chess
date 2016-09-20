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
    @board.convert_pawn
  end

  def play
    until @board.checkmate?(@current_player.color)
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

  def get_input(message,highlight_pos=nil)
    input = nil
    while input.nil?
      puts message
      @display.render(highlight_pos)
      input = @display.cursor.get_input
    end
    input
  end

  def get_move
    pos = nil
    piece = nil
    until pos && piece != NullPiece.instance && piece.color == @color && !piece.moves(true).empty?
      pos = get_input("#{name}, select a piece to move")
      piece = @display.board[*pos]
    end
    move_pos = nil
    valid_moves = piece.moves(true)
    until move_pos && valid_moves.include?(move_pos)
      move_pos = get_input("#{name}, select a spot to move to",pos)
    end

    [pos,move_pos]
  end
end

class ComputerPlayer
  attr_accessor :name, :color,  :display

  def initialize(name)
    @name = "Computer"
  end

  def get_move
    enemy_pos = []
    friendly_pos = []
    @display.board.grid.each_with_index do |row,i|
      row.each_with_index do |piece,j|
        unless piece == NullPiece.instance
          friendly_pos << [i,j] if piece.color == @color
          enemy_pos << [i,j] unless piece.color == @color
        end
      end
    end

    possible_moves = Hash.new() {|h,v| h[v]=[] }
    friendly_pos.each do |pos|
      @display.board[*pos].moves(true).each do |move|
        possible_moves[pos] << move
        return [pos,move] if enemy_pos.include?(move)
      end
    end

    pos_sample = possible_moves.keys.sample
    move_sample = possible_moves[pos_sample].sample

    @display.render(nil)

    [pos_sample,move_sample]

  end
end

one = ComputerPlayer.new("one")
two = ComputerPlayer.new("two")
g = Game.new(one,two).play
