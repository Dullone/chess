require "./chesspiece"

class Bishop < ChessPiece

  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :bishop
    @symbol = { :black => "♝", :white => "♗" }
  end

  def move_legal?(location)
    unless super(location) then return false end
    is_diagonal_move? location
  end

end