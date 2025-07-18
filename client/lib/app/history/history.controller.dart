import 'dart:async';

import 'package:client/db/model/game_history.dart';
import 'package:client/db/service/game_history.service.dart';
import 'package:client/routes/app_routes.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final GameHistoryService _history = Get.find();

  final RxList<GameHistory> games = <GameHistory>[].obs;

  late final StreamSubscription<List<GameHistory>> _sub;

  @override
  void onInit() {
    super.onInit();

    games.value = _history.all.reversed.toList();

    _sub = _history.watchAll().listen(
      (list) => games.value = list.reversed.toList(),
    );
  }

  void openGame(GameHistory g) => Get.toNamed(AppRoutes.game, arguments: g.pgn);

  Future<void> deleteGame(int idx) async =>
      _history.deleteAt(_history.all.length - 1 - idx);

  @override
  void onClose() {
    _sub.cancel();
    super.onClose();
  }
}
