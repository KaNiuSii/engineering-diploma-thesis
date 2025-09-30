package main

import (
	ch "github.com/notnil/chess"
)

const Infinity = MATE_VALUE + 1_000_000

func FindBestMove(game *ch.Game, depth int) (*ch.Move, int) {
	alpha := -Infinity
	beta := Infinity
	var best *ch.Move

	pos := game.Position()
	switch pos.Status() {
	case ch.Checkmate:
		return nil, -MATE_VALUE
	case ch.Stalemate:
		return nil, 0
	}

	for _, mv := range pos.ValidMoves() {
		child := pos.Update(mv)
		score := -negamax(child, depth-1, depth, -beta, -alpha)
		if score > alpha {
			alpha = score
			best = mv
		}
	}
	return best, alpha
}

func negamax(pos *ch.Position, depth, maxDepth int, alpha, beta int) int {
	switch pos.Status() {
	case ch.Checkmate:
		return -MATE_VALUE + (maxDepth - depth)
	case ch.Stalemate:
		return 0
	}

	if depth == 0 {
		b := positionToBoard(pos)
		return Evaluate(&b)
	}

	best := -Infinity
	for _, mv := range pos.ValidMoves() {
		child := pos.Update(mv)
		score := -negamax(child, depth-1, maxDepth, -beta, -alpha)
		if score > best {
			best = score
		}
		if best > alpha {
			alpha = best
		}
		if alpha >= beta {
			break
		}
	}
	return best
}

func positionToBoard(pos *ch.Position) Board {
	var b Board

	// Kto na ruchu?
	if pos.Turn() == ch.White {
		b.SideToMove = White
	} else {
		b.SideToMove = Black
	}

	sqMap := pos.Board().SquareMap()
	for sq, piece := range sqMap {
		file := int(sq.File()) // 0–7
		rank := int(sq.Rank()) // 0–7 (a1 = 0)
		idx := rank*8 + file   // 0–63, zgodnie z Evaluate()

		color := White
		if piece.Color() == ch.Black {
			color = Black
		}

		var pIdx int
		switch piece.Type() {
		case ch.Pawn:
			pIdx = Pawn
		case ch.Knight:
			pIdx = Knight
		case ch.Bishop:
			pIdx = Bishop
		case ch.Rook:
			pIdx = Rook
		case ch.Queen:
			pIdx = Queen
		case ch.King:
			pIdx = King
		}

		b.Bitboards[color][pIdx] |= 1 << uint(idx)
	}
	return b
}
