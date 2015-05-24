require "./chesspiece"

class Rook < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :rook
  end

  def move_legal?(location)
    unless super(location) then return false end

    if is_horizontal_move?(location) then return true end
    if is_vertical_move?(location) then return true end

    false
  end
end