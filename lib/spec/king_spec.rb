require "./king"
require "./bishop"

describe King do
  let(:board)       { ChessBoard.new }
  let(:king)         { King.new(board, [7,4], "black", false) }
  let(:rook_bl)      { Rook.new(board, [7,0], "black", false) }
  let(:rook_br)      { Rook.new(board, [7,7], "black", false) }
  let(:bishop)       { Bishop.new(board, [7,2], "black", false) }

  describe "#move_legal?" do 
    it "doesn't allow a two space move" do 
      board.add_piece(king.location, king)
      expect(king.move_to([7,6])).to eql :illegal_move
    end
    it "allows a 1 space move" do
      board.add_piece(king.location, king)
      expect(king.move_to([7,5])).to eql [7,5]
    end
  end

  describe "#castle" do
    it "castles black side, left" do
      board.add_piece(rook_bl.location, rook_bl)
      board.add_piece(king.location, king)
      expect(king.move_to([7,2])).to eql [7,2]
    end
    it "castles black side, right" do
      board.add_piece(rook_br.location, rook_br)
      board.add_piece(king.location, king)
      expect(king.move_to([7,6])).to eql [7,6]
    end
    it "doesn't castle if rook not respent" do
      board.add_piece(king.location, king)
      expect(king.castle).to eql :illegal_caslte
    end
    it "doesn't castle if blocked" do 
      board.add_piece(rook_bl.location, rook_bl)
      board.add_piece(king.location, king)
      board.add_piece(bishop.location, bishop)
      expect(king.castle).to eql :path_blocked
    end
  end
end