import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as ch;
import 'package:client/settings/board_color_scheme.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({
    super.key,
    required this.game,
    required this.colorScheme,
    this.orientationWhite = true, // set orientation
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
        final bool dark = (rank + file) % 2 == 1;
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

        // Assuming piece widgets: you need to implement your own mapping from piece to widget
        return Center(child: Text('${piece.color}${piece.type}'));
      },
    );
  }
}
