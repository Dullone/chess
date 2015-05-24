class ChessPiece
  attr_reader :location, :board

  def initialize(board, square, add_to_board = true)
    @location = square
    @board = board
    if add_to_board
      board.add_piece(self, square)
    end
  end

  def move_vertical(square)
    move_length = square[0] - @location[0]
    unless @board.inbounds?(square) && !@board.position_occupied?(square) && square[1] == @location[1]
      return false
    end

    step = move_length > 0 ? 1 : -1
    (0...move_length).each do |i|
      if @board.position_occupied?([(@location[0] +  (i + 1)*step), @location[1]]) then return false end
    end

    @board.move_piece  @location, square
  end

  def path_clear?(end_point)
    move_length_row = @location[0] - end_point[0]
    move_length_col = @location[1] - end_point[1]

    step_row = get_step move_length_row 
    step_col = get_step move_length_col 

    length = greater_difference(move_length_col, move_length_row)

    (1...length).each do |i|
      if board.position_occupied? ([@location[0] + (i * step_row), @location[1] + (i * step_col)])
        return false
      end
    end
    true
  end

  private

  def greater_difference(length_one, length_two)
    length = length_one.abs > length_two.abs ?  length_one : length_two
    length.abs
  end

  def get_step (size)
    size == 0 ? 0 : (size / size)
  end

end