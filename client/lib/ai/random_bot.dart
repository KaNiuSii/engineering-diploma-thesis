import 'dart:math';
import 'package:chess/chess.dart' as ch;
import 'package:client/ai/i_bot.dart';

class RandomBot implements IBot {
  final Random _rng;

  RandomBot({Random? rng}) : _rng = rng ?? Random();

  ch.Move chooseMove(ch.Chess game) {
    final List<ch.Move> moves = game.generate_moves();
    if (moves.isEmpty) {
      throw StateError('No legal moves – the game is over.');
    }
    return moves[_rng.nextInt(moves.length)];
  }

  @override
  Future<ch.Move> playMove(ch.Chess game) async {
    final mv = chooseMove(game);
    return mv;
  }
}
