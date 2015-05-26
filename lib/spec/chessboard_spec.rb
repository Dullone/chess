require "./chesspiece"
require "./chessboard"

describe ChessBoard do
  let(:board)       { ChessBoard.new }
  let(:piece)       { double("chesspiece", :color => "black") }
  let(:king)        { King.new(board, [7,4], :white, false) }
  let(:rook)        { Rook.new(board, [7,0], :black, false) }
  let(:board_string){ "__________________\n1|_|_|_|_|_|_|_|_|\n2|_|_|_|_|_|_|_|_|\n" \
                       "3|_|_|_|_|_|_|_|_|\n4|_|_|_|_|_|_|_|_|\n5|_|_|_|_|_|_|_|_|\n" \
                       "6|_|_|_|_|_|_|_|_|\n7|_|_|_|_|_|_|_|_|\n8|_|_|_|_|_|_|_|_|\n------------------\n" \
                       "  a b c d e f g h" 
                         }

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
  describe "#each_piece" do 
    it "gives back all the pieces" do
      board.add_piece(king.location, king)
      board.add_piece(rook.location, rook)
      array =[]
      board.each_piece {|p| array << p }
      expect(array).to eql [rook, king]
    end
  end
  describe "#check" do
    it "detects check for white king" do
      board.add_piece(king.location, king)
      board.add_piece(rook.location, rook)
      expect(board.check).to equal rook
    end    
  end
  describe "#capture_piece" do 
    it "removes the piece" do 
      board.add_piece(rook.location, rook)
      expect(board.capture_piece(rook.location)).to equal rook
    end
  end

end