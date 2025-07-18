import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as ch;
import 'package:client/app/settings/board_color_scheme.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({
    super.key,
    required this.game,
    required this.colorScheme,
    required this.historyCount, //only for obx xd
    this.orientationWhite = true,
    required this.madeMove,
    required this.gameStarted,
  });

  final ch.Chess game;
  final BoardColorScheme colorScheme;
  final bool orientationWhite;
  final Function madeMove;

  final int historyCount;

  final bool gameStarted;

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  String? _lastFrom;
  String? _lastTo;
  final List<String> _dragTargets = [];

  @override
  void initState() {
    super.initState();
    _syncLastMove();
  }

  @override
  void didUpdateWidget(covariant ChessBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.historyCount != oldWidget.historyCount) {
      _syncLastMove();
    }
  }

  void _syncLastMove() {
    final List moves = widget.game.getHistory({'verbose': true});
    if (moves.isNotEmpty) {
      final Map last = moves.last as Map<String, dynamic>;
      setState(() {
        _lastFrom = last['from'] as String?;
        _lastTo = last['to'] as String?;
      });
    }
  }

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
    widget.game.move({'from': from, 'to': to, 'promotion': 'q'});
    setState(() {
      _lastFrom = from;
      _lastTo = to;
      _dragTargets.clear();
    });
    widget.madeMove();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double tile = constraints.maxWidth / 8;
          return AbsorbPointer(
            absorbing: !widget.gameStarted,
            child: Stack(children: [_buildBoard(tile), _buildLabels()]),
          );
        },
      ),
    );
  }

  Widget _buildBoard(double tile) {
    if (widget.game.fen == ch.Chess.DEFAULT_POSITION) {
      _lastFrom = null;
      _lastTo = null;
    }
    final bool inCheck = widget.game.in_check;
    final bool inMate = widget.game.in_checkmate;

    String? kingSquare;
    if (inCheck || inMate) {
      final ch.Color sideToMove = widget.game.turn;
      for (int i = 0; i < 64; i++) {
        final sq = _indexToSquare(i);
        final p = widget.game.get(sq);
        if (p != null && p.type == ch.PieceType.KING && p.color == sideToMove) {
          kingSquare = sq;
          break;
        }
      }
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        childAspectRatio: 1,
      ),
      itemCount: 64,
      itemBuilder: (_, index) {
        final square = _indexToSquare(index);
        final rank = 7 - index ~/ 8;
        final file = index % 8;
        final dark = (rank + file) % 2 == 0;
        final piece = widget.game.get(square);

        final isLastMove = square == _lastFrom || square == _lastTo;
        final isDragTarget = _dragTargets.contains(square);
        final isKingInDanger = square == kingSquare;

        return DragTarget<String>(
          onWillAcceptWithDetails: (details) {
            final from = details.data;
            return widget.game
                .moves({'square': from, 'verbose': true})
                .any((m) => m['to'] == square);
          },
          onAcceptWithDetails: (d) => _makeMove(d.data, square),
          builder: (context, candidate, _) {
            // layers build bottom‑up
            final List<Widget> layers = [
              Container(
                width: tile,
                height: tile,
                color:
                    dark ? widget.colorScheme.dark : widget.colorScheme.light,
              ),
            ];

            if (isLastMove) {
              layers.add(
                Container(
                  width: tile,
                  height: tile,
                  color: widget.colorScheme.lastMove.withOpacity(0.35),
                ),
              );
            }

            if (isKingInDanger) {
              final color =
                  inMate
                      ? widget.colorScheme.check.withOpacity(0.55) // dark red
                      : widget.colorScheme.mate.withOpacity(0.45); // light red
              layers.add(Container(width: tile, height: tile, color: color));
            }

            if (isDragTarget) {
              layers.add(
                Center(
                  child: Container(
                    width: tile * 0.12,
                    height: tile * 0.12,
                    decoration: BoxDecoration(
                      color: widget.colorScheme.dragDot,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }

            if (candidate.isNotEmpty) {
              layers.add(
                Container(
                  width: tile,
                  height: tile,
                  color: widget.colorScheme.hover.withOpacity(0.35),
                ),
              );
            }

            if (piece != null) {
              layers.add(
                Center(child: _buildDraggablePiece(piece, square, tile)),
              );
            }

            return Stack(children: layers);
          },
        );
      },
    );
  }

  Widget _buildDraggablePiece(ch.Piece piece, String square, double tile) {
    final img = Image.asset(
      _assetFor(piece),
      fit: BoxFit.contain,
      filterQuality: FilterQuality.none,
    );

    final draggable = Draggable<String>(
      key: ValueKey(square),
      data: square,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: SizedBox.square(dimension: tile, child: img),
      childWhenDragging: const SizedBox.shrink(),
      onDragStarted: () {
        final targets =
            widget.game
                .moves({'square': square, 'verbose': true})
                .map((m) => m['to'] as String)
                .toList();
        setState(() {
          _dragTargets
            ..clear()
            ..addAll(targets);
        });
      },
      onDragEnd: (_) => setState(() => _dragTargets.clear()),
      child: img,
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeInBack,
      transitionBuilder:
          (child, anim) => ScaleTransition(scale: anim, child: child),
      child: draggable,
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
                            style: TextStyle(
                              fontSize: 20,
                              color: widget.colorScheme.labels,
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
                            style: TextStyle(
                              fontSize: 20,
                              color: widget.colorScheme.labels,
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
