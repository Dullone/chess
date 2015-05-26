require "./knight"

describe Knight do
  let(:board)        { ChessBoard.new }
  let(:knight)       { Knight.new(board, [7,1], :black, false) }
  describe "#move_to" do 
    it "moves two right one up" do 
      expect(knight.move_to([6,3])).to eql [6,3]
    end
    it "moves one right two up" do 
      expect(knight.move_to([5,2])).to eql [5,2]
    end
    it "moves one left two down" do 
      expect(knight.move_to([5,0])).to eql [5,0]
    end
    it "doens't move diagonal" do 
      expect(knight.move_to([5,3])).to eql [5,3]
    end
  end
end