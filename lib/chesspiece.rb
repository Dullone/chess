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

  def move_type(square)
    if move_legal?(square)
      if is_horizontal_move?(square)
        return :horizontal
      elsif is_vertical_move?(square)
        return :vertical
      else
        return :diagonal
      end
    end
    false
  end

  def move_to(square)
    if !move_legal?(square)
      return :illegal_move
    else
      return move(square)
    end
    false
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
    #File.open("var.log", "a") { |file| file.puts "square: #{square}, capture:#{capture} color: #{@color} type: #{@type}"  }
    old_location = @location.clone
    in_check = false
    
    if capture then @board.capture_piece(square) end
    change_location(square)

    if @board.check(@color) then in_check = true end

    change_location(old_location)
    if capture then @board.undo_last_capture end

    in_check
  end

  def move_legal? (location)
    board.inbounds?(location) && location != @location
  end

  def capture_legal?(square)
    move_legal? square
  end

  protected
  def move(square)
    if board.position_occupied?(square)
      loc = board.get_piece(square)
      File.open("var.log", "a") { |file| file.puts "self: #{@location} square: #{square}, piece:#{type}, color: #{color}, loc: #{loc} "  
      file.puts "board:\n#{board}"
      }
      if board.get_piece(square).color != @color
        return move_with_capture(square)
      else
        :position_occupied
      end
    else
      move_without_capture(square)
    end
  end

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

  def board_status_legal(square, capture)
    unless path_clear?(square)
      return :path_blocked
    end
    if check?(square, capture)
      return :illegal_causes_check     
    end
    true
  end

  def change_location(square)
    @moved = true
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