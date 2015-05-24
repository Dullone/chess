require "./chesspiece"

class Rook < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :rook
  end

  def move_to(location)
    if status = move_vertical(location)
      return status
    elsif status = move_horizontal(location)
      return status
    else
      false
    end
  end

end