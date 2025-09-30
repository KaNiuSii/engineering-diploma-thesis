package main

import "math/bits"

const ( // kolory
	White = iota // 0
	Black        // 1
)

const ( // typy bierek
	Pawn   = iota // 0
	Knight        // 1
	Bishop        // 2
	Rook          // 3
	Queen         // 4
	King          // 5
)

var psqt = [...][64]int{
	Pawn:   [64]int(PAWN),
	Knight: [64]int(KNIGHT),
	Bishop: [64]int(BISHOP),
	Rook:   [64]int(ROOK),
	Queen:  [64]int(QUEEN),
}

var phaseWeight = []int{0, 1, 1, 2, 4, 0}

type Board struct {
	Bitboards  [2][6]uint64 // [color][pieceType]
	SideToMove int          // 0 = White, 1 = Black
}

func popLSB(bb *uint64) int {
	sq := bits.TrailingZeros64(*bb)
	*bb &= *bb - 1
	return sq
}

func mirror(sq int) int { return sq ^ 56 }

func Evaluate(b *Board) int {
	var mg, eg, phase int

	for piece := Pawn; piece <= King; piece++ {
		phase += bits.OnesCount64(b.Bitboards[White][piece]) * phaseWeight[piece]
		phase += bits.OnesCount64(b.Bitboards[Black][piece]) * phaseWeight[piece]

		bb := b.Bitboards[White][piece]
		for bb != 0 {
			sq := popLSB(&bb)

			mg += PIECES_CENTIPAWNS[piece]
			eg += PIECES_CENTIPAWNS[piece]

			if piece == King {
				mg += KING_MIDDLE_GAME[sq]
				eg += KING_END_GAME[sq]
			} else {
				mg += psqt[piece][sq]
				eg += psqt[piece][sq]
			}
		}

		bb = b.Bitboards[Black][piece]
		for bb != 0 {
			sq := popLSB(&bb)
			sqMir := mirror(sq)

			mg -= PIECES_CENTIPAWNS[piece]
			eg -= PIECES_CENTIPAWNS[piece]

			if piece == King {
				mg -= KING_MIDDLE_GAME[sqMir]
				eg -= KING_END_GAME[sqMir]
			} else {
				mg -= psqt[piece][sqMir]
				eg -= psqt[piece][sqMir]
			}
		}
	}

	// 24 = pełna faza (oba hetmany + 4 wieże + 4 figury lekkie)
	if phase > 24 {
		phase = 24
	}
	mid := mg * phase
	end := eg * (24 - phase)
	score := (mid + end) / 24

	if b.SideToMove == Black {
		score = -score
	}

	if score > MATE_VALUE {
		score = MATE_VALUE
	} else if score < -MATE_VALUE {
		score = -MATE_VALUE
	}
	return score
}
