require "./bishop"

describe Bishop do
  let(:board)     { ChessBoard.new }
  let(:bishop_3_3)  { Bishop.new(board, [3,3], "black", false) }
  describe "#move_to" do
    it "doesn't move horizontal" do
      expect(bishop_3_3.move_to([5,3])).to eql :illegal_move
    end
    it "doesn't move vertical" do 
      expect(bishop_3_3.move_to([3,5])).to eql :illegal_move
    end
    it "moves diagonal" do 
      expect(bishop_3_3.move_to([5,5])).to eql [5,5]
    end
  end
  
end