require "./chesspiece"

class Pawn < ChessPiece
  attr_reader :en_passant_targets
  def initialize(board, square, color, add_to_board = true)
    super(board, square, color, add_to_board)
    @type = :pawn
    @en_passant_targets = nil
    #@symbol = { :black => "♟", :white => "♙" }
    @symbol = { :black => "p", :white => "P" }
  end

  def move_legal?(square)
    unless super(square)
      false
    end
    length = (@location[0] - square[0]).abs
    (@location[1] - square[1]) == 0 && ((length <= 2 && @moved == false) || length == 1)
  end

  def capture_legal?(square)
    if @color == :black
      (@location[1] - square[1]) == 1
    elsif color == :white
      (@location[1] - square[1]) == -1
    else
      :piece_illegal_color
    end
  end

  def en_passant_check
    if pawns = pawn_adjacent
      pawns.each do |pawn|
        pawn.add_en_passant self
      end
    end
  end

  def add_en_passant(pawn)
    @en_passant_targets ||= []
    @en_passant_targets << pawn
  end

  def clear_en_passant_targets
    @en_passant_targets = nil
  end

  def move(square)
    return_value = nil
    if (@location[0] - square[0]).abs == 2
      return_value = super(square)
      en_passant_check
    else
      return_value = super(square)
    end
    return_value
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