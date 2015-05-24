require "./chesspiece"
require "./queen"

describe Queen do 
  let(:board)     { ChessBoard.new }
  let(:queen_3_3) { Queen.new(board, [3,3], "black", false) }

  describe "#move_to" do 
    it "moves diagonal" do 
      expect(queen_3_3.move_to([5,5])).to eql [5,5]
    end
    it "moves horizontal" do 
      expect(queen_3_3.move_to([3,6])).to eql [3,6]
    end
    it "moves vertical" do 
      expect(queen_3_3.move_to([6,3])).to eql [6,3]
    end

  end

end