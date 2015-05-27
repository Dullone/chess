require "./chesspiece"

class Rook < ChessPiece
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :rook
    #@symbol = { :black => "♜", :white => "♖" } #unicode
    @symbol = { :black => "r", :white => "R" }
  end

  def move_legal?(square)
    unless is_horizontal_move?(square) || is_vertical_move?(square) 
      return false 
    end
    super(square)
  end

  def castle(square)
    change_location square
  end
end