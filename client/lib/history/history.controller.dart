import 'package:client/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HistoryGame {
  HistoryGame(this.pgn);
  final String pgn;
}

class HistoryController extends GetxController {
  final games = <HistoryGame>[].obs;

  @override
  void onInit() {
    super.onInit();
    games.addAll([
      HistoryGame('1. e4 e5 2. Nf3 Nc6 3. Bb5 a6'),
      HistoryGame('1. d4 d5 2. c4 c6'),
    ]);
  }

  void openGame(HistoryGame g) => Get.toNamed(AppRoutes.game, arguments: g.pgn);
}
