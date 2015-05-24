require "chesspiece"

class King < ChessPiece
  
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :king
  end

  def move_legal?(square)
    castling
      (@location[0] - square[0]).abs == 1 && (@location[1] - square[1]).abs == 1
  end

  def castling
    
    if 
  end
end
