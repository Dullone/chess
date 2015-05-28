class ChessPiece
  attr_reader :location, :board, :type, :moved, :color, :symbol

  def initialize(board, square, color, add_to_board = true)
    @location = square
    @board = board
    @color = color
    @type = nil
    @moved = false
    if add_to_board
      board.add_piece(square, self)
    end
  end

  def is_vertical_move?(square)
    square[1] == @location[1] 
  end

  def is_horizontal_move?(square)
    square[0] == @location[0]
  end

  def is_diagonal_move?(square)
    (@location[0] - square[0]).abs == (@location[1] - square[1]).abs
  end

  #returns position moved to or error type
  def move_to(square)
    if move_legal?(square) != true then return :illegal_move end
    if board.position_occupied?(square)
      if board.get_piece(square).color != @color
        puts "move with capture"
        return move_with_capture(square)
      else
        return :position_occupied
      end
    else
      puts "move without capture"
      return move_without_capture(square)
    end
  end

  def path_clear?(end_point)
    move_length_row = end_point[0] - @location[0]
    move_length_col = end_point[1] - @location[1]

    step_row = get_step move_length_row 
    step_col = get_step move_length_col 

    length = greater_difference(move_length_col, move_length_row)

    (1...length).each do |i|
      if board.position_occupied? ([@location[0] + (i * step_row), @location[1] + (i * step_col)])
        return false
      end
    end
    true
  end

  def check?(square, capture)
    old_location = [@location[0], @location[1]]
    in_check = false
    
    if capture then @board.capture_piece(square) end
    temp_change_location(square)

    if @board.check(@color) != nil then in_check = true end

    temp_change_location(old_location)
    if capture then @board.undo_last_capture end

    in_check
  end

  def move_legal? (location)
    board.inbounds?(location) && location != @location  && path_clear?(location)
  end

  def capture_legal?(square)
    move_legal? square
  end

  def board_status_legal(square, capture)
    unless path_clear?(square)
      return :path_blocked
    end
    if check?(square, capture)
      return :illegal_causes_check     
    end
    true
  end

  def check_board_status(square)
    if move_legal?(square) != true then return :illegal_move end
    if board.position_occupied?(square)
      if board.get_piece(square).color != @color
        if capture_legal?(square) && board_status_legal(square, true) == true
          return :legal
        end
      else
        :position_occupied
      end
    else
      if board_status_legal(square, false) == true
        :legal
      end
    end
  end

  protected

  def move_without_capture(square)
    status = board_status_legal(square, false)
    unless status == true
      return status
    end
    return change_location(square)
  end

  def move_with_capture(square)
    status = board_status_legal(square, true)
    unless status == true
      return status
    end
    board.capture_piece(square)
    change_location(square)
  end

  def change_location(square)
    @moved = true
    @location = board.move_piece(@location, square)
  end

  def temp_change_location(square)
    @location = board.move_piece(@location, square)
  end

  def greater_difference(length_one, length_two)
    length = length_one.abs > length_two.abs ?  length_one : length_two
    length.abs
  end

  def get_step (size)
    size == 0 ? 0 : (size / size.abs)
  end

end