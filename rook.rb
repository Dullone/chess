require "./chesspiece"

class Rook < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :rook
  end

  def move_to(location)
    unless move_legal? 
      return "Illegal move"
    else
      case move_type
        when :horizontal
          return move_horizontal
        when :vertial
          return move_vertical
      end
    end
    false
  end

  def move_type(square)
    if move_legal?
      if is_horizontal_move 
        return :horizontal
      else
        return :vertial
      end
    end
    false
  end

  def move_legal?(location)
    status = is_horizontal_move? location
    if status == location then return true end
    status = is_vertical_move? location
    if status == location then return true end
    false
  end
end