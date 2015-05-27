require "./chesspiece"

class Bishop < ChessPiece

  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :bishop
    #@symbol = { :black => "♝", :white => "♗" } #unicode
    @symbol = { :black => "b", :white => "B" }
  end

  def move_legal?(location)
    unless is_diagonal_move?(location) then return false end
    super(location)
  end

end