require "./chesspiece"

class Rook < ChessPiece
  def initialize(board, square, add_to_board = true)
    super(board, square, add_to_board)
    @type = :rook
  end
end