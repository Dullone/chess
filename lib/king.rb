require "./chesspiece"

class King < ChessPiece
  @@castle_positions = {
    :c1 => { :side=>:white, :rook => [0,0],       :king => [0,4], 
                      :rook_after => [0,3], :king_after => [0,2] },
    :c2 => { :side=>:white, :rook => [0,7],       :king => [0,4], 
                      :rook_after => [0,5], :king_after => [0,6] },
    :c3 => { :side=>:white, :rook => [7,0],       :king => [7,4], 
                      :rook_after => [7,3], :king_after => [7,2] },
    :c4 => { :side=>:white, :rook => [7,7],       :king => [7,4], 
                      :rook_after => [7,5], :king_after => [7,6] }
    }

  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :king
    #@symbol = { :black => "♚", :white => "♔" } #unicode
    @symbol = { :black => "k", :white => "K" }
  end

  def move_legal?(square)
    unless (@location[0] - square[0]).abs <= 1 && (@location[1] - square[1]).abs <= 1
      return false
    end
    super(square)
  end

  def move_to(square)
    if castle(square) == square 
      square
    else
      return super(square)
    end
  end

  def castle(square)
    if @moved == true && (@location[1] - square[1]).abs == 2
      return :illegal_castle_piece_moved 
    end

    @@castle_positions.each_value do |position|
      rook = @board.get_piece(position[:rook])
      if @location == position[:king] && rook != nil && rook.type == :rook && rook.moved == false && rook.color == @color
        if path_clear?(position[:rook])
          @board.get_piece(position[:rook]).castle(position[:rook_after])
          return @location = change_location(position[:king_after])
        else
          return :path_blocked
        end
      end
    end
    :illegal_caslte
  end

end
