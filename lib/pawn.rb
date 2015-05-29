require "./chesspiece"

class Pawn < ChessPiece
  attr_reader :en_passant_targets
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :pawn
    @en_passant_targets = nil
    #@symbol = { :black => "♟", :white => "♙" }#unicode
    @symbol = { :black => "p", :white => "P" }
  end

  def move_legal?(square)
    length = square[0] - @location[0]
    if @color == :white  && length < 0
      return false
    end
    if @color == :black && length > 0
      return false
    end
    length_abs = length.abs
    unless (@location[1] - square[1]) == 0 && ((length_abs <= 2 && @moved == false) || length_abs == 1)
      return false
    end

    super(square)
  end

  def capture_legal?(square)
    if (square[1] - @location[1]).abs == 1
      if    @color == :black && (square[0] - @location[0]) == -1
        return true
      elsif @color == :white && (square[0] - @location[0]) == 1
        return true
      else
        :piece_illegal_color
      end
    end
    false
  end

  def en_passant_check
    if pawns = pawn_adjacent
      pawns.each do |pawn|
        pawn.add_en_passant self.location
      end
    end
  end

  def add_en_passant(location)
    @en_passant_targets ||= []
    @en_passant_targets << location
  end

  def clear_en_passant_targets
    @en_passant_targets = nil
  end

  def change_location(square)
    position = super(square)
    if pawn_promote? then return :promote_pawn end
    position
  end

  def pawn_promote?
    if @color == :white && @location[0] == 7
      return true
    elsif @color == :black && @location[0] == 0
      return true
    end
    false
  end

  def add_promote_callback(method)
    @promote_callback_method = method
  end

  def move_to(square)
    if move_legal?(square)
      if (@location[0] - square[0]).abs == 2
        move_loc = move_without_capture(square)
        en_passant_check
        return move_loc
      end
      return move_without_capture(square)
    end
    if capture_legal?(square)
      piece = board.get_piece(square)
      if piece && piece.color != @color
        return move_with_capture(square)
      elsif piece == nil
        return :illegal_move
      else
        return :position_occupied
      end
    end
    :illegal_move
  end

  def move_without_capture(square)
    clear_en_passant_targets
    super(square)
  end

  def move_with_capture(square)
    clear_en_passant_targets
    super(square)
  end

  def pawn_adjacent
    left_side  = @board.get_piece([@location[0], location[1] - 1])
    right_side = @board.get_piece([@location[0], location[1] + 1])

    pawns = []
    if left_side && left_side.type == :pawn && left_side.color != @color
      pawns << left_side
    end
    if right_side && right_side.type == :pawn && right_side.color != @color
      pawns << right_side     
    end
    pawns
  end
end