import 'package:chess/chess.dart' as ch;

abstract class IBot {
  ch.Move playMove(ch.Chess game);
}
