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
    length = @location[0] - square[0]
    if color == :white  && length > 0
      return :illegal_move
    end
    if color == :black && length < 0
      return :illegal_move
    end
    length_abs = length.abs
    unless (@location[1] - square[1]) == 0 && ((length_abs <= 2 && @moved == false) || length_abs == 1)
      return false
    end

    super(square)
  end

  def capture_legal?(square)
    if @color == :black
      (@location[1] - square[1]) == 1 && (@location[0] - square[0]) == 1
    elsif color == :white
      (@location[1] - square[1]) == -1 && (@location[0] - square[0]) == -1
    else
      :piece_illegal_color
    end
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
    if pawn_promote? then promote_pawn end
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

  def promote_pawn
    #TODO
    #add new  piece to board
    #check for check/checkmate
  end

  def move_to(square)
    if !move_legal?(square) then return :illegal_move end
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