require "./chesspiece"

describe ChessPiece do
  let(:board)     { ChessBoard.new }
  let(:piece_3_3) { ChessPiece.new(board, [3,3], "black", false) }
  let(:piece_3_4) { ChessPiece.new(board, [3,4], "black", false) }
  let(:piece_4_4) { ChessPiece.new(board, [4,4], "black", false) }
  let(:piece_2_4) { ChessPiece.new(board, [2,4], "black", false) }
  let(:piece_1_1) { ChessPiece.new(board, [1,1], "black", false) }
  let(:piece_3_1) { ChessPiece.new(board, [1,1], "black", false) }

  describe "checking a move path" do 
    it "doesn't allow a horizontal if path is blocked" do 
      board.add_piece(piece_3_4.location, piece_3_4)
      expect(piece_3_3.path_clear?([3,5])).to equal false
      board.add_piece(piece_3_1.location, piece_3_1)
      expect(piece_3_3.path_clear?([3,0])).to equal false
    end
    it "doesn't allow a diagonal if path is blocked" do
      board.add_piece(piece_4_4.location, piece_4_4)
      expect(piece_3_3.path_clear?([5,5])).to eql false
      board.add_piece(piece_1_1.location, piece_1_1)
      expect(piece_3_3.path_clear?([0,0])).to eql false
    end
    it "doesn't allow a vertical if path blocked" do 
      board.add_piece(piece_4_4.location, piece_4_4)
      expect(piece_3_4.path_clear?([5,4])).to eql false
      board.add_piece(piece_2_4.location, piece_2_4)
      expect(piece_3_4.path_clear?([1,4])).to eql false
    end
    it "allows a move if path not blocked" do 
      expect(piece_3_4.path_clear?([1,4])).to eql true
      expect(piece_3_4.path_clear?([5,4])).to eql true
      expect(piece_3_3.path_clear?([3,0])).to eql true
      expect(piece_3_3.path_clear?([0,0])).to eql true
    end
  end
end