require "./chesspiece"

class Queen < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :queen
    #@symbol = { :black => "♛", :white => "♕" } #unicode
    @symbol = { :black => "q", :white => "Q" }
  end

  def move_legal?(square)
    unless super(square) then return false end

    if is_horizontal_move?(square) then return true end
    if is_vertical_move?(square) then return true end
    if is_diagonal_move?(square) then return true end

    false
  end
end