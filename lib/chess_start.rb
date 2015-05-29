require "./chess"

board = ChessBoard.new
chess = Chess.new(board)
chess.construct_board
chess.start