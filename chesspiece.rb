class ChessPiece
  def initialize(board, square)
    @location = square
    @board = board
  end

  def move_vertical(square)
    move_length = square[0] - @location[0]
    unless @board.inbounds?(square) && !@board.position_occupied?(square) && square[1] == @location[1]
      return false
    end

    step = move_length > 0 ? 1 : -1
    (0...move_length).each do |i|
      File.open("./vars.log", "a") { |io| io.puts "i: #{i} move_length#{move_length}" + ([(@location[0] +  (i + 1)*step), @location[1]]).to_s  }
      if @board.position_occupied?([(@location[0] +  (i + 1)*step), @location[1]]) then return false end
    end

    @board.move_piece  @location, square
  end

end