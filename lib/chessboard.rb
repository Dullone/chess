require "./chess"
require "./chesspiece"
class ChessBoard
  @@empty_square = "_"
  attr_reader :positions
  def initialize
    clear_board
  end

  def clear_board
    @positions = Array.new(8){Array.new(8, nil)}
  end

  def position_occupied?(square)
    @positions[square[0]][square[1]] != nil
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

  def to_s
    string = "__________________\n"
    @positions.length.times do |i|
      string << row_to_s(i) << "\n"
    end
    File.open("var.log", "a") { |file| file.puts string  }
    string << "  a b c d e f g h"
  end

  def row_to_s(row)
    string = row.to_s + "|"
    @positions[row].each do |square|
      if square == nil
        string << @@empty_square << "|"
      else
        string << square.symbol[square.color] << "|"
      end
    end
    string
  end

end
