require "./chess"
require "./chesspiece"
class ChessBoard
  def initialize
    @positions = array.new(8){array.new(8, nil)}
  end

  def position_occupied?(square)
    @positions[square[0]][square[1]] != nil
  end

  def inbounds?(square)
  	square[0].between(0,7) && square[1].between(0,7)
  end

  def move_piece(from, destination)
    if position_occupied?(square, chesspiece)
      return false
    else
      @positions[destination[0]][destination[1]] = @positions[from[0]][from[1]]
      @positions[from[0]][from[1]] = nil
    end
    square
  end

end
