require "./chesspiece"
require "./chessboard"

describe ChessBoard do
  let(:board)       { ChessBoard.new }
  let(:piece)       { double("chesspiece", :color => "black") }
  let(:board_string){ "__________________\n0|_|_|_|_|_|_|_|_|\n1|_|_|_|_|_|_|_|_|\n" \
                       "2|_|_|_|_|_|_|_|_|\n3|_|_|_|_|_|_|_|_|\n4|_|_|_|_|_|_|_|_|\n" \
                       "5|_|_|_|_|_|_|_|_|\n6|_|_|_|_|_|_|_|_|\n7|_|_|_|_|_|_|_|_|\n  a b c d e f g h" }

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
end