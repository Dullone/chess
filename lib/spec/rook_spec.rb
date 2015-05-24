require "./rook"

describe Rook do
  let(:board)     { ChessBoard.new }
  let(:rook_3_3)  { Rook.new(board, [3,3], "black", false) }

  describe "#move_to" do 
    it "moves vertially" do 
      expect(rook_3_3.move_to([6,3])).to eql [6,3]
    end
    it "moves horizontal" do
      expect(rook_3_3.move_to([3,6])).to eql [3,6]
    end
    it "doesn't move diagonal" do 
      expect(rook_3_3.move_to([5,5])).to eql :illegal_move
    end
  end

end