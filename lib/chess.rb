require "./chessboard"
require "./pawn"
require "./bishop"
require "./king"
require "./queen"
require "./rook"
require "./knight"

class Chess
  @@alph_rows = Array('a'..'h')
  def initialize(board)
    @board = board
    @current_player = :white
  end

  def construct_board
    #pawns
    8.times do |i|
      white_pawn = Pawn.new(@board, [1,i], :white, false)
      @board.add_piece([1,i], white_pawn)
      black_pawn = Pawn.new(@board, [6,i], :black, false)
      @board.add_piece([6,i], black_pawn)
    end
    #rooks
    @board.add_piece([7,0], Rook.new(@board, [7,0], :black, false))
    @board.add_piece([7,7], Rook.new(@board, [7,7], :black, false))
    @board.add_piece([0,0], Rook.new(@board, [0,0], :white, false))
    @board.add_piece([0,7], Rook.new(@board, [0,7], :white, false))
    #knights
    @board.add_piece([7,1], Knight.new(@board, [7,1], :black, false))
    @board.add_piece([7,6], Knight.new(@board, [7,6], :black, false))
    @board.add_piece([0,1], Knight.new(@board, [0,1], :white, false))
    @board.add_piece([0,6], Knight.new(@board, [0,6], :white, false))
    #bishops
    @board.add_piece([7,5], Bishop.new(@board, [7,5], :black, false))
    @board.add_piece([7,2], Bishop.new(@board, [7,2], :black, false))
    @board.add_piece([0,5], Bishop.new(@board, [0,5], :white, false))
    @board.add_piece([0,2], Bishop.new(@board, [0,2], :white, false))
    #kings
    @board.add_piece([7,4], King.new(@board, [7,4], :black, false))
    @board.add_piece([0,4], King.new(@board, [0,4], :white, false))
    #queens
    @board.add_piece([7,3], Queen.new(@board, [7,3], :black, false))
    @board.add_piece([0,3], Queen.new(@board, [0,3], :white, false))

  end

  def start
    loop do
      puts @board
      get_piece
      unless @board.any_legal_move? @current_player
        puts "checkmate!"
        exit
      end
    end

  end

  def get_move(piece)
    got_move = false
    until got_move do
      print "Enter move for #{piece.type} at #{Chess.convert_index_notation(piece.location)}\n" \
            "Column(a-h), Row(1-8) (enter 'q' to change piece): "
      input = gets.chomp
      if input.strip.downcase == 'q' then return end
      move = Chess.convert_input(input)
      if move != false
        if make_move?(piece, move) then got_move = true end
      else
        print "Not a valid input.  "
      end
    end
  end

  def get_piece
    got_piece = false
    piece = nil
    until got_piece do
      print "Enter piece to move - column(a-h), row(1-8): "
      input = Chess.convert_input(gets.chomp)
      if input != false
        piece = @board.get_piece(input)
        if piece != nil && piece.color == @current_player
          got_piece = true
        else
          print "No #{@current_player} piece at #{input}"
        end
      else
        print "Not a valid input.  "
      end
    end
    get_move piece
  end

  def make_move?(piece, square)
    status = piece.move_to(square)
    unless status == square
      print "Error #{status}.  "
      return false
    end
    change_player
    true
  end

  def Chess.convert_input(string)
    input = string.split(",")
    input_array = [nil, nil]
    input_array[1] = (input[1].strip.to_i - 1)
    if @@alph_rows.include?(input[0].downcase)
      input_array[0] = @@alph_rows.index(input[0])
    else
      return false
    end
    if input_array[0] < 8 && input_array[1]  < 8
      puts "#{input_array}"
      return [input_array[1], input_array[0]] #reverse order
    end
    false
  end

  def Chess.convert_index_notation(index)
    if index[0] < 8 && index[0] >= 0 && index[1] >= 0 && index[1] < 8
      notation = ""
      notation << @@alph_rows[index[1]]
      notation << ", "
      notation << (index[0] + 1).to_s

      return notation
    end
    ""
  end

  private
  def change_player
    if @current_player == :white
      @current_player = :black
    else
      @current_player = :white
    end
  end

end

board = ChessBoard.new
chess = Chess.new(board)
chess.construct_board
chess.start