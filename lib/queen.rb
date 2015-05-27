require "./chesspiece"

class Queen < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :queen
    #@symbol = { :black => "♛", :white => "♕" } #unicode
    @symbol = { :black => "q", :white => "Q" }
  end

  def move_legal?(square)
    unless is_horizontal_move?(square) || is_vertical_move?(square) || is_diagonal_move?(square)
      return false
    end

    super(square)
  end

end