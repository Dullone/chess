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
      unless @board.any_legal_move? @board.current_player
        puts @board
        puts "Checkmate of #{@board.current_player}!"
        exit
      end
    end

  end

  def get_move(piece)
    got_move = false
    until got_move do
      print "#{@board.current_player.capitalize}, enter move for #{piece.type} at #{Chess.convert_index_notation(piece.location)}\n" \
            "Column(a-h), Row(1-8) (enter 'q' to change piece): "
      input = gets.chomp
      
      case input.strip.downcase 
      when 'q'
        return
      end

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
      puts "Enter 's' to save, 'load' to load saved game"
      print "#{@board.current_player.capitalize}, enter piece to move - column(a-h), row(1-8): "
      input = gets.chomp

      case input.strip.downcase 
      when 's'
        puts make_title "Game saved!"
        @board.save_board
        next
      when 'load'
        board = ChessBoard.load
        if board then 
          @board = board
          puts make_title "Game loaded!"
          return 
        end
      end

      input  = Chess.convert_input(input)
      if input != false
        piece = @board.get_piece(input)
        if piece != nil && piece.color == @board.current_player
          got_piece = true
        else
          puts "No #{@board.current_player} piece at #{Chess.convert_index_notation(input)}"
        end
      else
        puts "Not a valid input.  "
      end
    end
    get_move piece
  end

  def make_move?(piece, square)
    status = piece.move_to(square)
    if status == :promote_pawn then 
      promote_pawn(piece) 
      status = square
    end
    unless status == square
      puts "Error #{status}.  "
      return false
    end
    @board.change_player
    true
  end

  def Chess.convert_input(string)
    input = string.split(",")
    input_array = [nil, nil]
    if input[1] == nil then return false end
    input_array[1] = (input[1].strip.to_i - 1)
    if @@alph_rows.include?(input[0].downcase)
      input_array[0] = @@alph_rows.index(input[0])
    else
      return false
    end
    if input_array[0] < 8 && input_array[1] >= 0 && input_array[1]  < 8
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

  def make_title(string)
    "--------------------\n"\
    "#{string}\n"\
    "--------------------\n"
  end

  def promote_pawn(pawn)
    valid_answer = false
    until valid_answer do 
      puts "Promote pawn to"
      puts "'q' for queen, 'n' for knight"
      puts "'r' for rook,  'b' for bishop"
      print "choice: "
      choice = gets.chomp

      @board.remove_piece(pawn.location)
      valid_answer = true
      case choice.strip.downcase
      when 'q'
        @board.add_piece(pawn.location, Queen.new(@board, pawn.location, :black, false))
      when 'n'
        @board.add_piece(pawn.location, Knight.new(@board, pawn.location, :black, false))
      when 'r'
        @board.add_piece(pawn.location, Rook.new(@board, pawn.location, :black, false))
      when 'b'
        @board.add_piece(pawn.location, Bishop.new(@board, pawn.location, :black, false))
      else
        "Invalid choice: #{choice}"
        valid_answer  = false
      end
    end

  end
end
