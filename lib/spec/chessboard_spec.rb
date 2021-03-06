require "./chesspiece"
require "./rook"
require "./king"
require "./chessboard"
require "./chess"

describe ChessBoard do
  let(:board)       { ChessBoard.new }
  let(:piece)       { double("chesspiece", :color => "black") }
  let(:king)        { King.new(board, [7,4], :white, false) }
  let(:rook_black)  { Rook.new(board, [7,0], :black, false) }
  let(:rook_white)  { Rook.new(board, [7,0], :white, false) }
  let(:king_black)  { King.new(board, [7,7], :black, false) }
  let(:bishop_black){ Bishop.new(board, [5,2], :black, false) }
  let(:pawn_white)  { Pawn.new(board, [6,6], :white, false) }
  let(:knight_black){ Knight.new(board, [5,5], :black, false) }
  let(:queen_black) { Queen.new(board, [1,4], :black, false) }
  let(:rook_capture){ {:type => rook_black.type, :symbol => rook_black.symbol} }
  let(:board_string){ "__________________\n1|_|_|_|_|_|_|_|_|\n2|_|_|_|_|_|_|_|_|\n" \
                       "3|_|_|_|_|_|_|_|_|\n4|_|_|_|_|_|_|_|_|\n5|_|_|_|_|_|_|_|_|\n" \
                       "6|_|_|_|_|_|_|_|_|\n7|_|_|_|_|_|_|_|_|\n8|_|_|_|_|_|_|_|_|\n------------------\n" \
                       "  a b c d e f g h" 
                         }
  def add_kings
    board.add_piece(king_black.location, king_black)
    board.add_piece(king.location, king)
  end
  def check_mate_position
    add_kings
    board.add_piece(rook_black.location, rook_black)
    board.add_piece(rook_black_check_2.location, rook_black_check_2)
   end

  describe "#add_piece" do 
    it "adds a piece" do
      board.add_piece [1,1], piece
      expect(board.positions[1][1]).to equal piece
    end
    it "doesn't add a piece when position occupied" do 
      board.add_piece [1,1], piece
      expect(board.add_piece([1,1], piece)).to equal false
    end
  end
  describe "move a piece" do 
    it "moves a piece" do 
      board.add_piece [1,1], piece
      board.move_piece [1,1], [2,2]
      expect(board.positions[2][2]).to eql piece
    end
    it "doesn't move a piece if the slot is occupied" do 
    end
  end
  describe "#to_s" do
    it "returns a chessbard as a string" do 
      expect(board.to_s).to eql board_string
    end
  end
  describe "#each_piece" do 
    it "gives back all the pieces" do
      board.add_piece(king.location, king)
      board.add_piece(rook_black.location, rook_black)
      array =[]
      board.each_piece {|p| array << p }
      expect(array).to eql [rook_black, king]
    end
  end
  describe "#check" do
    it "detects check of white king with rook_black" do
      add_kings
      board.add_piece(rook_black.location, rook_black)
      expect(board.check).to equal rook_black
    end    
    it "doesn't detect check of black king with blocked rook_white" do
      add_kings
      board.add_piece(rook_white.location, rook_white)
      expect(board.check).to equal nil
    end
    it "detects check of white king with black bishop" do 
      add_kings
      board.add_piece(bishop_black.location, bishop_black)
      expect(board.check).to equal bishop_black
    end
    it "detects check of black king with white pawn" do 
      add_kings
      board.add_piece(pawn_white.location, pawn_white)
      expect(board.check).to equal pawn_white
    end
    it "detects check of white king with black knight" do 
      add_kings
      board.add_piece(knight_black.location, knight_black)
      expect(board.check).to equal knight_black
    end
    it "detects check of white king with black queen" do 
      add_kings
      board.add_piece(queen_black.location, queen_black)
      expect(board.check).to equal queen_black
    end
  end
  describe "#capture_piece" do 
    it "removes the piece" do 
      board.add_piece(rook_black.location, rook_black)
      expect(board.capture_piece(rook_black.location)).to eql rook_black
    end
    it "tracks the captured piece" do 
      board.add_piece(rook_black.location, rook_black)
      board.capture_piece(rook_black.location)
      expect(board.captured_pieces.include?(rook_capture)).to eql true
    end
  end
  describe "#any_legal_moves?" do 
    let(:rook_black_check_2)      { Rook.new(board, [6,0], :black, false) }
    let(:rook_remove_checkmate)   { Rook.new(board, [1,3], :white, false) }
    let(:bishop_remove_checkmate) { Bishop.new(board, [3,6], :white, false) }
    let(:bishop_cant_remove_checkmate) { Bishop.new(board, [3,3], :white, false) }
    it "correctly identifies a legal pawn move" do
      board.add_piece(pawn_white.location, pawn_white)
      expect(board.any_legal_move?(:white)).to eql true
    end

    it "correctly identifies a legal king move" do 
      add_kings
      expect(board.any_legal_move?(:white)).to eql true
    end
    it "correctly identifies no legal moves, checkmate" do 
     check_mate_position
     expect(board.any_legal_move?(:white)).to eql false
    end
    it "correctly identifies a rook move to prevent checkmate" do 
     check_mate_position
     board.add_piece(rook_remove_checkmate.location, rook_remove_checkmate)
     expect(board.any_legal_move?(:white)).to eql true
    end
    it "correctly identifies a bishop move to prevent checkmate" do
      check_mate_position
      board.add_piece(bishop_remove_checkmate.location, bishop_remove_checkmate)
      expect(board.any_legal_move?(:white)).to eql true
    end
    it "correctly identifies a bishop that can not prevent checkmate" do
      check_mate_position
      board.add_piece(bishop_cant_remove_checkmate.location, bishop_cant_remove_checkmate)
      expect(board.any_legal_move?(:white)).to eql false
    end
  end

  describe "save game" do 
    it "saves the game" do
      add_kings
      board.save_board('./chess.yml')
      expect(File.exist?('./chess.yml')).to eql true
    end
  end

end
