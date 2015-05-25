require "./pawn"

describe Pawn do
  let(:board)        { ChessBoard.new }
  let(:pawn)         { Pawn.new(board, [6,0], "black", false) }
  
  describe "#move_to" do
    it "moves up one" do 
      expect(pawn.move_to([5,0])).to eql [5,0]
    end
    it "mvoes up two when not moved before" do 
      expect(pawn.move_to([4,0])).to eql [4,0]
    end
    it "doens't move up three" do 
      expect(pawn.move_to([3,0])).to eql :illegal_move
    end
    it "doens't move up horizontal" do 
      expect(pawn.move_to([6,1])).to eql :illegal_move
    end
    it "doesn't move diagonal" do 
      expect(pawn.move_to([5,1])).to eql :illegal_move
    end
  end
end