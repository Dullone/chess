require "./king"
require "./bishop"

describe King do
  let(:board)     { ChessBoard.new }
  let(:king)      { King.new(board, [7,4], "black", false) }
  let(:rook)      { Rook.new(board, [7,0], "black", false) }
  let(:bishop)    { Bishop.new(board, [7,2], "black", false) }

  it "castles" do
    board.add_piece(rook.location, rook)
    board.add_piece(king.location, king)
    expect(king.castle).to eql [7,2]
  end
  it "doesn't castle if blocked" do 
    board.add_piece(rook.location, rook)
    board.add_piece(king.location, king)
    board.add_piece(bishop.location, bishop)
    expect(king.castle).to eql :path_blocked
  end
end