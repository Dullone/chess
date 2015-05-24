require "./chesspiece"

class Queen < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :rook
  end

  def move_to(square)
    unless move_legal?(square)
      return :illegal_move
    else
      case move_type(square)
        when :horizontal
          return move_horizontal(square)
        when :vertical
          return move_vertical(square)
        when :diagonal
          return move_diagonal(square)
      end
    end
    false
  end

  def move_legal?(square)
    unless super(location) then return false end

    if is_horizontal_move?(location) then return true end
    if is_vertical_move?(location) then return true end
    if is_diagonal_move?(location) then return true end

    false
  end
end