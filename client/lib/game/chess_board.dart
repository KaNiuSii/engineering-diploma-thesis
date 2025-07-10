import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as ch;
import 'package:client/settings/board_color_scheme.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({
    super.key,
    required this.game,
    required this.colorScheme,
    this.orientationWhite = true,
  });

  final ch.Chess game;
  final BoardColorScheme colorScheme;
  final bool orientationWhite;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(children: [_buildBoard(), _buildLabels(), _buildPieces()]),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 64,
      itemBuilder: (_, index) {
        final int rank = 7 - index ~/ 8;
        final int file = index % 8;
        final bool dark = (rank + file) % 2 == 0;
        return Container(color: dark ? colorScheme.dark : colorScheme.light);
      },
    );
  }

  Widget _buildLabels() {
    const files = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    return IgnorePointer(
      child: Column(
        children: List.generate(8, (row) {
          return Expanded(
            child: Row(
              children: List.generate(8, (col) {
                final bool isFile = row == 7;
                final bool isRank = col == 0;
                return Expanded(
                  child: Stack(
                    children: [
                      if (isFile)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Text(
                            orientationWhite
                                ? files[col]
                                : files.reversed.toList()[col],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      if (isRank)
                        Positioned(
                          top: 2,
                          left: 2,
                          child: Text(
                            orientationWhite ? '${8 - row}' : '${row + 1}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPieces() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 64,
      itemBuilder: (_, index) {
        final int rank = 7 - index ~/ 8;
        final int file = index % 8;
        final square = '${'abcdefgh'[file]}${rank + 1}';
        final piece = game.get(square);
        if (piece == null) return const SizedBox.shrink();

        String imagePath = '';
        switch (piece.type) {
          case ch.PieceType.KING:
            imagePath =
                'assets/pieces/${piece.color == ch.Color.WHITE ? 'white' : 'black'}_king.png';
            break;
          case ch.PieceType.QUEEN:
            imagePath =
                'assets/pieces/${piece.color == ch.Color.WHITE ? 'white' : 'black'}_queen.png';
            break;
          case ch.PieceType.ROOK:
            imagePath =
                'assets/pieces/${piece.color == ch.Color.WHITE ? 'white' : 'black'}_rook.png';
            break;
          case ch.PieceType.BISHOP:
            imagePath =
                'assets/pieces/${piece.color == ch.Color.WHITE ? 'white' : 'black'}_bishop.png';
            break;
          case ch.PieceType.KNIGHT:
            imagePath =
                'assets/pieces/${piece.color == ch.Color.WHITE ? 'white' : 'black'}_knight.png';
            break;
          case ch.PieceType.PAWN:
            imagePath =
                'assets/pieces/${piece.color == ch.Color.WHITE ? 'white' : 'black'}_pawn.png';
            break;
        }

        return Center(
          child: Image.asset(
            scale: piece.type == ch.PieceType.PAWN ? 0.18 : 0.15,
            imagePath,
            filterQuality: FilterQuality.none,
          ),
        );
      },
    );
  }
}
