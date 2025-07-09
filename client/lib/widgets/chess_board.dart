import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as ch;

class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key, required this.game});
  final ch.Chess game;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemCount: 64,
        itemBuilder: (_, index) {
          final int rank = 7 - index ~/ 8;
          final int file = index % 8;
          final bool dark = (rank + file) % 2 == 1;
          return Container(color: dark ? Colors.brown : Colors.brown[200]);
        },
      ),
    );
  }
}
