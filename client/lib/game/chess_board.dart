import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as ch;
import 'package:client/settings/board_color_scheme.dart';

/// Chess board widget with **working drag‑and‑drop**.
///
/// Key changes:
/// * Each tile is a **single DragTarget**; the piece sits *inside* it as a
///   Draggable, so hit‑testing works.
/// * Hover overlay appears because the target always receives pointer events.
/// * Debug output prints for every hover legality test.
/// * Uses the same `ch.Chess` instance you pass in – external controllers stay
///   in sync.
class ChessBoard extends StatefulWidget {
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
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  /* ─────────────────── utilities ─────────────────── */

  String _indexToSquare(int index) {
    final rank = widget.orientationWhite ? 7 - index ~/ 8 : index ~/ 8;
    final file = widget.orientationWhite ? index % 8 : 7 - index % 8;
    return '${'abcdefgh'[file]}${rank + 1}';
  }

  String _assetFor(ch.Piece piece) {
    final colour = piece.color == ch.Color.WHITE ? 'white' : 'black';
    final type = switch (piece.type) {
      ch.PieceType.KING => 'king',
      ch.PieceType.QUEEN => 'queen',
      ch.PieceType.ROOK => 'rook',
      ch.PieceType.BISHOP => 'bishop',
      ch.PieceType.KNIGHT => 'knight',
      _ => 'pawn',
    };
    return 'assets/pieces/${colour}_$type.png';
  }

  void _makeMove(String from, String to) {
    if (widget.game.move({'from': from, 'to': to, 'promotion': 'q'}) != null) {
      setState(() {});
    }
  }

  /* ─────────────────── build ─────────────────── */

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double tile = constraints.maxWidth / 8;
          return Stack(children: [_buildBoard(tile), _buildLabels()]);
        },
      ),
    );
  }

  /* ─────────────────── board grid ─────────────────── */

  Widget _buildBoard(double tile) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 64,
      itemBuilder: (_, index) {
        final square = _indexToSquare(index);
        final rank = 7 - index ~/ 8;
        final file = index % 8;
        final dark = (rank + file) % 2 == 0;
        final piece = widget.game.get(square);

        return DragTarget<String>(
          onWillAcceptWithDetails: (details) {
            final from = details.data;
            final legal = widget.game
                .moves({'square': from, 'verbose': true})
                .any((m) => m['to'] == square);
            debugPrint('Hover $from ➜ $square; legal=$legal');
            return legal;
          },
          onAcceptWithDetails: (d) => _makeMove(d.data, square),
          builder:
              (context, candidate, _) => Stack(
                children: [
                  Container(
                    width: tile,
                    height: tile,
                    color:
                        dark
                            ? widget.colorScheme.dark
                            : widget.colorScheme.light,
                  ),
                  if (candidate.isNotEmpty)
                    Container(
                      width: tile,
                      height: tile,
                      color: Colors.yellow.withOpacity(0.35),
                    ),
                  if (piece != null)
                    Center(
                      child: Draggable<String>(
                        data: square,
                        dragAnchorStrategy: childDragAnchorStrategy,
                        feedback: SizedBox.square(
                          dimension: tile,
                          child: Image.asset(
                            _assetFor(piece),
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                          ),
                        ),
                        childWhenDragging: const SizedBox.shrink(),
                        child: Image.asset(
                          _assetFor(piece),
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                    ),
                ],
              ),
        );
      },
    );
  }

  /* ─────────────────── labels ─────────────────── */

  Widget _buildLabels() {
    const files = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    return IgnorePointer(
      child: Column(
        children: List.generate(8, (row) {
          return Expanded(
            child: Row(
              children: List.generate(8, (col) {
                final isFile = row == 7;
                final isRank = col == 0;
                return Expanded(
                  child: Stack(
                    children: [
                      if (isFile)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Text(
                            widget.orientationWhite
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
                            widget.orientationWhite
                                ? '${8 - row}'
                                : '${row + 1}',
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
}
