require "./chesspiece"

class Knight < ChessPiece

  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :knight
    #@symbol = { :black => "♞", :white => "♘" } #unicode
    @symbol = { :black => "n", :white => "N" }
  end

  def move_legal?(square)
    row_length = (@location[0] - square[0]).abs
    col_length = (@location[1] - square[1]).abs

    unless (row_length == 2 && col_length == 1) || (col_length == 2 && row_length == 1)
      return false
    end
    super(square)
  end

  #disable path checking for knight
  def path_clear?(square)
    true
  end

  #override to remove path checking
  def board_status_legal(square, capture)
    if check?(square, capture)
      return :illegal_causes_check     
    end
    true
  end

end