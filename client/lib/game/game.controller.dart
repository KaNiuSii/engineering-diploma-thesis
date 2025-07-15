import 'dart:math';
import 'package:get/get.dart';
import 'package:chess/chess.dart' as ch;

class GameController extends GetxController {
  final Rx<ch.Chess> game = ch.Chess().obs;

  final RxBool playerWhite = true.obs;

  final RxBool whiteAtBottom = true.obs;

  final RxInt historyVersion = 0.obs;

  void flipBoard() => whiteAtBottom.toggle();

  void changeSide() => playerWhite.toggle();

  void madeMove() => historyVersion.value++;

  void reset() {
    historyVersion.value = 0;
    game.value.reset();
    game.value = ch.Chess();
    update();
  }
}
