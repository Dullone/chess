require "./pawn"

describe Pawn do
  let(:board)        { ChessBoard.new }
  let(:pawn)         { Pawn.new(board, [6,0], :black) }
  let(:pawn_white)   { Pawn.new(board, [4,1], :white) }
  let(:king)         { King.new(board, [7,4], :black, false) }
  let(:king_white)   { King.new(board, [0,4], :white, false) }

  before(:each) do 
    board.add_piece(king.location, king)
    board.add_piece(king_white.location, king_white)
  end
  
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
    it "checks for en passant" do 
      board.add_piece(pawn_white.location, pawn_white)
      pawn.move_to([4,0])
      expect(pawn_white.en_passant_targets[0]).to eql pawn.location
    end
  end
end