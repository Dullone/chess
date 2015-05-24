require "./chesspiece"

describe ChessPiece do
  let(:board)     { ChessBoard.new }
  let(:piece_3_3) { ChessPiece.new(board, [3,3], "black", false) }
  let(:piece_3_4) { ChessPiece.new(board, [3,4], "black", false) }
  let(:piece_4_4) { ChessPiece.new(board, [4,4], "black", false) }
  let(:piece_1_1) { ChessPiece.new(board, [1,1], "black", false) }
  let(:piece_3_1) { ChessPiece.new(board, [1,1], "black", false) }

  describe "#move_vertical" do
    it "moves a piece vertically up" do 
      expect(piece_3_3.move_vertical([7,3])).to eql [7,3]
    end
    it "moves a piece vertically down" do 
      expect(piece_3_3.move_vertical([0,3])).to eql [0,3]
    end
  end
  describe "checking a move path" do 
    it "doesn't allow a horizontal if path is blocked" do 
      board.add_piece(piece_3_4.location, piece_3_4)
      expect(piece_3_3.path_clear?([3,5])).to equal false
      expect(piece_3_3.move_horizontal([3,5])).to equal :path_blocked
      board.add_piece(piece_3_1.location, piece_3_1)
      expect(piece_3_3.path_clear?([3,0])).to equal false
      expect(piece_3_3.move_horizontal([3,0])).to equal :path_blocked
    end
    it "doesn't allow a diagonal if path is blocked" do
      board.add_piece(piece_4_4.location, piece_4_4)
      expect(piece_3_3.path_clear?([5,5])).to eql false
      expect(piece_3_3.move_diagonal([5,5])).to eql :path_blocked
      board.add_piece(piece_1_1.location, piece_1_1)
      expect(piece_3_3.path_clear?([0,0])).to eql false
      expect(piece_3_3.move_diagonal([0,0])).to eql :path_blocked
    end
    it "detects a diagonal move" do 
      expect(piece_3_3.is_diagonal_move?([5,5])).to equal true
    end
  end
end