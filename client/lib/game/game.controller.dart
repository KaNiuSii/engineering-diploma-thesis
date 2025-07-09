import 'package:get/get.dart';
import 'package:chess/chess.dart' as ch;

class GameController extends GetxController {
  final ch.Chess _game = ch.Chess();
  ch.Chess get game => _game;

  void move(String from, String to) {
    final moved = _game.move({"from": from, "to": to});
    if (moved != null) update();
  }

  void reset() {
    _game.reset();
    update();
  }
}
