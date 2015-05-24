require "./chesspiece"

class Rook < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :rook
  end

 #def move_to(location)
 #  unless move_legal? 
 #    return :illegal_move
 #  else
 #    case move_type(square)
 #      when :horizontal
 #        return move_horizontal(location)
 #      when :vertical
 #        return move_vertical(location)
 #    end
 #  end
 #  false
 #end

  def move_legal?(location)
    unless super(location) then return false end

    if is_horizontal_move?(location) then return true end
    if is_vertical_move?(location) then return true end

    false
  end
end