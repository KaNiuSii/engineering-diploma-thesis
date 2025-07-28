import 'package:chess/chess.dart' as ch;

abstract class IBot {
  Future<ch.Move> playMove(ch.Chess game);
}
