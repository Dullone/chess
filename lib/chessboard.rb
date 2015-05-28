require "./chesspiece"
class ChessBoard
  @@empty_square = "_"
  attr_reader :positions, :captured_pieces
  def initialize
    clear_board
    @captured_pieces = []
    @last_capture = nil
  end

  def clear_board
    @positions = Array.new(8){Array.new(8, nil)}
  end

  def position_occupied?(square)
    @positions[square[0]][square[1]] != nil
  end

  def capture_piece(square)
    piece = get_piece(square)
    if piece
      remove_piece(square).type
      @captured_pieces << { :type => piece.type, :symbol => piece.symbol }
    end
    @last_capture = piece
  end

  def undo_last_capture
    if @last_capture && add_piece(@last_capture.location, @last_capture)
      piece =  @last_capture
      @last_capture = nil
      @captured_pieces.pop
      return piece
    else
      false
    end
  end

  def remove_piece(square)
    piece = nil
    if inbounds?(square)
      piece = @positions[square[0]][square[1]]
      @positions[square[0]][square[1]] = nil
    end
    piece
  end

  def inbounds?(square)
    square[0].between?(0,7) && square[1].between?(0,7)
  end

  def move_piece(from, destination)
    if position_occupied?(destination)
      return false
    else
      @positions[destination[0]][destination[1]] = @positions[from[0]][from[1]]
      @positions[from[0]][from[1]] = nil
    end
    destination
  end

  def swap_pieces(piece_one, piece_two)
    temp = @positions[piece_one[0]][piece_one[1]]
    @positions[piece_one[0]][piece_one[1]] = @positions[piece_two[0]][piece_two[1]]
    @positions[piece_two[0]][piece_two[1]] = temp
  end

  def add_piece(square, piece)
    if position_occupied? square
      return false
    else
      @positions[square[0]][square[1]] = piece
    end
    square
  end

  def get_piece(square)
    if inbounds?(square) then return @positions[square[0]][square[1]] end
    nil
  end

  def check(color = :both)
    white_king = find_piece(:king, :white).first
    black_king = find_piece(:king, :black).first

    if color == :both || color == :white
      each_piece do |piece|
        if piece.color == :black && piece.capture_legal?(white_king.location)
          puts "Checking color: #{color}. Check piece: #{piece.type}, #{piece.color}, #{Chess.convert_index_notation(piece.location)}, W King: #{white_king.location}"
          return piece
        end
      end
    end
    if color == :both || color == :black
      each_piece do |piece|
        if piece.color == :white && piece.capture_legal?(black_king.location)
          return piece
        end
      end
    end
    nil
  end

  def legal_move?
    each_piece do |piece|
      each_square do |square|
        if piece.move_legal?(square) then  return true end
      end
    end
    false
  end

  def any_legal_moves?(color)
    each_piece do |piece|
      if piece.color != color then next end
      each_index do |index|
        if piece.check_board_status(index) == :legal
          return true
        end
      end
    end
    false
  end

  def find_piece(type, side)
    pieces = []
    each_square do |square|
      if square != nil && square.type == type && square.color == side
        pieces << square
      end
    end
    pieces
  end

  def to_s
    string = "__________________\n"
    @positions.length.times do |i|
      string << row_to_s(i) << "\n"
    end
    string << "------------------\n"
    string << "  a b c d e f g h"
  end

  def row_to_s(row)
    string = (row + 1).to_s + "|"
    @positions[row].each do |square|
      if square == nil
        string << @@empty_square << "|"
      else
        string << square.symbol[square.color] << "|"
      end
    end
    string
  end

  def each_square
    @positions.each do |row|
      row.each do |square|
        yield square
      end
    end
  end

  def each_index
    8.times do |row|
      8.times do |col|
        yield [row, col]
      end
    end
  end

  def each_piece
    each_square do |square|
      if square != nil
        yield square
      end
    end
  end

end
