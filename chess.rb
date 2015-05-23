class ChessPiece

end

class ChessBoard
  initialize
    @positions = array.new(8){array.new(8, nil)}
  end

  def position_occupied?(square)
    @positions[square[0]][square[1]] != nil
  end
end