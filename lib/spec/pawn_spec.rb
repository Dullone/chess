require "./pawn"

describe Pawn do
  let(:board)        { ChessBoard.new }
  let(:pawn)         { Pawn.new(board, [6,0], :black) }
  let(:pawn_white)   { Pawn.new(board, [4,1], :white) }
  let(:king)         { King.new(board, [7,4], :black, false) }
  let(:king_white)   { King.new(board, [0,4], :white, false) }
  let(:pawn_promote) { Pawn.new(board, [6,3], :white) }

  before(:each) do 
    board.add_piece(king.location, king)
    board.add_piece(king_white.location, king_white)
  end
  
  describe "#move_to" do
    it "moves up one" do 
      expect(pawn.move_to([5,0])).to eql [5,0]
    end
    it "doesn't move backward" do 
      expect(pawn.move_to([7,0])).to eql :illegal_move
    end
    it "moves up two when not moved before" do 
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
      expect(pawn.en_passant_target).to eql true
    end
    it "performs en passant" do
      board.add_piece(pawn_white.location, pawn_white)
      pawn.move_to([4,0])
      expect(pawn_white.move_to([5,0])).to eql [5,0]
      expect(board.get_piece(pawn.location)).to eql nil
    end
    it "isn't marked for en passant of no other pawns adjactent" do 
      pawn.move_to([4,0])
      expect(pawn.en_passant_target).to equal false
    end
    it "checks for promotion" do
      board.add_piece(pawn_promote.location, pawn_promote)
      expect(pawn_promote).to receive(:pawn_promote?).and_return(true)
      pawn_promote.move_to([7,3])
    end
  end
end