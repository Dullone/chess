require "./chessboard"
require "./chesspiece"
require "./pawn"
require "./bishop"
require "./king"
require "./queen"
require "./rook"
require "./knight"

class Chess
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def construct_board
    #pawns
    8.times do |i|
      white_pawn = Pawn.new(@board, [1,i], :white, false)
      @board.add_piece([1,i], white_pawn)
      black_pawn = Pawn.new(@board, [6,i], :black, false)
      @board.add_piece([6,i], black_pawn)
    end
    #rooks
    @board.add_piece([7,0], Rook.new(@board, [7,0], :black, false))
    @board.add_piece([7,7], Rook.new(@board, [7,7], :black, false))
    @board.add_piece([0,0], Rook.new(@board, [0,0], :white, false))
    @board.add_piece([0,7], Rook.new(@board, [0,7], :white, false))
    #knights
    @board.add_piece([7,1], Knight.new(@board, [7,1], :black, false))
    @board.add_piece([7,6], Knight.new(@board, [7,6], :black, false))
    @board.add_piece([0,1], Knight.new(@board, [0,1], :white, false))
    @board.add_piece([0,6], Knight.new(@board, [0,6], :white, false))
    #bishops
    @board.add_piece([7,5], Bishop.new(@board, [7,5], :black, false))
    @board.add_piece([7,2], Bishop.new(@board, [7,2], :black, false))
    @board.add_piece([0,5], Bishop.new(@board, [0,5], :white, false))
    @board.add_piece([0,2], Bishop.new(@board, [0,2], :white, false))
    #kings
    @board.add_piece([7,4], King.new(@board, [7,4], :black, false))
    @board.add_piece([0,4], King.new(@board, [0,4], :white, false))
    #queens
    @board.add_piece([7,3], Queen.new(@board, [7,3], :black, false))
    @board.add_piece([0,3], Queen.new(@board, [0,3], :white, false))

  end
end

board = ChessBoard.new
chess = Chess.new(board)
chess.construct_board
puts board.to_s