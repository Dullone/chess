require "./chesspiece"

class Knight < ChessPiece

  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :knight
    #@symbol = { :black => "♞", :white => "♘" } #unicode
    @symbol = { :black => "n", :white => "N" }
  end

  def move_legal?(square)
    unless super(square) then return false end

    row_length = (@location[0] - square[0]).abs
    col_length = (@location[1] - square[1]).abs

    if row_length == 2 
      if col_length == 1
        return true
      end
    elsif col_length == 2
      if row_length == 1
        return true
      end
    end
    :illegal_move
  end

  #override to remove path checking
  def move_without_capture(square)
    if check?
      :illegal_causes_check
    else
      return change_location(square)
    end
  end

end