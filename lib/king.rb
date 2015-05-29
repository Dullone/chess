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
    castle_result = castle(square)
    case castle_result
    when square 
      return square
    when :casstle_passes_through_check
      return castle_result
    else
      return super(square)
    end
  end

  def castle(square)
    if @moved == true 
      return :illegal_castle_piece_moved 
    end
    if ((@location[1] - square[1]).abs != 2 && @location[0] != square[0])
      return :not_castle_position
    end

    @@castle_positions.each_value do |position|
      rook = @board.get_piece(position[:rook])
      if @location == position[:king] && rook != nil && rook.type == :rook && rook.moved == false && rook.color == @color
        if path_clear?(position[:rook])
          if castle_pass_through_check?(@location, square)
            return :casstle_passes_through_check
          end
          @board.get_piece(position[:rook]).castle(position[:rook_after])
          return @location = change_location(position[:king_after])
        end
      end
    end
    :illegal_caslte
  end

private
  def castle_pass_through_check?(start, end_location)
    direction = get_step(end_location[1] - start[1])
    check?([start[0], start[1] + direction], false) || check?(end_location, false)
  end
end
