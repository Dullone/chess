class ChessPiece
  def initialize(board, square)
    @location = square
  end

  def move_vertical(square)
    if board.inbounds? square && board.position_occupied? && square[1] == location[1]
      move_length = location - square
    else
      return false
    end

    step = move_length > 0 ? 1 : -1
    move_length.step(step) do
      if board.position_occupied? then return false end
    end

    board.move_piece square
  end

end