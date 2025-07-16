import 'package:client/ai/i_bot.dart';
import 'package:client/ai/random_bot.dart';
import 'package:get/get.dart';
import 'package:chess/chess.dart' as ch;

class GameController extends GetxController {
  final Rx<ch.Chess> game = ch.Chess().obs;

  final RxBool gameStarted = false.obs;

  final RxBool playerWhite = true.obs;

  final RxBool whiteAtBottom = true.obs;

  final RxInt historyVersion = 0.obs;

  final Rx<IBot> aiBot = RandomBot().obs;

  final RxBool aiThinking = false.obs;

  late final Worker _moveWorker;

  @override
  void onInit() {
    super.onInit();

    _moveWorker = ever<int>(historyVersion, (_) async {
      await Future.delayed(const Duration(milliseconds: 50));
      await makeAiMove();
    });
  }

  @override
  void onClose() {
    _moveWorker.dispose();
    super.onClose();
  }

  void flipBoard() => whiteAtBottom.toggle();

  void changeSide() => playerWhite.toggle();

  void madeMove() => historyVersion.value++;

  void reset() {
    historyVersion.value = 0;
    game.value.reset();
    game.value = ch.Chess();
    update();
  }

  Future<void> makeAiMove() async {
    if (game.value.game_over) {
      return;
    }

    if ((game.value.turn == ch.Color.WHITE && playerWhite.value == true) ||
        (game.value.turn == ch.Color.BLACK && playerWhite.value == false)) {
      return Future.value();
    }
    aiThinking.value = true;
    game.value.move(aiBot.value.playMove(game.value));
    aiThinking.value = false;
    historyVersion.value++;
    return Future.value();
  }
}
