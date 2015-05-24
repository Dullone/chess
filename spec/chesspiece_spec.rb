require "./chesspiece"

describe ChessPiece do
  let(:board) { ChessBoard.new }
  let(:piece) { ChessPiece.new(board, [3,3]) }
  describe "#move_vertical" do
    it "moves a piece vertically up" do 
      expect(piece.move_vertical([7,3])).to eql [7,3]
    end
    it "moves a piece vertically down" do 
      expect(piece.move_vertical([0,3])).to eql [0,3]
    end
  end
end